import os
import requests as rq
from rest_framework import serializers
from rest_framework.exceptions import UnsupportedMediaType
from django.conf import settings
from threading import Thread

from .models import Audio, Image, Video

def save_file(bytes_array, file_path, url, id, token):
    with open(file_path, "wb") as binary_file:
        binary_file.write(bytes_array.read())
    
    rq.post(url, data={"file": file_path, "file_id": id, "access": token})

class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = "__all__"


class ImageUploadSerializer(serializers.ModelSerializer):
    EXTs = ("jpeg", "jpg", "png", "gif", "svg", "webp")
    file = serializers.FileField()

    class Meta:
        model = Image
        fields = ["file"]

    def validate(self, attrs):
        file = attrs.get("file")
        file_type, extension = file.content_type.split("/")
        if file_type != "image":
            raise UnsupportedMediaType(f"{file_type} não permitido.")
        if extension not in self.EXTs:
            raise UnsupportedMediaType(f"Tipo {extension} não suportado.")

        return attrs

    def create(self, validated_data):
        user = self.context["request"].user
        token = self.context["request"].META.get('HTTP_AUTHORIZATION')

        file = validated_data.get("file")
        MIME_type = file.content_type
        file_size = file.size
        bytes_img = file.file
        user_images_path = f"{settings.MEDIA_ROOT}{user.id}/images"
        os.makedirs(user_images_path, exist_ok=True)
        file_path = os.path.abspath(f"{user_images_path}/{file._name}").replace(" ", "")
        url = f"{settings.PROCESSOR_URL}/images/"

        image = Image.objects.create(
            file=file_path,
            file_size=file_size,
            MIME_type=MIME_type,
            description="",
            account=user,
        )
        
        Thread(target=save_file, args=[bytes_img, file_path, url, image.id, token]).start()

        return image


class AudioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Audio
        fields = "__all__"


class AudioUploadSerializer(serializers.ModelSerializer):
    EXTs = ("mpeg", "wav", "ogg", "flac")
    file = serializers.FileField()

    class Meta:
        model = Audio
        fields = ["file"]

    def validate(self, attrs):
        file = attrs.get("file")
        file_type, extension = file.content_type.split("/")
        if file_type != "audio":
            raise UnsupportedMediaType(f"{file_type} não permitido.")
        if extension not in self.EXTs:
            raise UnsupportedMediaType(f"Tipo {extension} não suportado.")

        return attrs

    def create(self, validated_data):
        user = self.context["request"].user
        token = self.context["request"].META.get('HTTP_AUTHORIZATION')

        file = validated_data.get("file")
        MIME_type = file.content_type
        file_size = file.size
        bytes_audio = file.file
        user_audio_path = f"{settings.MEDIA_ROOT}{user.id}/audios"
        os.makedirs(user_audio_path, exist_ok=True)
        file_path = os.path.abspath(f"{user_audio_path}/{file._name}").replace(" ", "")
        url = f"{settings.PROCESSOR_URL}/audios/"

        audio = Audio.objects.create(
            file=file_path,
            file_size=file_size,
            MIME_type=MIME_type,
            description="",
            account=user,
        )
        
        Thread(target=save_file, args=[bytes_audio, file_path, url, audio.id, token]).start()

        return audio


class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Video
        fields = "__all__"


class VideoUploadSerializer(serializers.ModelSerializer):
    EXTs = ("mp4", "avi", "mov", "webm")
    file = serializers.FileField()

    class Meta:
        model = Video
        fields = ["file"]

    def validate(self, attrs):
        file = attrs.get("file")
        file_type, extension = file.content_type.split("/")
        if file_type != "video":
            raise UnsupportedMediaType(f"{file_type} não permitido.")
        if extension not in self.EXTs:
            raise UnsupportedMediaType(f"Tipo {extension} não suportado.")

        return attrs

    def create(self, validated_data):
        user = self.context["request"].user
        token = self.context["request"].META.get('HTTP_AUTHORIZATION')

        file = validated_data.get("file")
        MIME_type = file.content_type
        file_size = file.size
        bytes_audio = file.file
        user_video_path = f"{settings.MEDIA_ROOT}{user.id}/videos"
        os.makedirs(user_video_path, exist_ok=True)
        file_path = os.path.abspath(f"{user_video_path}/{file._name}").replace(" ", "")
        url = f"{settings.PROCESSOR_URL}/videos/"

        video = Video.objects.create(
            file=file_path,
            file_size=file_size,
            MIME_type=MIME_type,
            description="",
            account=user,
        )
        
        Thread(target=save_file, args=[bytes_audio, file_path, url, video.id, token]).start()

        return video
    