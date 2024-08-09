import os
from rest_framework.serializers import Serializer
from rest_framework.exceptions import NotFound

class ImageProcessingSerializer(Serializer):
    def validate(self, attrs):
        path = attrs.get("path")

        if not os.path.exists(path):
            raise NotFound(f"arquivo {path} não encontrado.")

