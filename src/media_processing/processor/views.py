import os
from rest_framework import status
from rest_framework.generics import GenericAPIView
from rest_framework.response import Response
from PIL import Image
from tinytag import TinyTag
import requests as rq
from django.conf import settings


class ImageProcessingView(GenericAPIView):
    def post(self, request, *args, **kwargs):
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
        file = request.POST.get("file")
        id = request.POST.get("file_id")
        token = request.POST.get("access")
        if not os.path.exists(file):
            return Response(status=status.HTTP_404_NOT_FOUND)

        image = Image.open(file)
        width, height = image.size
        color_depth = mode_to_bpp[image.mode]

        thumbnail_height = 64
        scale_factor = thumbnail_height / height
        thumbnail_width = int(width * scale_factor)
        thumbnail = image.resize((thumbnail_width, thumbnail_height))

        path, image_file = os.path.split(file)
        image_name, image_extension = os.path.splitext(image_file)
        thumbnail_file = f"{path}/{image_name}_thumbnail{image_extension}"
        thumbnail.save(thumbnail_file)

        data = {
            "color_depth": color_depth,
            "width": width,
            "height": height,
            "thumbnail": thumbnail_file,
        }
        headers = {"Authorization": f"{token}"}
        rq.put(
            url=f"{settings.APPLICATION_URL}/file/images/{id}/",
            headers=headers,
            data=data,
        )
        return Response(status=status.HTTP_200_OK)


class AudioProcessingView(GenericAPIView):
    def post(self, request, *args, **kwargs):
        file = request.POST.get("file")
        id = request.POST.get("file_id")
        token = request.POST.get("access")

        if not os.path.exists(file):
            return Response(status=status.HTTP_404_NOT_FOUND)

        audio = TinyTag.get(file)

        duration = audio.duration
        bitrate = audio.bitrate
        sample_rate = audio.samplerate
        channels = audio.channels
        data = {
            "duration": duration,
            "bitrate": bitrate,
            "sample_rate": sample_rate,
            "channels": channels,
        }
        headers = {"Authorization": f"{token}"}
        rq.put(
            url=f"{settings.APPLICATION_URL}/file/audios/{id}/",
            headers=headers,
            data=data,
        )
        return Response(status=status.HTTP_200_OK)
