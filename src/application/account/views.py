from rest_framework import status
from rest_framework.generics import GenericAPIView, UpdateAPIView, DestroyAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .models import Account

from .serializers import (
    AccountRegisterSerializer,
    LoginSerializer,
    LogoutSerializer,
    AccountUpdateSerializer,
)


class RegisterView(GenericAPIView):
    serializer_class = AccountRegisterSerializer

    def post(self, request):
        account = request.data
        serializer = self.serializer_class(data=account)

        if serializer.is_valid(raise_exception=True):
            serializer.save()
            account_data = serializer.data

            return Response(
                {"data": account_data, "message": "Conta criada com sucesso."},
                status=status.HTTP_201_CREATED,
            )

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class LoginView(GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        serializer = self.serializer_class(
            data=request.data, context={"request": request}
        )
        serializer.is_valid(raise_exception=True)

        return Response(serializer.data, status.HTTP_200_OK)


class LogoutView(GenericAPIView):
    serializer_class = LogoutSerializer
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid()
        serializer.save()
        return Response(status=status.HTTP_204_NO_CONTENT)
    

class AccountUpdateView(UpdateAPIView):
    serializer_class = AccountUpdateSerializer
    permission_classes = [IsAuthenticated]

    def get_object(self):
        return self.request.user

    def put(self, request, *args, **kwargs):
        account = self.get_object()

        data = request.data
        if account is not None:
            try:
                email = Account.objects.get(email=data["email"])
                return Response(status=status.HTTP_409_CONFLICT)
            except Account.DoesNotExist:
                account.username = data["username"]
                account.description = data["description"]
                account.email = data["email"]
                account.profile_image = data["profile_image"]
                account.set_password(data["password"])
                account.save(force_update=True)
                return Response(status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)
        
    def delete(self, request, *args, **kwargs):
        account = self.get_object()

        account.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)