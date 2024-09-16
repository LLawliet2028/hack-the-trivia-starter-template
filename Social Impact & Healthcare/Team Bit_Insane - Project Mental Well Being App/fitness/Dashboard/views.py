from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import authenticate, login
from .forms import UserRegistrationForm
from .models import User

# Create your views here.
def index(request):
    return render(request, "Dashboard\index.html")


def chat(request):
    return render(request, "chatbot\index.html")


def login(request):
    return render(request, 'Dashboard\login.html')


def signup(request):
    return render(request,'Dashboard\\register.html')



def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            # Redirect to a success page or homepage
            return redirect('home')  # Change 'home' to your desired URL
        else:
            # Return an error message or handle failed login
            return render(request, 'login.html', {'error': 'Invalid login credentials'})

    return render(request, 'login.html')



def register_user(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']

            # Save the user to the database (You should hash the password in a real scenario)
            User.objects.create(username=username, password=password)

            return redirect('registration_success')  # Create a success page
    else:
        form = UserRegistrationForm()

    return render(request, 'Dashboard/register.html', {'form': form})