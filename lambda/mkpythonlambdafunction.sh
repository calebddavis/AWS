#make a project dir 
mkdir project
cd project

#Use python3 command to specify you want python3
#use python3's virtual environment capabilites with -venv flag also nameing the enviroment "venv"
python3 -m venv venv

#python will create this python envronment for me you will see "venv"
#we are going to turn the virtual environment on 
source venv/bin/activate 

#pip install dependency will use for function 
#we are going to install requests its used to make http requests like web scraping 
#install pip install requests

#we will create a new file called my_handler.py
touch my_handler.py

#we check python with python command and because we are in a python env will default to python 3.6.5
python 

#in python not and we will import request because we have it from the install 
>>>import requests 

#now we have to write our hander code 
#The handler is the method in your Lambda function that processes events. When you invoke a function, the runtime runs the handler method.
nano my_handler.py

#in nano text editor in my_handler.py we write the function 

import request

#must have event and context params to work with aws lambda 
def handler(event, context):
    
    #passing a string for a url req 
    r = requests.get('https://www.somethingeit.com')
    
    #we use .text to return the actual text in the url site and it will be alot so we want to tell it to only return the first 500 characters 
    print(r.text[0:500])
    
    #now we want to say if r has a status code of 200 then we want to return the success message
    if r.status_code == 200:
        return 'Success!'
    else:
        return 'FAILURE!'

#save and overite the file 

#cat the file to confirm
cat my_handler.py

#next we make sure we will have all the dependencies we need when we send to lambda function with the function package 
#for this we use freeze to get the info and put it in a text file 
pip freeze > requirements.txt

#you can confirm it by cating the file 
cat requirments.txt

#we see request along with other chained depenendcies it may need 

#next we intall all those other dependencies from the file so we have -r to say this is a requrirment file and we do -t to tell us where we need it installed in this venv directory by using . , by default it will install it on the system environment 
pip install -r requirments.txt -t . 

#if you ls you can now see all the folders you just installed
ls

#destroy virtual environment now no longer needed 
deactivate 

#next remeove the vitural enironment we are doing it to save space when deploying to lambda
rm -r venv 

#next open up the current dir on your os (it is dif depending on if your on mac or not)
open . 

#select everything in project folder and compress 12 items 
#it will make an archive.zip file 

#upload that to your lambda function 

#make sure you fix the handler for the function name to make sure the names match or it will throw an error 
#make a project dir 
mkdir project
cd project

#Use python3 command to specify you want python3
#use python3's virtual environment capabilites with -venv flag also nameing the enviroment "venv"
python3 -m venv venv

#python will create this python envronment for me you will see "venv"
#we are going to turn the virtual environment on 
source venv/bin/activate 

#pip install dependency will use for function 
#we are going to install requests its used to make http requests like web scraping 
#install pip install requests

#we will create a new file called my_handler.py
touch my_handler.py

#we check python with python command and because we are in a python env will default to python 3.6.5
python 

#in python not and we will import request because we have it from the install 
>>>import requests 

#now we have to write our hander code 
#The handler is the method in your Lambda function that processes events. When you invoke a function, the runtime runs the handler method.
nano my_handler.py

#in nano text editor in my_handler.py we write the function 

import request

#must have event and context params to work with aws lambda 
def handler(event, context):
    
    #passing a string for a url req 
    r = requests.get('https://www.somethingeit.com')
    
    #we use .text to return the actual text in the url site and it will be alot so we want to tell it to only return the first 500 characters 
    print(r.text[0:500])
    
    #now we want to say if r has a status code of 200 then we want to return the success message
    if r.status_code == 200:
        return 'Success!'
    else:
        return 'FAILURE!'

#save and overite the file 

#cat the file to confirm
cat my_handler.py

#next we make sure we will have all the dependencies we need when we send to lambda function with the function package 
#for this we use freeze to get the info and put it in a text file 
pip freeze > requirements.txt

#you can confirm it by cating the file 
cat requirments.txt

#we see request along with other chained depenendcies it may need 

#next we intall all those other dependencies from the file so we have -r to say this is a requrirment file and we do -t to tell us where we need it installed in this venv directory by using . , by default it will install it on the system environment 
pip install -r requirments.txt -t . 

#if you ls you can now see all the folders you just installed
ls

#destroy virtual environment now no longer needed 
deactivate 

#next remeove the vitural enironment we are doing it to save space when deploying to lambda
rm -r venv 

#next open up the current dir on your os (it is dif depending on if your on mac or not)
open . 

#select everything in project folder and compress 12 items 
#it will make an archive.zip file 

#upload that to your lambda function 

#make sure you fix the handler for the function name to make sure the names match or it will throw an error 
