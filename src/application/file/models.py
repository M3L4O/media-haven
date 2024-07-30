from django.db import models


class Tag(models.Model):
    name = models.CharField(
        max_length=255,
        unique=True,
    )


class Genre(models.Model):
    name = models.CharField(
        max_length=255,
        unique=True,
    )


class File(models.Model):
    file_path = models.FilePathField()
    file_size = models.FloatField()
    upload_date = models.DateField(auto_now_add=True)
    MIME_type = models.CharField()
    description = models.CharField()
    tags = models.ManyToManyField(Tag)

    def __str__(self):
        return self.file_path

    class Meta:
        abstract = True


class Image(File):
    width = models.IntegerField()
    height = models.IntegerField()
    color_depth = models.IntegerField()


class Audio(File):
    duration = models.TimeField()
    bitrate = models.IntegerField()
    sampling_rate = models.FloatField()
    genre = models.ManyToManyField(Genre)
    channel = models.IntegerChoices(
        ["mono", "stereo"],
    )


class Video(File):
    duration = models.TimeField()
    width = models.IntegerField()
    height = models.IntegerField()
    video_codec = models.CharField(
        max_length=100,
    )
    audio_codec = models.CharField(
        max_length=100,
    )
    frame_rate = models.IntegerField()
    bitrate = models.FilePathField()
    thumbnail = models.FilePathField()
    genre = models.ManyToManyField(Genre)
    versions = models.ManyToManyField("self", symmetrical=False)
