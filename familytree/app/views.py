from django.shortcuts import render
from django.http import HttpResponse
from .forms import TreeForm

# Create your views here.
def index(request):
	return render(request, 'app/index.html')

def tree_new(request):
	form = TreeForm()
	return render(request, 'app/tree_new.html', {'form': form})