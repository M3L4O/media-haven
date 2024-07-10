from django.contrib.auth.base_user import BaseUserManager
from django.utils.translation import gettext_lazy as _
from users.models import CustomUser


class CustomUserManager(BaseUserManager):
    def create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError(_("The Email must be set"))
        email = self.normalize_email(email)
        user = CustomUser(email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def load_user(self, email, password, **extra_fields):
        users = CustomUser.objects.filter(email=email)
        if not users or len(users) <= 0:
            print("Usuário inexistente.")  # TODO raise exception
            return

        user = users[0]
        print(user.check_password(password))
