from django.shortcuts import render, redirect, get_object_or_404
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

#class PersonDetailView(generic.DetailView):
#	model = Person
#	template_name = 'app/person_detail.html'

def person_detail(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if person.gender == "f":
		marriage_list = Marriage.objects.filter(wife=person)
	else:
		marriage_list = Marriage.objects.filter(husband=person)
	context = {
		'person': person,
		'marriage_list': marriage_list,
	}
	return render(request, 'app/person_detail.html', context)

def marriage_new(request, person_id):
	person = Person.objects.get(pk=person_id)
	if (Person.is_female(person)):
		if request.method == "POST":
			form = NewHusbandForm(request.POST)
			if form.is_valid():
				marriage = form.save(commit=False)
				marriage.wife = person
				marriage.save()
				return redirect('person_detail', pk = person.pk)
		else:
			form = NewHusbandForm()
	else:
		if request.method == "POST":
			form = NewWifeForm(request.POST)
			if form.is_valid():
				marriage = form.save(commit=False)
				marriage.husband = person
				marriage.save()
				return redirect('index')
		else:
			form = NewWifeForm()
	return render(request, 'app/marriage_new.html', {'form': form})

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