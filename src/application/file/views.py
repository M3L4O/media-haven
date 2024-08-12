import json

from django.http import FileResponse
from rest_framework import status
from rest_framework.generics import (
    GenericAPIView,
    ListAPIView,
    RetrieveUpdateDestroyAPIView,
)
from rest_framework.parsers import FileUploadParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .models import Audio, Image, Video
from .serializers import (
    AudioSerializer,
    AudioUploadSerializer,
    ImageSerializer,
    ImageUploadSerializer,
    VideoSerializer,
    VideoUploadSerializer,
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
        images = Image.objects.filter(account=user)
        return images


class ImageDetailView(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ImageSerializer
    keys_allowed = (
        "name", 
        "description", 
        "MIME_type", 
        "width", 
        "height", 
        "color_depth", 
        "thumbnail",
    )
        
    def get_object(self, id):
        try:
            return Image.objects.get(pk=id)
        except Image.DoesNotExist:
            return None

    def get(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        image = self.get_object(id)
        if image is not None:
            return FileResponse(open(image.file.name, "rb"), as_attachment=True)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def put(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        image = self.get_object(id)
        data = request.data
        if image is not None:
            for k, v in data.items():
                if k in self.keys_allowed:
                    image.__setattr__(k, v)
             
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
    keys_allowed = (
        "name",
        "description",
        "MIME_type",
        "duration",
        "bitrate",
        "sampling_rate",
        "stereo",
    )

    def get_object(self, id):
        try:
            return Audio.objects.get(id=id)
        except Audio.DoesNotExist:
            return None

    def get(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        audio = self.get_object(id)
        if audio is not None:
            return FileResponse(open(audio.file.name, "rb"), as_attachment=True)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def put(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        audio = self.get_object(id)
        data = request.data

        if audio is not None:
            for k, v in data.items():
                if k in self.keys_allowed:
                    audio.__setattr__(k, v)
            
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

    keys_allowed = (
        "name",
        "description",
        "MIME_type",
        "duration",
        "width",
        "height",
        "video_codec",
        "frame_rate",
        "bitrate",
        "thumbnail",
    )
    
    def get_object(self, id):
        try:
            return Video.objects.get(id=id)
        except Video.DoesNotExist:
            return None

    def get(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        video = self.get_object(id)
        if video is not None:
            response = FileResponse(open(video.file.name, "rb"))
            response["versions"] = {v.height: v.id for v in Video.objects.filter(original_video=video)}
            return response
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def put(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        video = self.get_object(id)

        data = request.data

        if video is not None:
            for k, v in data.items():
                if k == "versions":
                    continue
                if k in self.keys_allowed:
                    video.__setattr__(k, v)
           
            video.save(force_update=True)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)


        if "versions" in data.keys():
            versions = json.loads(data["versions"])
        
            for v in versions:
                v["MIME_type"] = video.MIME_type
                v["file_size"] = video.file_size
                v["description"] = video.description
                v["account"] = video.account
                v["original_video"] = video

                Video.objects.create(**v)

        return Response(status=status.HTTP_200_OK)

    def delete(self, request, *args, **kwargs):
        id = self.kwargs.get("id")
        video = self.get_object(id)
        if video is not None:
            video.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)
