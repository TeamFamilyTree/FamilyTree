from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.views import generic
from .forms import TreeForm
from .models import Tree

# Create your views here.
def index(request):
	return render(request, 'app/index.html')

def tree_new(request):
	if request.method == "POST":
		form = TreeForm(request.POST)
		if form.is_valid():
			tree = form.save()
			return redirect('tree_detail', pk = tree.pk)
	else:
		form = TreeForm()
	return render(request, 'app/tree_new.html', {'form': form})

class TreeDetailView(generic.DetailView):
	model = Tree
	template_name = 'app/tree_detail.html'