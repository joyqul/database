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
    return template('signin', title="Sign In For Flight Time Table", warning="")

@route('/flight/signin', method='POST')
def do_signin(session):
    user_email = request.forms.get('email')
    passwd = request.forms.get('passwd')
    return check_signin(user_email, passwd, session)

def check_signin(user_email, passwd, session):
    cursor.execute("select `password` from `user` where `account`= %s", (user_email)) 
    data = cursor.fetchall()
    if data == ():
        return template('signin', title="Sign In For Flight Time Table", 
                warning="No such user")
    else:
        correct_passwd = data[0][0]
        if correct_passwd != None and passwd == correct_passwd:
            cursor.execute("select `is_admin` from `user` where `account`= %s", (user_email)) 
            is_admin = (cursor.fetchall())[0][0]
            session['is_admin'] = is_admin
            redirect('/database/flight/timetable')
        else:
            return template('signin', title="Sign In For Flight Time Table", 
                    warning="Wrong password")

@route('/flight/signup')
def server_static(session):
    return template('signup', title="Sign Up For Flight Time Table", warning="")

@route('/flight/signup', method = 'POST')
def do_signup(session):
    user_email = request.forms.get('email')
    passwd = request.forms.get('password')
    passwd_conf = request.forms.get('password_confirm')
    is_admin = request.forms.get('is_admin')

    if passwd != passwd_conf:
        return template('signup', title = "Sign Up For Flight Time Table", 
                warning = "Password Confirmation Failed.")

    cursor.execute('select * from `user` where `account` = %s', (user_email))

    if cursor.fetchall() != ():
        return template('signup', title = "Sign Up For Flight Time Table",
                warning = "Email is repeate.")
    else:
        if is_admin == 'on':
            is_admin = True
        else:
            is_admin = False
        cursor.execute('insert into `user` values(0, %s, %s, %s)', (user_email, passwd, is_admin))
        db.commit()
        session['is_admin'] = is_admin
        redirect('/database/flight/timetable')

@route('/flight/timetable')
def index(session):
    is_admin = session.get('is_admin')
    if is_admin == True or is_admin == 1 or is_admin == '1' or is_admin == 'True':
        return "Hello", is_admin
    else:
        return "QQ", is_admin

@bottle.route('/flight/set/<user_name>')
def set_name(session, user_name=None):
    if user_name is not None:
        session['name']=user_name
        return "I recognize you now."
    else:
        return "What was that?"

app = bottle.default_app()
