from django.shortcuts import render

def index(request):
  return render(request , "index.html" , {"hello":"hello world team"} )
