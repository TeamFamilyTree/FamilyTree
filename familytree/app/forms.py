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
	alive = forms.TypedChoiceField(
                   coerce=lambda x: x == 'True',
                   choices=((True, 'على قيد الحياة'), (False, 'متوفى')),
                   widget=forms.RadioSelect
                )

	class Meta:
		model = Person
		fields = ('first_name', 'prefix', 'gender', 'alive', 'birth_year', 'death_year', )
		labels = {
			'first_name': 'الاسم الأول',
			'prefix': 'اللقب',
			'gender': 'الجنس',
			'alive': 'احم',
			'birth_year': 'سنة الميلاد (هجري)',
			'death_year': 'سنة الوفاة (هجري)',
		}

	def __init__(self, *args, **kwargs):
		super(PersonForm, self).__init__(*args, **kwargs)
		self.fields['alive'].label = ""
		self.fields['birth_year'].widget=forms.TextInput(attrs={'id': 'birth_year'})
		self.fields['death_year'].widget=forms.TextInput(attrs={'id': 'death_year'})



class RootPersonForm(forms.ModelForm):
	prefix = forms.CharField(required=False)
	class Meta:
		model = Person
		fields = ('first_name', 'prefix', )
		labels = {
			'first_name': 'الاسم الأول',
			'prefix': 'اللقب',
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
		fields = ('first_name', 'last_name', 'alive', )
		labels = {
			'first_name': 'الاسم الأول',
			'last_name': 'الاسم الأخير',
			'alive': 'على قيد الحياة',
		}
		