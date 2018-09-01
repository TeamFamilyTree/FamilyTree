from django import forms

from .models import Tree, Person, Marriage

class TreeForm(forms.ModelForm):
	error_css_class = 'error'
	passcode = forms.CharField(widget=forms.PasswordInput(), label="كلمة المرور")
	passcode_confirm = forms.CharField(widget=forms.PasswordInput(), label="تكرار كلمة المرور")

	class Meta:
		model = Tree
		fields = ('name', 'passcode', )
		widgets = {
			'name': forms.TextInput(attrs={'class': 'form'}),
		}
		labels = {
			'name': 'اسم العائلة',
		}
	def clean(self):
		cleaned_data = super(TreeForm, self).clean()
		passcode = cleaned_data.get("passcode")
		passcode_confirm = cleaned_data.get("passcode_confirm")

		if passcode != passcode_confirm:
			self.fields['passcode_confirm'].widget.attrs['class'] = "error"
			raise forms.ValidationError("password and confirm_password does not match")

class TreeLoginForm(forms.ModelForm):
	passcode = forms.CharField(widget=forms.PasswordInput(), label="كلمة المرور")
	class Meta:
		model = Tree
		fields = ('passcode', )
		labels = {
			'passcode': 'كلمة المرور',
		}

class PersonForm(forms.ModelForm):
	alive = forms.TypedChoiceField(
                   coerce=lambda x: x == 'True',
                   choices=((True, 'على قيد الحياة'), (False, 'متوفى')),
                   widget=forms.RadioSelect,
                   required=True
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
		#self.fields['birth_year'].widget=forms.TextInput(attrs={'id': 'birth_year'})
		#self.fields['death_year'].widget=forms.TextInput(attrs={'id': 'death_year'})
		self.fields['first_name'].widget.attrs['required'] = 'required'
		self.fields['gender'].widget.attrs['required'] = 'required'
		self.fields['alive'].widget.attrs['required'] = 'required'

class RootPersonForm(forms.ModelForm):
	class Meta:
		model = Person
		fields = ('first_name', 'prefix', )
		labels = {
			'first_name': 'اسم الجد',
			'prefix': 'لقب الجد',
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
		