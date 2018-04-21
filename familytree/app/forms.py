from django import forms

from .models import Tree, Person, Marriage

class TreeForm(forms.ModelForm):
	class Meta:
		model = Tree
		fields = ('name',)
		widgets = {
			'name': forms.TextInput(attrs={'class': 'form'}),
		}
		labels = {
			'name': 'اسم العائلة:',
		}

class PersonForm(forms.ModelForm):
	class Meta:
		model = Person
		fields = ('first_name', 'last_name', 'gender', 'alive')
		labels = {
			'first_name': 'الاسم الأول',
			'gender': 'الجنس',
			'alive': 'على قيد الحياة',
		}

class RootPersonForm(forms.ModelForm):
	class Meta:
		model = Person
		fields = ('first_name',)
		labels = {
			'first_name': 'الاسم الأول',
		}

class NewHusbandForm(forms.ModelForm):
	class Meta:
	 	model = Marriage
	 	fields = ('husband', )
	 	labels = {
			'husband': 'الزوج',
		}

class NewWifeForm(forms.ModelForm):
	 class Meta:
	 	model = Marriage
	 	fields = ('wife', )
	 	labels = {
			'wife': 'الزوجة',
		}

class MarriageToNewPersonForm(forms.ModelForm):
	class Meta:
		model = Person
		fields = ('first_name', 'last_name', 'alive')
		labels = {
			'first_name': 'الاسم الأول',
			'last_name': 'الاسم الأخير',
			'alive': 'على قيد الحياة',
		}
		