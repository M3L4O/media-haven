# from .managers import ImageManager, VideoManager, AudioManager
from account.models import Account
from django.db import models


class Tag(models.Model):
    id = models.BigAutoField(primary_key=True, editable=False)
    name = models.CharField(
        max_length=255,
    )
    objects = models.Manager()
    account = models.ForeignKey(Account, on_delete=models.CASCADE, default=False)


class Genre(models.Model):
    id = models.BigAutoField(primary_key=True, editable=False)
    name = models.CharField(
        max_length=255,
    )
    objects = models.Manager()
    account = models.ForeignKey(Account, on_delete=models.CASCADE, default=False)


class File(models.Model):
    id = models.BigAutoField(primary_key=True, editable=False)
    file = models.FileField()
    file_size = models.FloatField()
    upload_date = models.DateField(auto_now_add=True)
    MIME_type = models.CharField(max_length=40)
    description = models.CharField(max_length=255, null=True)
    tags = models.ManyToManyField(Tag)

    account = models.ForeignKey(Account, on_delete=models.CASCADE, null=True)

    objects = models.Manager()

    def __str__(self):
        return self.file.name

    def delete(self, using=None, keep_parents=False):
        self.file.storage.delete(self.file.name)
        super().delete()

    class Meta:
        abstract = True


class Image(File):
    width = models.IntegerField(null=True)
    height = models.IntegerField(null=True)
    color_depth = models.IntegerField(null=True)


class Video(File):
    duration = models.TimeField(null=True)
    width = models.IntegerField(null=True)
    height = models.IntegerField(null=True)
    video_codec = models.CharField(
        max_length=100,
        null=True,
    )
    audio_codec = models.CharField(
        max_length=100,
        null=True,
    )
    frame_rate = models.IntegerField(null=True)
    bitrate = models.IntegerField(null=True)
    thumbnail = models.OneToOneField(Image, on_delete=models.CASCADE)
    genre = models.ManyToManyField(Genre)
    versions = models.ManyToManyField("self", symmetrical=False)


class Audio(File):
    duration = models.FloatField(null=True)
    bitrate = models.IntegerField(null=True)
    sampling_rate = models.FloatField(null=True)
    genre = models.ManyToManyField(Genre)
    stereo = models.BooleanField(null=True)
