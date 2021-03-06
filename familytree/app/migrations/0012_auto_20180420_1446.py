# Generated by Django 2.0.2 on 2018-04-20 11:46

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0011_auto_20180420_1431'),
    ]

    operations = [
        migrations.AlterField(
            model_name='person',
            name='father',
            field=models.ForeignKey(limit_choices_to={'gender': 'm'}, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='child_of_father', to='app.Person'),
        ),
        migrations.AlterField(
            model_name='person',
            name='mother',
            field=models.ForeignKey(limit_choices_to={'gender': 'f'}, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='child_of_mother', to='app.Person'),
        ),
    ]
