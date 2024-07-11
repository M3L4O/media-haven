from django.contrib.auth.base_user import BaseUserManager
from django.utils.translation import gettext_lazy as _
from users.models import CustomUser
from django.core.exceptions import ObjectDoesNotExist, ValidationError


class CustomUserManager(BaseUserManager):
    def create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError(_("The Email must be set"))
        
        email = self.normalize_email(email)
        
        if CustomUser.objects.filter(email=email).exists():
            raise ValidationError(_("A user with this email already exists"))
        
        user = CustomUser(email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def load_user(self, email, password, **extra_fields):
        try:
            user = CustomUser.objects.get(email=email)
            
            if not user.check_password(password):
                raise ValueError(_("Invalid email or password"))
            
        except ObjectDoesNotExist:
            raise ValueError(_("Invalid email or password"))

        return user
    
