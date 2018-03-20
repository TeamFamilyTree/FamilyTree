from django import forms

from .models import Tree

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