from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.utils.translation import gettext, gettext_lazy as _
from .models import UserNet
# Register your models here.


class UserNetAdmin(UserAdmin):
    list_display = ('username', 'email', 'phone', 'first_name', 'last_name', 'is_staff')
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        (_('Personal info'), {'fields': ('first_name', 'last_name', 'middle_name')}),
        (_('Permissions'), {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions'),
        }),
        (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
        (_('info'), {'fields': ('phone', 'avatar')}),
    )
admin.site.register(UserNet, UserNetAdmin)