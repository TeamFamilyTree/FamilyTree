from django import forms

from .models import Tree, Person

class TreeForm(forms.ModelForm):
	
	class Meta:
		model = Tree
		fields = ('name',)
		#widgets = {
		#	'name': forms.TextInput(attrs={'class': 'type css class here'}),
		#}
		labels = {
			'name': 'اسم العائلة:',
		}

class PersonForm(forms.ModelForm):

	class Meta:
		model = Person
		fields = ('first_name', 'last_name', 'prefix', 'gender',
			'alive', 'married',)