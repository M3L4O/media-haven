from rest_framework import status
from rest_framework.generics import (
    GenericAPIView,
    RetrieveUpdateDestroyAPIView,
    ListAPIView,
)
from rest_framework.parsers import FileUploadParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .models import Audio, Image
from .serializers import (
    AudioUploadSerializer,
    AudioSerializer,
    ImageUploadSerializer,
    ImageSerializer,
)


class ImageUploadView(GenericAPIView):
    permission_classes = [IsAuthenticated]
    parser_class = (FileUploadParser,)
    serializer_class = ImageUploadSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(
            data=request.data, context={"request": request}
        )
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ImageListView(ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ImageSerializer

    def get_queryset(self):
        user = self.request.user
        return Image.objects.filter(account=user)


class ImageDetailView(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ImageSerializer

    def get_object(self, id):
        try:
            return Image.objects.get(pk=id)
        except Image.DoesNotExist:
            return None

    def get(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        image = self.get_object(id)
        if image is not None:
            serializer = self.serializer_class(image)
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def delete(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        image = self.get_object(id)
        if image is not None:
            image.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)


class AudioUploadView(GenericAPIView):
    permission_classes = [IsAuthenticated]
    parser_class = (FileUploadParser,)
    serializer_class = AudioUploadSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(
            data=request.data, context={"request": request}
        )
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class AudioListView(ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = AudioSerializer

    def get_queryset(self):
        user = self.request.user
        return Audio.objects.filter(account=user)


class AudioDetailView(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = AudioSerializer

    def get_object(self, id):
        try:
            return Audio.objects.get(id=id)
        except Audio.DoesNotExist:
            return None

    def get(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        audio = self.get_object(id)
        if audio is not None:
            serializer = self.serializer_class(audio)
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def delete(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        audio = self.get_object(id)
        if audio is not None:
            audio.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)