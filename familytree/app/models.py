from django.db import models

# Create your models here.
class Tree(models.Model):
	name = models.CharField(max_length=50)

class PersonQuerySet(models.QuerySet):
	def branches(self):
		return self.filter(is_branch=True)

# A Manager class for Person Model
# - methods here organize database access for table-level queries
# - methods for row-level functionality should be defined in Person model class
#class PersonManager(models.Manager):

class Person(models.Model):
	GENDER_CHOICES = (
		('F', 'Female'),
		('M', 'Male'),
	)
	tree = models.ForeignKey('Tree', related_name='tree', on_delete=models.PROTECT)
	first_name = models.CharField(max_length=50)
	last_name = models.CharField(max_length=50, null=True)
	prefix = models.CharField(max_length=50, null=True)
	father = models.ForeignKey('Person', related_name='person_father', on_delete=models.PROTECT, null=True)
	mother = models.ForeignKey('Person', related_name='person_mother', on_delete=models.PROTECT, null=True)
	gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
	alive = models.BooleanField(default=True)
	dob = models.DateField(null=True)
	dod = models.DateField(null=True)
	married = models.BooleanField(default=False)
	is_branch = models.BooleanField(default=False)
	date_added = models.DateField(null=True)
	date_last_updated = models.DateField(null=True)
	def __str__(self):
		return self.first_name + "" + father.first_name

class Marriage(models.Model):
	class Meta:
		unique_together = (('husband', 'wife'),)
	tree = models.ForeignKey('Tree', related_name='marriage_tree', on_delete=models.PROTECT)
	husband = models.ForeignKey('Person', related_name='marriage_husband', on_delete=models.PROTECT)
	wife = models.ForeignKey('Person', related_name='marriage_wife', on_delete=models.PROTECT)