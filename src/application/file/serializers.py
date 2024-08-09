import io
import os

from PIL import Image as pImage
from pydub import AudioSegment
from pydub.utils import mediainfo
from rest_framework import serializers
from rest_framework.exceptions import UnsupportedMediaType
from django.conf import settings

from .models import Audio, Image


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
        mode_to_bpp = {
            "1": 1,
            "L": 8,
            "P": 8,
            "RGB": 24,
            "RGBA": 32,
            "CMYK": 32,
            "YCbCr": 24,
            "LAB": 24,
            "HSV": 24,
            "I": 32,
            "F": 32,
        }

        user = self.context["request"].user
        file = validated_data.get("file")
        MIME_type = file.content_type
        file_size = file.size
        bytes_img = file.file
        
        image = pImage.open(bytes_img)
        width, height = image.size
        color_depth = mode_to_bpp[image.mode]
        
        user_images_path = f"{settings.MEDIA_ROOT}/{user.id}/images/"
        os.makedirs(user_images_path, exist_ok=True)
        file_path = f"{user_images_path}/{file._name}"
        
        with open(file_path, "wb") as binary_file:
            binary_file.write(bytes_img)

        return Image.objects.create(
            file=file_path,
            file_size=file_size,
            MIME_type=MIME_type,
            description="",
            width=width,
            height=height,
            color_depth=color_depth,
            account=user,
        )

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
        print(file.__dict__)
        file_type, extension = file.content_type.split("/")
        if file_type != "audio":
            raise UnsupportedMediaType(f"{file_type} não permitido.")
        if extension not in self.EXTs:
            raise UnsupportedMediaType(f"Tipo {extension} não suportado.")

        return attrs

    def create(self, validated_data):
        user = self.context["request"].user
        file = validated_data.get("file")
        MIME_type = file.content_type
        file_size = file.size
        bytes_audio = file.file
        os.makedirs(f"{user.id}/audios/", exist_ok=True)
        file_path = f"{user.id}/audios/{file._name}"
        audio = AudioSegment.from_file(bytes_audio)
        audio.export(file_path)
        minfo = mediainfo(file_path)

        return Audio.objects.create(
            file=file_path,
            file_size=file_size,
            MIME_type=MIME_type,
            description="",
            duration=minfo["duration"],
            bitrate=minfo["bit_rate"],
            sampling_rate=minfo["sample_rate"],
            stereo=minfo["channel_layout"] == "stereo",
            account=user,
        )
