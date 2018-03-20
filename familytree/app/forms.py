from django import forms

from .models import Tree

class TreeForm(forms.ModelForm):
	
	class Meta:
		model = Tree
		fields = ('name',)