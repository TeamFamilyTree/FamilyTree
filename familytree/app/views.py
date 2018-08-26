from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.views import generic
from django.views.generic import UpdateView
from .forms import *
from .models import Tree, Person, Marriage
from django.http import HttpResponseRedirect

def index(request):
	return render(request, 'app/index.html')

def tree_new(request):
	# New Tree Form Submission
	if request.method == "POST":
		tree_form = TreeForm(request.POST)
		root_form = RootPersonForm(request.POST)
		if tree_form.is_valid() and root_form.is_valid():
			tree = tree_form.save()
			person = root_form.save(commit=False)
			person.tree = tree
			person.alive = False
			person.gender = "m"
			person.is_root = True
			person.save()
			return redirect('person_detail', person_id = root.pk)
	else:
	# Display New Form
		tree_form = TreeForm()
		root_form = RootPersonForm()
	return render(request, 'app/tree_new.html', {'tree_form': tree_form,
												'root_form': root_form })

def tree_detail(request, tree_id, browse_depth=3):
	tree = get_object_or_404(Tree, pk=tree_id)
	if (Tree.has_root(tree)):
		root = Person.objects.root(tree.pk)
		desc_list = root.descendants_list(browse_depth)
		context = {
		'tree': tree,
		'root': root,
		'desc_list': desc_list,
		}
		return render(request, 'app/tree_detail.html', context)
	else:
		form = RootPersonForm()
		return render(request, 'app/tree_root_new.html', {'form': form})

def tree_root_new(request, tree_id):
	if request.method == "POST":
		form = RootPersonForm(request.POST)
		if form.is_valid():
			person = form.save(commit=False)
			person.tree = get_object_or_404(Tree, pk=tree_id)
			person.alive = False
			person.gender = "m"
			person.last_name = tree.name
			person.is_root = True
			person.save()
			return redirect('tree_detail', tree_id = tree_id)
	else:
		form = RootPersonForm()
	return render(request, 'app/tree_root_new.html', {'form': form})

def search(request, tree_id):
	query = request.GET.get('query')
	search_results = Person.objects.tree(tree_id).filter(first_name__contains=query)
	root = Person.objects.root(tree_id)
	return render(request, 'app/search_results.html', {'query':query,
													'search_results':search_results,
													'person':root})

def person_detail(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if person.is_paternal_desc:
		if person.gender == "f":
			marriage_list = Marriage.objects.filter(wife=person)
		else:
			marriage_list = Marriage.objects.filter(husband=person)
		siblings = person.siblings()
		context = {
			'person': person,
			'marriage_list': marriage_list,
			'siblings': siblings,
		}
		return render(request, 'app/person_detail.html', context)
	return HttpResponseRedirect(request.META.get('HTTP_REFERER'))

def person_new(request, marriage_id):
	if request.method == "POST":
		# Form Processing
		form = PersonForm(request.POST)
		if form.is_valid():
			parents = get_object_or_404(Marriage, pk=marriage_id)
			person = form.save(commit=False)
			person.mother = parents.wife
			person.father = parents.husband
			person.last_name = person.father.last_name
			person.tree = parents.tree
			if not person.father.is_paternal_desc:
				person.is_paternal_desc = False
			person.save()
			return redirect('person_detail', person_id = person.pk)
	else:
		# Render Empty Form
		form = PersonForm()
	return render(request, 'app/person_form.html', {'form': form,
		'heading': 'إضافة شخص جديد', 'button_label': 'إضافة'})

def person_edit(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if request.method == "POST":
		form = PersonForm(request.POST, instance=person)
		if form.is_valid():
			updated_person = form.save()
			return redirect('person_detail', person_id = person.pk)
	elif request.method == "GET":
		form = PersonForm(instance=person)
	return render(request, 'app/person_form.html', {'person': person, 'form': form,
		'heading': 'تعديل معلومات الشخص', 'button_label': 'تعديل'})

def person_set_branch(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	person.is_branch = True
	person.save()
	return redirect('person_detail', person_id = person.pk)

def person_remove_branch(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	person.is_branch = False
	person.save()
	return redirect('person_detail', person_id = person.pk)

def marriage_new(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
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
		elif request.method == "GET":
			form = NewHusbandForm()
			form.fields["husband"].queryset = Person.objects.eligible_spouses(person_id=person.pk)
	elif (person.gender == "m"):
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
		elif request.method == "GET":
			if person.is_root:
				redirect('marriage_to_new_person', person_id = person.pk)
			else:
				form = NewWifeForm()
				form.fields["wife"].queryset = Person.objects.eligible_spouses(person_id=person.pk)
	return render(request, 'app/marriage_new.html', {'form': form, 'person_id': person_id})

def marriage_to_new_person(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if (person.gender == "f"):
		if request.method == "POST":
			form = MarriageToNewPersonForm(request.POST)
			if form.is_valid():
				husband = form.save(commit=False)
				husband.gender = "m"
				husband.married = True
				husband.tree = person.tree
				husband.is_paternal_desc = False
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
	elif (person.gender == "m"):
		if request.method == "POST":
			form =  MarriageToNewPersonForm(request.POST)
			if form.is_valid():
				wife = form.save(commit=False)
				wife.gender = "f"
				wife.married = True
				wife.tree = person.tree
				wife.is_paternal_desc = False
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
