from django.db import models

class Tree(models.Model):
	name = models.CharField(max_length=50)
	def has_root(self):
		return Person.objects.filter(tree=self).filter(is_root=True).exists()

# QuerySets for Person model: organizes database access for table-level queries
class PersonQuerySet(models.QuerySet):
	def branches(self):
		return self.filter(is_branch=True)
	def men(self):
		return self.filter(gender='m')
	def women(self):
		return self.filter(gender='f')
	def first_gen(self, tid):
		root = self.root(tid=tid)
		return self.filter(father=root)
	# def gen_n(self, tid, n):
	# 	root = self.root(tid=tid)
	# 	i = 1
	# 	if n == i:
	# 		for n
	def root(self, tid):
		tree = Tree.objects.get(pk=tid)
		return self.filter(tree=tree).get(is_root=True)
	def tree(self, tid):
		tree = Tree.objects.get(pk=tid)
		return self.filter(tree=tree)

# Default Manager class for Person model (uses QuerySets defined in PersonQuerySet)
class PersonManager(models.Manager):
	def get_queryset(self):
		return PersonQuerySet(self.model, using=self._db)

class FamilyManager(models.Manager):
	def get_queryset(self, tree_id):
		tree = Tree.objects.get(pk=tree_id)
		return super(FamilyManager, self).get_queryset().filter(tree=tree)

class Person(models.Model):
	tree = models.ForeignKey('Tree', related_name='tree', on_delete=models.PROTECT)
	first_name = models.CharField(max_length=50)
	last_name = models.CharField(max_length=50, null=True)
	prefix = models.CharField(max_length=50, null=True)
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
	gender = models.CharField(max_length=1, choices=(('f', 'Female'),('m', 'Male')))
	alive = models.BooleanField(default=True)
	dob = models.DateField(null=True)
	dod = models.DateField(null=True)
	married = models.BooleanField(default=False)
	is_branch = models.BooleanField(default=False)
	is_root = models.BooleanField(default=False)
	date_added = models.DateField(null=True)
	date_last_updated = models.DateField(null=True)
	#blood_relative = models.BooleanField(default=True) or "same family"
	objects = PersonManager()
	family = FamilyManager()

	def children(self):
		return self.child_of_mother.all() if self.gender == 'f' else self.child_of_father.all()

	def marriages(self):
		return self.wife_of.all() if self.gender == 'f' else self.husband_of.all()
	
	def spouses(self):
		marriages = self.marriages()
		if self.gender == 'f':
			return [m.husband for m in self.wife_of.all()]
		else:
			return [m.wife for m in self.husband_of.all()]

	def name(self):
		try:
			prop = ' بن ' if self.gender == 'm' else ' بنت '
			string = self.first_name + prop + self.father.first_name
		except:
			string = self.first_name
		return string

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