from rest_framework import serializers
from rest_framework.exceptions import AuthenticationFailed
from rest_framework_simplejwt.tokens import RefreshToken, TokenError
from django.contrib.auth import authenticate
from .models import Account


class AccountRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ["username", "email", "password"]

    def create(self, validated_data):
        account = Account.objects.create_user(
            username=validated_data.get("username"),
            email=validated_data.get("email"),
            password=validated_data.get("password"),
        )

        return account


class LoginSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(max_length=155)
    password = serializers.CharField(max_length=255, write_only=True)
    access = serializers.CharField(max_length=255, read_only=True)
    refresh = serializers.CharField(max_length=255, read_only=True)

    class Meta:
        model = Account
        fields = ["email", "password", "access", "refresh"]

    def validate(self, attrs):
        email = attrs.get("email")
        password = attrs.get("password")
        request = self.context.get("request")

        account = authenticate(request=request, email=email, password=password)

        if not account:
            raise AuthenticationFailed("Credenciais inválidas.")

        tokens = account.tokens()

        return {
            "email": account.email,
            "access": str(tokens.get("access")),
            "refresh": str(tokens.get("refresh")),
        }


class LogoutSerializer(serializers.ModelSerializer):
    refresh = serializers.CharField()

    class Meta:
        model = Account
        fields = ["refresh"]

    def validate(self, attrs):
        self.token = attrs.get("refresh")
        return attrs

    def save(self, **kwargs):
        try:
            token = RefreshToken(self.token)
            token.blacklist()
        except TokenError:
            return None
