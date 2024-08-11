from rest_framework import status
from rest_framework.generics import (
    GenericAPIView,
    RetrieveUpdateDestroyAPIView,
    ListAPIView,
)
from rest_framework.parsers import FileUploadParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
import json

from .models import Audio, Image, Video
from .serializers import (
    AudioUploadSerializer,
    AudioSerializer,
    ImageUploadSerializer,
    ImageSerializer,
    VideoUploadSerializer,
    VideoSerializer,   
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
        print(user)
        images = Image.objects.filter(account=user)
        print(images)
        return images


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

    def put(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        image = self.get_object(id)
        data = request.data
        if image is not None:
            image.width = data["width"]
            image.height = data["height"]
            image.color_depth = data["color_depth"]
            image.thumbnail = data["thumbnail"]
            image.save(force_update=True)
            return Response(status=status.HTTP_200_OK)
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

    def put(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        audio = self.get_object(id)
        data = request.data
        
        if audio is not None:
            audio.sampling_rate = data["sample_rate"]
            audio.bitrate = float(data["bitrate"])
            audio.duration = data["duration"]
            audio.stereo = int(data["channels"]) > 1
            audio.save(force_update=True)
            return Response(status=status.HTTP_200_OK)
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


class VideoListView(ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = VideoSerializer

    def get_queryset(self):
        user = self.request.user
        return Video.objects.filter(account=user, original_video=None)

class VideoUploadView(GenericAPIView):
    permission_classes = [IsAuthenticated]
    parser_class = (FileUploadParser,)
    serializer_class = VideoUploadSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(
            data=request.data, context={"request": request}
        )
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
class VideoDetailView(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = VideoSerializer

    def get_object(self, id):
        try:
            return Video.objects.get(id=id)
        except Video.DoesNotExist:
            return None

    def get(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        video = self.get_object(id)
        if video is not None:
            serializer = self.serializer_class(video)
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def put(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        
        data = request.data
  
        versions = json.loads(data["versions"])

        video = self.get_object(id)

        if video is not None:
            video.duration = data["duration"]
            video.width = data["width"]
            video.height = data["height"]
            video.video_codec = data["video_codec"]
            video.frame_rate = data["frame_rate"]
            video.bitrate = data["bitrate"]
            video.thumbnail = data["thumbnail"]
            video.save()
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

        for v in versions:
            v["MIME_type"] = video.MIME_type
            v["file_size"] = video.file_size
            v["description"] = video.description
            v["account"] = video.account
            v["original_video"] = video

            Video.objects.create(**v).save()
        
        return Response(status=status.HTTP_200_OK)

    def delete(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        video = self.get_object(id)
        if video is not None:
            video.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)