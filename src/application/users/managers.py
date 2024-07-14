from django.contrib.auth.base_user import BaseUserManager
from django.core.exceptions import ObjectDoesNotExist, ValidationError
from django.utils.translation import gettext_lazy as _
from users.models import CustomUser


class CustomUserManager(BaseUserManager):
    @staticmethod
    def create_user(username, email, password, **extra_fields):
        if not email:
            raise ValueError(_("The Email must be set"))

        email = BaseUserManager.normalize_email(email)

        if CustomUser.objects.filter(email=email).exists():
            raise ValidationError(_("A user with this email already exists"))

        user = CustomUser(username=username,email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    @staticmethod
    def load_user(email, password):
        try:
            user = CustomUser.objects.get(email=email)

            if not user.check_password(password):
                raise ValueError(_("Invalid email or password"))

        except ObjectDoesNotExist:
            raise ValueError(_("Invalid email or password"))

        return user
