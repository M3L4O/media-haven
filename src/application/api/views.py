from django.shortcuts import render
import json
from api.managers import SessionManager
from users.managers import CustomUserManager

from django.http import HttpResponse


def login(request):
    body = json.loads(request.body.decode("utf-8"))
    email = body["email"]
    password = body["password"]

    try:
        session = SessionManager.create_session(email=email, password=password)
        user = CustomUserManager.load_user(email=email, password=password)

        response = {
            "access_token": session.token,
            "username": user.username,
        }

        return HttpResponse(json.dumps(response), content_type="application/json")
    except ValueError:
        return HttpResponse(status=401)


def sign_up(request):
    body = json.loads(request.body.decode("utf-8"))
    email = body["email"]
    password = body["password"]
    username = body["username"]
    print(body)
    try:
        user = CustomUserManager.create_user(email=email, username=username, password=password)
        session = SessionManager.create_session(email=email, password=password)
        response = {
            "access_token": session.token,
            "username": user.username,
        }

        return HttpResponse(json.dumps(response), content_type="application/json")
    except Exception as e:
        return HttpResponse(status=422)
    

def load_session(request):
    body = json.loads(request.body.decode("utf-8"))
    access_token = body["access_token"]

    try:
        session = SessionManager.load_session(token=access_token)
        response = {
            "access_token": access_token,
            "username": session.user.username,
        }

        return HttpResponse(json.dumps(response), content_type="application/json")
    except ValueError:
        return HttpResponse(status=401)

