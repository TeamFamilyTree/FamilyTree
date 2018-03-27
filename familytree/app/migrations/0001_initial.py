# Generated by Django 2.0.2 on 2018-03-22 11:18

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Marriage',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
        ),
        migrations.CreateModel(
            name='Person',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_name', models.CharField(max_length=50)),
                ('last_name', models.CharField(max_length=50)),
                ('prefix', models.CharField(max_length=50)),
                ('gender', models.CharField(choices=[('F', 'Female'), ('M', 'Male')], max_length=1)),
                ('alive', models.BooleanField(default=True)),
                ('dob', models.DateField()),
                ('dod', models.DateField()),
                ('married', models.BooleanField(default=False)),
                ('is_branch', models.BooleanField(default=False)),
                ('date_added', models.DateField()),
                ('date_last_updated', models.DateField()),
                ('father_id', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='father', to='app.Person')),
                ('mother_id', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='mother', to='app.Person')),
            ],
        ),
        migrations.CreateModel(
            name='Tree',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
            ],
        ),
        migrations.AddField(
            model_name='marriage',
            name='husband_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='husband', to='app.Person'),
        ),
        migrations.AddField(
            model_name='marriage',
            name='wife_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='wife', to='app.Person'),
        ),
    ]