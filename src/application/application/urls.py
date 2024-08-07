from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('admin/', admin.site.urls),
    path("auth/", include("account.urls")),
    path("file/", include("file.urls"))
]
