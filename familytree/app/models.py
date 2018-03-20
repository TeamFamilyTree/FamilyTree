from django.db import models

# Create your models here.
class Tree(models.Model):
	name = models.CharField(max_length=50)

class Person(models.Model):
	GENDER_CHOICES = (
		('F', 'Female'),
		('M', 'Male'),
	)
	first_name = models.CharField(max_length=50)
	last_name = models.CharField(max_length=50)
	prefix = models.CharField(max_length=50)
	father_id = models.ForeignKey('Person', related_name='father', on_delete=models.PROTECT)
	mother_id = models.ForeignKey('Person', related_name='mother', on_delete=models.PROTECT)
	gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
	alive = models.BooleanField(default=True)
	dob = models.DateField()
	dod = models.DateField()
	married = models.BooleanField(default=False)
	is_branch = models.BooleanField(default=False)
	date_added = models.DateField()
	date_last_updated = models.DateField()

class Marriage(models.Model):
	husband_id = models.ForeignKey('Person', related_name='husband', on_delete=models.PROTECT)
	wife_id = models.ForeignKey('Person', related_name='wife', on_delete=models.PROTECT)