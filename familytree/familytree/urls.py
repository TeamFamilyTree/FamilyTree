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
    # Homepage
    path('', views.index, name='index'),

    # Tree
	path('tree/new/', views.tree_new, name='tree_new'),
    path('tree/<int:tree_id>/', views.tree_detail, name='tree_detail'),
    path('tree/<int:tree_id>/addroot', views.tree_root_new, name='tree_root_new'),

    # Person
    path('person/<int:person_id>/', views.person_detail, name='person_detail'),
    path('person/<int:person_id>/setbranch', views.person_set_branch, name='person_set_branch'),
    path('person/<int:person_id>/removebranch', views.person_remove_branch, name='person_remove_branch'),
    path('marriage/<int:marriage_id>/newperson/', views.person_new, name='person_new'),

    # Marriage
    path('person/<int:person_id>/newmarriage/', views.marriage_new, name='marriage_new'),
    path('person/<int:person_id>/newmarriage/newperson', views.marriage_to_new_person, name='marriage_to_new_person'),
    
    path('admin/', admin.site.urls),
]