from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView

from .views import LoginView, RegisterView, LogoutView, AccountUpdateView

urlpatterns = [
    path("register/", RegisterView.as_view(), name="register"),
    path("token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    path("login/", LoginView.as_view(), name="login-user"),
    path("logout/", LogoutView.as_view(), name="logout-user"),
    path("account-update/", AccountUpdateView.as_view(), name="account-update"),
]
