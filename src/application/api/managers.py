from time import time
from uuid import uuid4

from api.models import Session
from django.contrib.auth.base_user import BaseUserManager
from django.core.exceptions import ObjectDoesNotExist
from django.utils.translation import gettext_lazy as _
from users.managers import CustomUserManager


class SessionManager(BaseUserManager):
    @staticmethod
    def create_session(email, password):
        user = CustomUserManager.load_user(email, password)

        session = Session(user=user, token=str(uuid4()), creation_date=time())
        session.save()

        return session

    @staticmethod
    def load_session(token):
        try:
            session = Session.objects.get(token=token)
        except ObjectDoesNotExist:
            raise ValueError(_("Invalid token."))

        return session

    @staticmethod
    def delete_session(token):
        try:
            session = Session.objects.get(token=token)
            session.delete()
        except ObjectDoesNotExist:
            raise ValueError(_("Invalid Token."))
