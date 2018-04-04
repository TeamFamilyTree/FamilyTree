from django.db import models

# Create your models here.
class Tree(models.Model):
	name = models.CharField(max_length=50)

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

class Marriage(models.Model):
	husband = models.ForeignKey('Person', related_name='marriage_husband', on_delete=models.PROTECT)
	wife = models.ForeignKey('Person', related_name='marriage_wife', on_delete=models.PROTECT)