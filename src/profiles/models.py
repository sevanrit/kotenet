from django.contrib.auth.models import AbstractUser
from django.db import models


class UserNet(AbstractUser):
    GENDER = (
        ('male', 'male'),
        ('female', 'female')
    )
    """Custom User Model"""

    middle_name = models.CharField(max_length=50)
    first_login = models.DateTimeField(null=True)
    phone = models.CharField(max_length=14)
    avatar = models.ImageField(upload_to='user/avatar/', blank=True, null=True)

    bio = models.TextField(blank=True, null=True)
    birthday = models.DateTimeField(blank=True, null=True)
    gender = models.CharField(max_length=6, choices=GENDER, default='male')

