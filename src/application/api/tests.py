from api.managers import SessionManager
from api.models import Session
from django.core.exceptions import ValidationError
from django.test import TestCase
from users.managers import CustomUserManager
from users.models import CustomUser


class SessionManagerTest(TestCase):

    def setUp(self):
        self.username = "wesley"
        self.email = "wesley@gmail.com"
        self.password = "123456"

        self.user: CustomUser = CustomUserManager.create_user(
            email=self.email, username=self.username, password=self.password
        )
        self.session = SessionManager.create_session(
            email=self.email, password=self.password
        )

    def test_create_session(self):
        self.assertEqual(self.session.user.username, self.username)
        self.assertEqual(self.session.user.email, self.email)
        self.assertNotEqual(self.session.user.password, self.password)
        self.assertNotEqual(
            self.session.token,
            SessionManager.create_session(
                email=self.email, password=self.password
            ).token,
        )

    def test_load_session(self):
        token_user = SessionManager.load_session(self.session.token).user

        self.assertEqual(token_user.email, self.user.email)
        self.assertEqual(token_user.username, self.user.username)

        invalid_token = "abcdefg"

        self.assertRaises(ValueError, SessionManager.load_session, token=invalid_token)
