from django.urls import path
from django.conf.urls import url

from . import views
# from . import main
urlpatterns = [
    path('', views.home, name='home'),
    # url(r'$', views.HomeView.as_view(), name='home'),
    # url(r'^api/data/$', views.get_data, name='api-data'),


    path('History', views.History, name='history'),

    path('home', views.home, name='home'),
    path('addSensor', views.Addsensor, name='addSensor'),
    path('check', views.check, name='check'),
    url(r'^data/', views.get_data)
]
