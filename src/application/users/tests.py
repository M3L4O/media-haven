from django.core.exceptions import ValidationError
from django.test import TestCase
from users.managers import CustomUserManager
from users.models import CustomUser


class UsersManagersTests(TestCase):
    def setUp(self):
        self.username = "joao"
        self.email = "joaovictor@gmail.com"
        self.password = "123456"

        self.user: CustomUser = CustomUserManager.create_user(
            email=self.email, username=self.username, password=self.password
        )

    def test_create_user(self):
        self.assertEqual(self.user.username, self.username)
        self.assertEqual(self.user.email, self.email)
        self.assertNotEqual(self.user.password, self.password)

        self.assertRaises(
            ValidationError,
            CustomUserManager.create_user,
            email=self.email,
            username=self.username,
            password=self.password,
        )

    def test_login(self):
        email = "joaovictor@gmail.com"
        password = "123456"

        user: CustomUser = CustomUserManager.load_user(email=email, password=password)

        self.assertEqual(user.email, email)
        self.assertNotEqual(user.password, password)

        wrong_email = "joaovictor2024@gmail.com"
        wrong_password = "123abc"

        self.assertRaises(
            ValueError,
            CustomUserManager.load_user,
            email=wrong_email,
            password=password,
        )
        
        self.assertRaises(
            ValueError,
            CustomUserManager.load_user,
            email=email,
            password=wrong_password,
        )