import os
from rest_framework import status
from rest_framework.generics import GenericAPIView
from rest_framework.response import Response
from PIL import Image
from tinytag import TinyTag
import requests as rq
from django.conf import settings
from moviepy.editor import VideoFileClip
from videoprops import get_video_properties
import json

def resize_image(image, height, width, new_height=64, new_width=None):
    if not new_width:
        scale_factor = new_height / height
        new_width = int(width * scale_factor)
    
    resized = image.resize((new_width, new_height))
    return resized

def resize_video(video, height):
    resized = video.resize(height=height)
    return resized

def get_video_data(video_file):
    props = get_video_properties(video_file)
    
    width = int(props["width"])
    height = int(props["height"])
    duration = float(props["duration"])
    video_codec = props["codec_name"]
    frame_rate_frac = props["r_frame_rate"].split("/")
    frame_rate = int(float(frame_rate_frac[0]) / float(frame_rate_frac[1]))
    bitrate = int(props["bit_rate"])
    
    data = {
        "duration": duration,
        "width": width,
        "height": height,
        "video_codec": video_codec,
        "frame_rate": frame_rate,
        "bitrate": bitrate,
    }
    
    return data

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

        thumbnail = resize_image(image, height, width)

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

class VideoProcessingView(GenericAPIView):
    processed_heights = [360, 720, 1080]
    
    def post(self, request, *args, **kwargs):
        file = request.POST.get("file")
        id = request.POST.get("file_id")
        token = request.POST.get("access")

        if not os.path.exists(file):
            return Response(status=status.HTTP_404_NOT_FOUND)

        video = VideoFileClip(file)
        first_frame = video.get_frame(0)
        
        path, video_file = os.path.split(file)
        file_name, file_extension = os.path.splitext(video_file)
        
        first_frame_image = Image.fromarray(first_frame)
        
        height = first_frame_image.height
        
        thumbnail = resize_image(first_frame_image, height, first_frame_image.width)
        thumbnail_file = f"{path}/{file_name}_thumbnail.png"
        thumbnail.save(thumbnail_file)
        
        data = get_video_data(file)
        data["thumbnail"] = thumbnail_file
        data["versions"] = []
        
        for h in self.processed_heights:
            if h > height:
                continue 
            resized_video = resize_video(video, h)
            resized_video_path = f"{path}/{file_name}_{h}{file_extension}"
            resized_video.write_videofile(resized_video_path)
            
            version_data = get_video_data(resized_video_path)
            version_data["file"] = resized_video_path
            
            data["versions"].append(version_data)
        
        data["versions"] = json.dumps(data["versions"])
        headers = {"Authorization": f"{token}"}
        
        rq.put(
            url=f"{settings.APPLICATION_URL}/file/videos/{id}/",
            headers=headers,
            data=data
        )
        
        return Response(status=status.HTTP_200_OK)