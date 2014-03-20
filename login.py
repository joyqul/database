import bottle
from bottle import route, template, debug, request, redirect
import bottle_session
import MySQLdb
import hashlib

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
    if session['sign_in'] in [True, "True"]:
        redirect('/database/flight/timetable')
    else:
        return template('signin', title="Sign In For Flight Time Table", warning="")

@route('/flight/signin', method='POST')
def do_signin(session):
    user_email = request.forms.get('email')
    passwd = request.forms.get('passwd')
    passwd = hashlib.sha224(passwd).hexdigest()
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
            session['sign_in'] = True
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

    if user_email == "":
        return template('signup', title = "Sign Up For Flight Time Table", 
                warning = "Email cannot be empty.")
    elif ' ' in user_email:
        return template('signup', title = "Sign Up For Flight Time Table", 
                warning = "Email cannot contain whitespace.")
    elif passwd == "":
        return template('signup', title = "Sign Up For Flight Time Table", 
                warning = "Password cannot be empty.")
    elif passwd != passwd_conf:
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
        passwd = hashlib.sha224(passwd).hexdigest()
        cursor.execute('insert into `user` values(0, %s, %s, %s)', (user_email, passwd, is_admin))
        db.commit()
        session['is_admin'] = is_admin
        session['sign_in'] = False
        redirect('/database/flight/signin')

@route('/flight/signout')
def sign_out(session):
    session['sign_in'] = False
    redirect('/database/flight/signin')

@route('/flight/timetable')
def index(session):
    if session['sign_in'] in [None, False, "False"]:
        redirect('/database/flight/signin')
    
    cursor.execute('select * from `flight`')
    data = cursor.fetchall()

    is_admin = session.get('is_admin')
    if is_admin in [True, 1, '1', 'True']:
        return template('timetable', title="Time table for flght - Admin mode", warning="", 
                is_admin = True, data = data)
    else:
        return template('timetable', title="Time table for flght - Admin mode", warning="", 
                is_admin = False, data = data)

@route('/flight/edit/<flight_id>')
def edit(session, flight_id):
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')
    else:
        cursor.execute('select * from `flight` where id = %s', (flight_id))
        data = (cursor.fetchall())[0]
        return template('edit', title="Edit flght", warning="",
                is_admin = True, data = data, flight_id = flight_id)

@route('/flght/edit/<flight_id>', method='POST')
def edit(session, flight_id):
    flight_number = request.forms.get('code')
    depart = request.forms.get('from')
    destination = request.forms.get('to')
    depart_date = request.forms.get('depart_date')
    depart_time = request.forms.get('depart_time')
    departure_date = depart_date + " " + depart_time + ":00"
    arrive_date = request.forms.get('arrive_date')
    arrive_time = request.forms.get('arrive_time')
    arrival_date = arrive_date + " " + arrive_time + ":00"
    company = request.forms.get('company')

    cursor.execute('update `flight` set flight_number = %s where id = %s', (flight_number, flight_id))
    cursor.execute('update `flight` set depart = %s where id = %s', (depart, flight_id))
    cursor.execute('update `flight` set destination = %s where id = %s', (destination, flight_id))
    cursor.execute('update `flight` set departure_date = %s where id = %s', (departure_date, flight_id))
    cursor.execute('update `flight` set arrival_date = %s where id = %s', (arrival_date, flight_id))
    cursor.execute('update `flight` set company = %s where id = %s', (company, flight_id))

    db.commit()
    cursor.execute('select * from `flight` where id = %s', (flight_id))
    data = (cursor.fetchall())[0]
    redirect('/database/flight/timetable')
        
@route('/flight/delete/<flight_id>')
def delete(session, flight_id):
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')
    else:
        cursor.execute('delete from `flight` where id = %s', flight_id)
        db.commit()
        redirect('/database/flight/timetable')

@route('/flight/plane')
def new_plane(session):
    is_admin = session.get('is_admin')
    if is_admin in [True, 1, '1', 'True']:
        return template('plane', title="New Plane", warning="")
    else:
        redirect('/database/flight/timetable')

@route('/flight/plane', method = 'POST')
def new_plane(session):
    flight_number = request.forms.get('code')
    depart = request.forms.get('from')
    destination = request.forms.get('to')
    depart_date = request.forms.get('depart_date')
    depart_time = request.forms.get('depart_time')
    departure_date = depart_date + " " + depart_time + ":00"
    arrive_date = request.forms.get('arrive_date')
    arrive_time = request.forms.get('arrive_time')
    company = request.forms.get('company')
    arrival_date = arrive_date + " " + arrive_time + ":00"
    cursor.execute('insert into `flight` values(0, %s, %s, %s, %s, %s, %s)',
            (flight_number, depart, destination, departure_date, arrival_date, company))
    db.commit()
    test = flight_number + " " + depart + " " + destination + " " +departure_date + " " + arrival_date
    return template('plane', title="New Plane", warning="Sucessfully add.")

app = bottle.default_app()
