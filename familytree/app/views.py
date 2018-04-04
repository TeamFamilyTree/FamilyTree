from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.views import generic
from .forms import TreeForm, PersonForm, NewWifeForm, NewHusbandForm
from .models import Tree, Person, Marriage

def index(request):
	return render(request, 'app/index.html')

def tree_new(request):
	# New Tree Form Submission
	if request.method == "POST":
		form = TreeForm(request.POST)
		if form.is_valid():
			tree = form.save()
			return redirect('tree_detail', pk = tree.pk)
	else:
	# Display New Form
		form = TreeForm()
	return render(request, 'app/tree_new.html', {'form': form})

class TreeDetailView(generic.DetailView):
	model = Tree
	template_name = 'app/tree_detail.html'

class PersonDetailView(generic.DetailView):
	model = Person
	template_name = 'app/person_detail.html'

def husband_new(request, wife_pk):
	if request.method == "POST":
		form = NewHusbandForm(request.POST)
		if form.is_valid():
			marriage = form.save(commit=False)
			marriage.wife = Person.objects.get(pk=wife_pk)
			marriage.save()
			return redirect('index')
	else:
		form = NewHusbandForm()
	return render(request, 'app/marriage_new.html', {'form': form})

def wife_new(request, husband_pk):
	if request.method == "POST":
		form = NewWifeForm(request.POST)
		if form.is_valid():
			marriage = form.save(commit=False)
			marriage.husband = Person.objects.get(pk=husband_pk)
			marriage.save()
			return redirect('index')
	else:
		form = NewWifeForm()
	return render(request,'app/marriage_new.html', {'form': form})


# def person_new(request):
# 	if request.method == "POST":
# 		form = PersonForm(request.POST)
# 		if form.is_valid():
# 			person = form.save()
# 			#if not self.kwargs['pk'] == '0':
# 			#	person.father = self.kwargs['pk']
# 			return redirect('index')
# 	else:
# 		form = MarriageForm()
# 	return render(request, 'app/marriage_new.html', {'form': form})

