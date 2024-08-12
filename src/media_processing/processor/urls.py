from django.urls import path

from .views import ImageProcessingView, AudioProcessingView, VideoProcessingView

urlpatterns = [
    path("images/", ImageProcessingView.as_view(), name="image-processing"),
    path("audios/", AudioProcessingView.as_view(), name="audio-processing"),
    path("videos/", VideoProcessingView.as_view(), name="video-processing"),
]
