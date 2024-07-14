from django.db import models
from users.models import CustomUser
from django.conf import settings

class Session(models.Model):
    token = models.TextField(primary_key=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    creation_date = models.FloatField(default=0)
    