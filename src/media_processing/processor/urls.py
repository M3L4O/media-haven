from django.urls import path

from .views import ImageProcessingView

urlpatterns = [
    path("images/", ImageProcessingView.as_view(), name="image-processing"),
]
