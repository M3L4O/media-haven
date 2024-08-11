from django.urls import path

from .views import (
    ImageDetailView,
    ImageListView,
    ImageUploadView,
    AudioDetailView,
    AudioListView,
    AudioUploadView,
    VideoDetailView,
    VideoListView,
    VideoUploadView,
)

urlpatterns = [
    path("images/", ImageListView.as_view(), name="list-images"),
    path("images/<int:id>/", ImageDetailView.as_view(), name="detail-image"),
    path("images/upload/", ImageUploadView.as_view(), name="images-upload"),
    path("audios/", AudioListView.as_view(), name="list-audios"),
    path("audios/<int:id>/", AudioDetailView.as_view(), name="detail-audio"),
    path("audios/upload/", AudioUploadView.as_view(), name="audios-upload"),
    path("videos/", VideoListView.as_view(), name="list-videos"),
    path("videos/<int:id>/", VideoDetailView.as_view(), name="detail-videos"),
    path("videos/upload/", VideoUploadView.as_view(), name="videos-upload"),
    
]
