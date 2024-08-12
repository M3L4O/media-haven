import os
import requests as rq
from rest_framework import serializers
from rest_framework.exceptions import UnsupportedMediaType
from django.conf import settings
from threading import Thread

from .models import Audio, Image, Video


def process_file(file_path, url, id, token):
    rq.post(url, data={"file": file_path, "file_id": id, "access": token})


class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = "__all__"


class ImageUploadSerializer(serializers.ModelSerializer):
    allowed_content_type = (
        "image/jpeg",
        "image/png",
        "image/svg+xml",
        "image/gif",
        "image/webp",
    )
    file = serializers.FileField()

    class Meta:
        model = Image
        fields = ["file"]

    def validate(self, attrs):
        file = attrs.get("file")
        content_type = file.content_type
        if content_type not in self.allowed_content_type:
            raise UnsupportedMediaType("Tipo de mídia não suportado.")

        return attrs

    def create(self, validated_data):
        user = self.context["request"].user
        token = self.context["request"].META.get("HTTP_AUTHORIZATION")

        file = validated_data.get("file")
        MIME_type = file.content_type
        file_size = file.size

        bytes_img = file.file.read()
        file.file.close()
        user_images_path = f"{settings.MEDIA_ROOT}{user.id}/images"
        os.makedirs(user_images_path, exist_ok=True)
        file_path = os.path.abspath(f"{user_images_path}/{file._name}")
        
        url = f"{settings.PROCESSOR_URL}/images/"

        image = Image.objects.create(
            file=file_path,
            name=os.path.splitext(file._name)[0],
            file_size=file_size,
            MIME_type=MIME_type,
            description="",
            account=user,
        )
        
        with open(file_path, "wb") as binary_file:
            binary_file.write(bytes_img)

        Thread(
            target=process_file, args=[file_path, url, image.id, token]
        ).start()

        return image


class AudioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Audio
        fields = "__all__"


class AudioUploadSerializer(serializers.ModelSerializer):
    allowed_content_type = (
        "audio/mpeg",
        "audio/wav",
        "audio/ogg",
        "audio/x-flac",
    )
    file = serializers.FileField()

    class Meta:
        model = Audio
        fields = ["file"]

    def validate(self, attrs):
        file = attrs.get("file")

        content_type = file.content_type
        if content_type not in self.allowed_content_type:
            raise UnsupportedMediaType("Tipo de mídia não suportado.")

        return attrs

    def create(self, validated_data):
        user = self.context["request"].user
        token = self.context["request"].META.get("HTTP_AUTHORIZATION")

        file = validated_data.get("file")
        MIME_type = file.content_type
        file_size = file.size
        bytes_audio = file.file.read()
        file.file.close()
        user_audio_path = f"{settings.MEDIA_ROOT}{user.id}/audios"
        os.makedirs(user_audio_path, exist_ok=True)
        file_path = os.path.abspath(f"{user_audio_path}/{file._name}")
        url = f"{settings.PROCESSOR_URL}/audios/"

        audio = Audio.objects.create(
            file=file_path,
            name=os.path.splitext(file._name)[0],
            file_size=file_size,
            MIME_type=MIME_type,
            description="",
            account=user,
        )
        
        with open(file_path, "wb") as binary_file:
            binary_file.write(bytes_audio)

        Thread(
            target=process_file, args=[file_path, url, audio.id, token]
        ).start()

        return audio


class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Video
        fields = "__all__"


class VideoUploadSerializer(serializers.ModelSerializer):
    allowed_content_type = (
        "video/mp4",
        "video/x-msvideo",
        "video/quicktime",
        "video/webm",
    )
    file = serializers.FileField()

    class Meta:
        model = Video
        fields = ["file"]

    def validate(self, attrs):
        file = attrs.get("file")
        content_type = file.content_type
        if content_type not in self.allowed_content_type:
            raise UnsupportedMediaType("Tipo de mídia não suportado.")

        return attrs

    def create(self, validated_data):
        user = self.context["request"].user

        token = self.context["request"].META.get("HTTP_AUTHORIZATION")

        file = validated_data.get("file")
        MIME_type = file.content_type
        file_size = file.size
        bytes_video = file.file.read()

        file.file.close()
        user_video_path = f"{settings.MEDIA_ROOT}{user.id}/videos"
        os.makedirs(user_video_path, exist_ok=True)
        file_path = os.path.abspath(f"{user_video_path}/{file._name}")
        url = f"{settings.PROCESSOR_URL}/videos/"

        video = Video.objects.create(
            file=file_path,
            name=os.path.splitext(file._name)[0],
            file_size=file_size,
            MIME_type=MIME_type,
            description="",
            account=user,
        )
        
        with open(file_path, "wb") as binary_file:
            binary_file.write(bytes_video)


        Thread(
            target=process_file, args=[file_path, url, video.id, token]
        ).start()

        return video
