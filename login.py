import bottle
from bottle import route, template, debug, request, redirect
import bottle_session
import MySQLdb

# Database's password
f = open("flight/password")
for line in f:
    db_passwd = line.split()
    db_passwd = db_passwd[0]
    
# Connect to database
db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
cursor = db.cursor()

# Homework 2 pages
@route('/flight/signin')
def server_static(session):
    return template('signin', title="Sign In For Flight Time Table", text="")

@route('/flight/signin', method='POST')
def do_signin():
    user_email = request.forms.get('email')
    passwd = request.forms.get('passwd')
    if check_signin(user_email, passwd):
        redirect('/database/flight/timetable')
    else:
        return "<p> Sign in failed. </p>"

def check_signin(user_email, passwd):
    cursor.execute("select `password` from `user` where `account`= %s", (user_email)) 
    correct_passwd = (cursor.fetchall())[0][0]
    if correct_passwd != "" and passwd == correct_passwd:
        return True
    else:
        return False


@route('/flight/signup')
def server_static():
    return template('signup', title="Sign Up For Flight Time Table")

@route('/flight/timetable')
def index(session):
    user_name = session.get('name')
    if user_name is not None:
        return "Hello, %s"%user_name
    else:
        return "QQ"

@bottle.route('/flight/set/<user_name>')
def set_name(session, user_name=None):
    if user_name is not None:
        session['name']=user_name
        return "I recognize you now."
    else:
        return "What was that?"

app = bottle.default_app()
