from django.db import models
from django.shortcuts import get_object_or_404
import datetime


class Tree(models.Model):
	name = models.CharField(max_length=50)
	passcode = models.CharField(max_length=100)

	def has_root(self):
		return Person.objects.filter(tree=self).filter(is_root=True).exists()

# QuerySets for Person model: (organizes database access for table-level queries)
class PersonQuerySet(models.QuerySet):
	def branches(self):
		return self.filter(is_branch=True)
	def tree(self, tree_id):
		return self.filter(tree_id=tree_id)
	def men(self):
		return self.filter(gender='m')
	def men(self, tree_id):
		return self.filter(tree_id=tree_id).filter(gender='m')
	def women(self, tree_id):
		return self.filter(tree_id=tree_id).filter(gender='f')
	def eligible_spouses(self, person_id):
		person = get_object_or_404(Person, pk=person_id)
		if (person.gender == "f"):
			return self.women(tree_id=person.tree.pk).exclude(
				pk__in=[s.id for s in person.spouses()])
		return self.men(tree_id=person.tree.pk).exclude(
				pk__in=[s.id for s in person.spouses()])
	def first_gen(self, tree_id):
		root = self.root(tree_id=tree_id)
		return self.filter(father=root)
	# def gen_n(self, tree_id, n):
	# 	root = self.root(tree_id=tree_id)
	# 	i = 1
	# 	if n == i:
	# 		for n
	def root(self, tree_id):
		tree = Tree.objects.get(pk=tree_id)
		return self.filter(tree=tree).get(is_root=True)
	def tree(self, tree_id):
		tree = Tree.objects.get(pk=tree_id)
		return self.filter(tree=tree)

class Person(models.Model):	
	tree = models.ForeignKey('Tree', related_name='tree', on_delete=models.PROTECT)
	first_name = models.CharField(max_length=50, blank=False)
	last_name = models.CharField(max_length=50, null=True, blank=True)
	prefix = models.CharField(max_length=50, null=True, blank=True)
	father = models.ForeignKey('Person',
								related_name='child_of_father',
								limit_choices_to={'gender': 'm'},
								on_delete=models.PROTECT,
								null=True)
	mother = models.ForeignKey('Person',
								related_name='child_of_mother',
								limit_choices_to={'gender': 'f'},
								on_delete=models.PROTECT,
								null=True)
	gender = models.CharField(max_length=1, choices=(('f', 'أنثى'),('m', 'ذكر')))
	alive = models.BooleanField(default=True)
	birth_year = models.CharField(max_length=4, null=True, blank=True)
	death_year = models.CharField(max_length=4, null=True, blank=True)
	married = models.BooleanField(default=False)
	is_branch = models.BooleanField(default=False)
	is_root = models.BooleanField(default=False)
	is_paternal_desc = models.BooleanField(default=True)
	created_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)
	objects = PersonQuerySet.as_manager()

	def has_parents(self):
		return True if (type(self.father) is Person and type(self.mother) is Person) else False

	def children(self):
		return self.child_of_mother.all() if self.gender == 'f' else self.child_of_father.all()

	def has_children(self):
		if self.gender == 'f':
			return True if (self.child_of_mother.all().count() > 0) else False
		return True if (self.child_of_father.all().count() > 0) else False

	def marriages(self):
		return self.wife_of.all() if self.gender == 'f' else self.husband_of.all()
	
	def spouses(self):
		marriages = self.marriages()
		if self.gender == 'f':
			return [m.husband for m in self.wife_of.all()]
		else:
			return [m.wife for m in self.husband_of.all()]

	def has_siblings(self):
		return True if (self.siblings().count() > 0) else False

	def siblings(self):
		if self.is_paternal_desc:
			return Person.objects.filter(father=self.father).exclude(id=self.id)

	def descendants(self):
		for child in self.children():
			yield child
			yield from child.descendants()

	def descendants_list(self, depth, count=0, d_list=None):
		if d_list is None:
			d_list = []
		if depth != 0 :
			for child in self.children():
				d_list.append([("\xa0" * count * 3), child, count])
				child.descendants_list(depth-1, count+1, d_list)
			return d_list
	
	def name(self):
		try:
			prefix_or_none = self.prefix + " "
		except:
			prefix_or_none = ""
		if self.is_paternal_desc:
			try:
				prop = ' بن ' if self.gender == 'm' else ' بنت '
				string = prefix_or_none + self.first_name + prop + self.father.first_name
			except:
				string = prefix_or_none + self.first_name
		else:
			try:
				string = prefix_or_none + self.first_name + " " + self.last_name
			except:
				string = prefix_or_none + self.first_name
		return string

	def alive_label(self):
		if self.alive == False:
			if self.gender == "f":
				return "متوفاه" + self.life_years()
			else:
				return "متوفى" + self.life_years()
		else:
			return "على قيد الحياة"
	def life_years(self):
		if self.alive == False:
			byear = self.birth_year + "هـ" if self.birth_year != None else " ؟"
			dyear = self.death_year + "هـ" if self.death_year != None else "؟ "
			return " (" + byear + " - " + dyear + ")"

	def __str__(self):
		return self.name()

class Marriage(models.Model):
	class Meta:
		unique_together = (('husband', 'wife'),)

	tree = models.ForeignKey('Tree',
							related_name='marriage_tree',
							on_delete=models.PROTECT)
	husband = models.ForeignKey('Person',
								related_name='husband_of',
								limit_choices_to={'gender': 'm'},
								on_delete=models.PROTECT)
	wife = models.ForeignKey('Person',
							related_name='wife_of',
							limit_choices_to={'gender': 'f'},
							on_delete=models.PROTECT)