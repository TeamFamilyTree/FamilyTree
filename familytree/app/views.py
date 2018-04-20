from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.views import generic
from .forms import *
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

# class TreeDetailView(generic.DetailView):
# 	model = Tree
# 	template_name = 'app/tree_detail.html'

def tree_detail(request, tree_id):
	tree = get_object_or_404(Tree, pk=tree_id)
	if (Tree.has_root(tree)):
		root = Person.objects.filter(tree=tree).get(is_root=True)
		context = {
		'tree': tree,
		'root': root,
		}
		return render(request, 'app/tree_detail.html', context)
	else:
		form = RootPersonForm()
		return render(request, 'app/tree_root_new.html', {'form': form})

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
	if (person.gender == "f"):
		if request.method == "POST":
			form = NewHusbandForm(request.POST)
			if form.is_valid():
				marriage = form.save(commit=False)
				marriage.wife = person
				marriage.tree = person.tree
				marriage.save()
				person.married = True
				person.save()
				marriage.husband.married = True
				marriage.husband.save()
				return redirect('person_detail', person_id = person.pk)
		else:
			form = NewHusbandForm()
			form.fields["husband"].queryset = Person.objects.filter(gender="m")
			# To do: exclude person's spouses from list
	else:
		if request.method == "POST":
			form = NewWifeForm(request.POST)
			if form.is_valid():
				marriage = form.save(commit=False)
				marriage.husband = person
				marriage.tree = person.tree
				marriage.save()
				person.married = True
				person.save()
				marriage.wife.married = True
				marriage.wife.save()
				return redirect('person_detail', person_id = person.pk)
		else:
			form = NewWifeForm()
			form.fields["wife"].queryset = Person.objects.filter(gender="f")
			# To do: exclude person's spouses from list
	return render(request, 'app/marriage_new.html', {'form': form, 'person_id': person_id})

def marriage_to_new_person(request, person_id):
	person = Person.objects.get(pk=person_id)
	if (person.gender == "f"):
		if request.method == "POST":
			form = MarriageToNewPersonForm(request.POST)
			if form.is_valid():
				husband = form.save(commit=False)
				husband.gender = "m"
				husband.married = True
				husband.tree = person.tree
				husband.save()
				person.married = True
				person.save()
				marriage = Marriage()
				marriage.husband = husband
				marriage.wife = person
				marriage.tree = person.tree
				marriage.save()
				return redirect('person_detail', person_id = person.pk)
		else:
			form = MarriageToNewPersonForm()
	else:
		if request.method == "POST":
			form = NewWifeForm(request.POST)
			if form.is_valid():
				wife = form.save(commit=False)
				wife.gender = "f"
				wife.married = True
				wife.tree = person.tree
				wife.save()
				person.married = True
				person.save()
				marriage = Marriage()
				marriage.wife = wife
				marriage.husband = person
				marriage.tree = person.tree
				marriage.save()
				return redirect('person_detail', person_id = person.pk)
		else:
			form = MarriageToNewPersonForm()
	return render(request, 'app/marriage_person_new.html', {'form': form})

def person_new(request, marriage_id):
	if request.method == "POST":
		form = PersonForm(request.POST)
		if form.is_valid():
			parents = Marriage.objects.get(pk=marriage_id)
			person = form.save(commit=False)
			person.mother = parents.wife
			person.father = parents.husband
			person.tree = parents.tree
			person.save()
			return redirect('person_detail', person_id = person.pk)
	else:
		form = PersonForm()
	return render(request, 'app/person_new.html', {'form': form})

def tree_root_new(request, tree_id):
	if request.method == "POST":
		form = RootPersonForm(request.POST)
		if form.is_valid():
			#if person.tree.has_root
			person = form.save(commit=False)
			person.tree = Tree.objects.get(pk=tree_id)
			person.alive = False
			person.gender = "m"
			person.is_root = True
			person.save()
			return redirect('tree_detail', tree_id = tree_id)
	else:
		form = RootPersonForm()
	return render(request, 'app/tree_root_new.html', {'form': form})

def person_set_branch(request, person_id):
	person = Person.objects.get(pk=person_id)
	person.is_branch = True
	person.save()
	return redirect('person_detail', person_id = person.pk)

def person_remove_branch(request, person_id):
	person = Person.objects.get(pk=person_id)
	person.is_branch = False
	person.save()
	return redirect('person_detail', person_id = person.pk)