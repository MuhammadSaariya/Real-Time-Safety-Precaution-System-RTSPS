# FYP_Django_Engine
Some used commands had been discussed already but here I mentioned all the commands those were used in the system. Before the description of the command, let me clear one thing that these commands should be run in your main project file folder and environment variables must be applied.
 Here I consider that your system has visual studio code and python 3.8 version while you can check your python via a command   python --version
After the surety of python, you have to install environment variable wrapper using the command:
	Pip install virtualenvwrapper-win
For setting the variable on the system run: 
	Mkvirtualenv test
Now install the django application via python of following command:
	Pip install django
To check this, run django-admin --version
For creating the project in django run the command coeval with the virtual environment variable:
	django -admin startproject {project name}
Now to Run the project, Again follow the working portion that has been discussed earlier. 
	But there are some important commands left, they must be considered in under discussion. Let's discuss them severely.
	For the purpose of connecting your external hardware with your web application we need a library which gives us access with hardware. We can easily access our hardware like the Arduino Node MCU via it’s port number. 
		Pip install serial
	In the case if your application requires a backup database you need a library as given below and the remaining procedure has been already discussed in the System Installation procedure portion.
		Pip install firebase admin
