from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.db import models
from django.utils.translation import gettext_lazy as _
from rest_framework_simplejwt.tokens import RefreshToken

from .managers import AccountManager

AUTH_PROVIDERS = {
    "email": "email",
    "google": "google",
    "github": "github",
    "linkedin": "linkedin",
}


class Account(AbstractBaseUser, PermissionsMixin):
    id = models.BigAutoField(primary_key=True, editable=False)
    email = models.EmailField(
        max_length=255, unique=True, verbose_name=_("Email Adress")
    )
    username = models.CharField(max_length=100, verbose_name=_("Username"))
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_verified = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    date_joined = models.DateField(auto_now_add=True)
    last_login = models.DateField(auto_now=True)
    auth_provider = models.CharField(
        max_length=50, blank=False, null=False, default=AUTH_PROVIDERS.get("email")
    )

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["username"]

    objects = AccountManager()

    def tokens(self):
        refresh = RefreshToken.for_user(self)
        return {
            "refresh": str(refresh),
            "access": str(refresh.access_token),
        }

    def __str__(self):
        return self.email
