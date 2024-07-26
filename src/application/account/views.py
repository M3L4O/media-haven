from rest_framework import status
from rest_framework.generics import GenericAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .serializers import (
    AccountRegisterSerializer,
    LoginSerializer,
    LogoutSerializer,
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
        return Response(status=status.HTTP_200_OK)