from django.contrib.auth.models import BaseUserManager
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from django.utils.translation import gettext_lazy as _


class AccountManager(BaseUserManager):
    def email_validator(self, email: str):
        try:
            validate_email(email)
        except ValidationError:
            raise ValueError(_("Por favor, entre com um endereço de email válido."))

    def create_user(self, username: str, email: str, password: str, **extra_fields):
        if email:
            email = self.normalize_email(email)
            self.email_validator(email)
        else:
            raise ValueError(_("Endereço de email é requerido."))

        if not username:
            raise ValueError(_("Username é requerido."))

        user = self.model(username=username, email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(
        self, username: str, email: str, password: str, **extra_fields
    ):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_verified", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError(_("is staff must be true for admin user"))

        if extra_fields.get("is_superuser") is not True:
            raise ValueError(_("is superuser must be true for admin user"))

        user = self.create_user(
            username=username, email=email, password=password, **extra_fields
        )
        user.save(using=self._db)
        return user
