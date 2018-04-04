"""familytree URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from app import views

urlpatterns = [
	path('', views.index, name='index'),
	path('tree/new/', views.tree_new, name='tree_new'),
    path('tree/<int:pk>/', views.TreeDetailView.as_view(), name='tree_detail'),
    path('person/<int:wife_pk>/newhusband/', views.husband_new, name='husband_new'),
    path('person/<int:husband_pk>/newwife/', views.wife_new, name='wife_new'),
    #path('tree/<int:marriage_pk>/newperson/', views.person_new, name='person_new'),
    path('person/<int:pk>/', views.PersonDetailView.as_view(), name='person_detail'),
    path('admin/', admin.site.urls),
]
