from django import forms

from .models import Tree, Person, Marriage

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
			'alive')

class RootPersonForm(forms.ModelForm):
	class Meta:
		model = Person
		fields = ('first_name', 'prefix',)

class NewHusbandForm(forms.ModelForm):
	class Meta:
	 	model = Marriage
	 	fields = ('husband', )

class NewWifeForm(forms.ModelForm):
	 class Meta:
	 	model = Marriage
	 	fields = ('wife', )

class MarriageToNewPersonForm(forms.ModelForm):
	class Meta:
		model = Person
		fields = ('first_name', 'last_name', 'prefix', 'alive')
		#def save(self):
		#data = self.cleaned_data
		#husband = Person(first_name=data['first_name'], last_name=data['last_name'])
		