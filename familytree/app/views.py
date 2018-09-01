from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.views import generic
from django.views.generic import UpdateView
from .forms import *
from .models import Tree, Person, Marriage
from django.http import HttpResponseRedirect
from django.contrib.auth.hashers import *
from django.contrib.auth import authenticate, login, logout
from django.forms import *

def index(request):
	return render(request, 'app/index.html')

def tree_new(request):
	# New Tree Form Submission
	if request.method == "POST":
		tree_form = TreeForm(request.POST)
		root_form = RootPersonForm(request.POST)
		if tree_form.is_valid() and root_form.is_valid():
			tree = tree_form.save(commit=False)
			tree.passcode = make_password(request.POST['passcode'])
			tree.save()
			person = root_form.save(commit=False)
			person.tree = tree
			person.alive = False
			person.gender = "m"
			person.is_root = True
			person.save()
			request.session['tree_id'] = tree_id
			return redirect('person_detail', person_id = person.pk)
	else:
		# Display New Form
		tree_form = TreeForm()
		root_form = RootPersonForm()
	return render(request, 'app/tree_new.html', {'tree_form': tree_form,
		'root_form': root_form })

def tree_login(request, tree_id):
	tree = get_object_or_404(Tree, pk=tree_id)
	if request.method == "POST":
		form = TreeLoginForm(request.POST)
		if form.is_valid():
			if check_password(request.POST['passcode'], tree.passcode):
				request.session['tree_id'] = tree.id
				request.session['tree_name'] = tree.name
				return redirect('tree_detail', tree_id = tree.pk)
			else:
				error_msg = "password incorrect"
				return render(request, 'app/tree_login.html', {'form': form,
					'tree_name': tree.name, 'error_msg': error_msg})
	elif request.method == "GET":
		form = TreeLoginForm()
		return render(request, 'app/tree_login.html', {'form': form,
			'tree_name': tree.name})

def tree_logout(request):
	request.session.flush()
	return redirect('index')

def tree_detail(request, tree_id, browse_depth=3):
	tree = get_object_or_404(Tree, pk=tree_id)
	if request.session.get('tree_id') == tree.pk:
		root = Person.objects.root(tree.pk)
		desc_list = root.descendants_list(browse_depth)
		context = {
			'tree': tree,
			'root': root,
			'desc_list': desc_list,
		}
		return render(request, 'app/tree_detail.html', context)
	else:
		return redirect('tree_login', tree_id = tree.pk)

def tree_search(request):
	query = request.GET.get('query')
	search_results = Tree.objects.filter(name__contains=query)
	return render(request, 'app/tree_search_results.html', {'query':query,
		'search_results':search_results})

def person_search(request, tree_id):
	if request.session.get('tree_id') == tree.pk:
		query = request.GET.get('query')
		search_results = Person.objects.tree(tree_id).filter(first_name__contains=query)
		root = Person.objects.root(tree_id)
		return render(request, 'app/person_search_results.html', {'query':query,
			'search_results':search_results,
			'person':root})
	else:
		return redirect('tree_login', tree_id = tree_id)

def person_detail(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if request.session.get('tree_id') == person.tree.pk:
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
	else:
		return redirect('tree_login', tree_id = person.tree.pk)

# def person_new(request, marriage_id):
# 	parents = get_object_or_404(Marriage, pk=marriage_id)
# 	if request.session.get('tree_id') == parents.tree.pk:
# 		if request.method == "POST":
# 			# Form Processing
# 			form = PersonForm(request.POST)
# 			if form.is_valid():
# 				person = form.save(commit=False)
# 				person.mother = parents.wife
# 				person.father = parents.husband
# 				person.tree = parents.tree
# 				if not person.father.is_paternal_desc:
# 					person.is_paternal_desc = False
# 					person.last_name = person.father.last_name
# 					person.save()
# 					return redirect('person_detail', person_id = person.mother.pk)
# 				else:
# 					person.save()
# 					return redirect('person_detail', person_id = person.pk)
# 		elif request.method == "GET":
# 			# Render Empty Form
# 			form = PersonForm()
# 		return render(request, 'app/person_form.html', {'form': form,
# 			'heading': 'إضافة شخص جديد', 'button_label': 'إضافة'})
# 	else:
# 		return redirect('tree_login', tree_id = person.tree.pk)

def person_new(request, person_id, marriage_id):
	person = get_object_or_404(Person, pk=person_id)
	parents = get_object_or_404(Marriage, pk=marriage_id)
	if request.session.get('tree_id') == parents.tree.pk:
		PersonFormset = formset_factory(PersonForm)
		if request.method == 'POST':
			formset = PersonFormset(request.POST)
			if formset.is_valid():
				for form in formset:
					#person = create_person(form, parents)
					person = form.save(commit=False)
					person.mother = parents.wife
					person.father = parents.husband
					person.tree = parents.tree
					if not person.father.is_paternal_desc:
						person.is_paternal_desc = False
						person.last_name = person.father.last_name
					person.save()
			return redirect('person_detail', person_id = person_id)
		elif request.method == 'GET':
			return render(request, 'app/person_new.html', {'formset':PersonFormset,})
	else:
		return redirect('tree_login', tree_id = person.tree.pk)

def person_edit(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if request.session.get('tree_id') == person.tree.pk:
		if request.method == "POST":
			form = PersonForm(request.POST, instance=person)
			if form.is_valid():
				updated_person = form.save()
				return redirect('person_detail', person_id = person.pk)
		elif request.method == "GET":
			form = PersonForm(instance=person)
		return render(request, 'app/person_edit.html', {'person': person, 'form': form,})
	else:
		return redirect('tree_login', tree_id = person.tree.pk)

def person_set_branch(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if request.session.get('tree_id') == person.tree.pk:
		person.is_branch = True
		person.save()
		return redirect('person_detail', person_id = person.pk)
	else:
		return redirect('tree_login', tree_id = person.tree.pk)

def person_remove_branch(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if request.session.get('tree_id') == person.tree.pk:
		person.is_branch = False
		person.save()
		return redirect('person_detail', person_id = person.pk)
	else:
		return redirect('tree_login', tree_id = person.tree.pk)

def marriage_new(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if request.session.get('tree_id') == person.tree.pk:
		if (person.gender == "f"):
			if request.method == "POST":
				form = NewHusbandForm(request.POST)
				if form.is_valid():
					marriage = form.save(commit=False)
					marriage.wife = person
					marriage.tree = person.tree
					marriage.husband.married = True
					marriage.save()
					person.married = True
					person.save()
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
					marriage.wife.married = True
					marriage.save()
					person.married = True
					person.save()
					return redirect('person_detail', person_id = person.pk)
			elif request.method == "GET":
				if person.is_root:
					return redirect('marriage_to_new_person', person_id = person.pk)
				else:
					form = NewWifeForm()
					form.fields["wife"].queryset = Person.objects.eligible_spouses(person_id=person.pk)
		return render(request, 'app/marriage_new.html', {'form': form, 'person_id': person_id})
	else:
		return redirect('tree_login', tree_id = person.tree.pk)

def marriage_to_new_person(request, person_id):
	person = get_object_or_404(Person, pk=person_id)
	if request.session.get('tree_id') == person.tree.pk:
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
	else:
		return redirect('tree_login', tree_id = person.tree.pk)
