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
    db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
    cursor = db.cursor()
    cursor.execute("select `password` from `user` where `account`= %s", (user_email)) 
    data = cursor.fetchall()
    db.close()
    if data == ():
        return template('signin', title="Sign In For Flight Time Table", 
                warning="No such user")
    else:
        correct_passwd = data[0][0]
        if correct_passwd != None and passwd == correct_passwd:
            db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
            cursor = db.cursor()
            cursor.execute("select `is_admin` from `user` where `account`= %s", (user_email)) 
            is_admin = (cursor.fetchall())[0][0]
            db.close()

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

    db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
    cursor = db.cursor()
    cursor.execute('select * from `user` where `account` = %s', (user_email))

    if cursor.fetchall() != ():
        db.close()
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
        db.close()
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
    
    db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
    cursor = db.cursor()
    cursor.execute('select * from `flight`')
    data = cursor.fetchall()
    db.close()

    is_admin = session.get('is_admin')
    if is_admin in [True, 1, '1', 'True']:
        return template('timetable', title="Time table for flight - Admin mode", warning="", 
                is_admin = True, data = data)
    else:
        return template('timetable', title="Time table for flight - Admin mode", warning="", 
                is_admin = False, data = data)

@route('/flight/edit/<flight_id>')
def edit(session, flight_id):
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')
    else:
        db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
        cursor = db.cursor()
        cursor.execute('select * from `flight` where id = %s', (flight_id))
        data = (cursor.fetchall())[0]
        db.close()
        return template('edit', title="Edit flight", warning="",
                is_admin = True, data = data, flight_id = flight_id)

@route('/flight/edit/<flight_id>', method='POST')
def edit(session, flight_id):
    db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
    cursor = db.cursor()
    cursor.execute('select * from `flight` where id = %s', (flight_id))
    data = (cursor.fetchall())[0]
    db.close()

    flight_number = request.forms.get('code')

    if flight_number == "":
        return template('edit', title="Edit Flight", warning="Code cannot be empty.",
                flight_id = flight_id, data = data)
    if ' ' in flight_number:
        return template('edit', title="Edit Flight", warning="Code cannot contain whitespace.", 
                flight_id = flight_id, data = data)

    depart = request.forms.get('from')

    if depart == "":
        return template('edit', title="Edit Flight", warning="From cannot be empty.", 
                flight_id = flight_id, data = data)
    if ' ' in depart:
        return template('edit', title="Edit Flight", warning="From cannot contain whitespace.", 
                flight_id = flight_id, data = data)

    destination = request.forms.get('to')

    if destination == "":
        return template('edit', title="Edit Flight", warning="To cannot be empty.", 
                flight_id = flight_id, data = data)
    if ' ' in destination:
        return template('edit', title="Edit Flight", warning="To cannot contain whitespace.", 
                flight_id = flight_id, data = data)

    depart_date = request.forms.get('depart_date')

    if depart_date == "":
        return template('edit', title="Edit Flight", warning="Depart cannot be empty.", 
                flight_id = flight_id, data = data)

    arrive_date = request.forms.get('arrive_date')

    if depart_date == "":
        return template('edit', title="Edit Flight", warning="Arrive cannot be empty.",
                flight_id = flight_id, data = data)

    price = request.forms.get('price')

    if price == "":
        return template('edit', title="Edit Flight", warning="Price cannot be empty.",
                flight_id = flight_id, data = data)

    if unicode(price).isnumeric() == False:
        return template('edit', title="Edit Flight", warning="Price should be a number.",
                flight_id = flight_id, data = data)
        

    db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
    cursor = db.cursor()
    cursor.execute('update `flight` set flight_number = %s where id = %s', (flight_number, flight_id))
    cursor.execute('update `flight` set departure = %s where id = %s', (depart, flight_id))
    cursor.execute('update `flight` set destination = %s where id = %s', (destination, flight_id))
    cursor.execute('update `flight` set departure_date = %s where id = %s', (depart_date, flight_id))
    cursor.execute('update `flight` set arrival_date = %s where id = %s', (arrive_date, flight_id))
    cursor.execute('update `flight` set price = %s where id = %s', (price, flight_id))

    db.commit()
    db.close()
    redirect('/database/flight/timetable')

        
@route('/flight/delete/<flight_id>')
def delete(session, flight_id):
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')
    else:
        db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
        cursor = db.cursor()
        cursor.execute('delete from `flight` where id = %s', flight_id)
        db.commit()
        db.close()
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

    if flight_number == "":
        return template('plane', title="New Plane", warning="Code cannot be empty.")
    if ' ' in flight_number:
        return template('plane', title="New Plane", warning="Code cannot contain whitespace.")

    depart = request.forms.get('from')

    if depart == "":
        return template('plane', title="New Plane", warning="From cannot be empty.")
    if ' ' in depart:
        return template('plane', title="New Plane", warning="From cannot contain whitespace.")

    destination = request.forms.get('to')

    if destination == "":
        return template('plane', title="New Plane", warning="To cannot be empty.")
    if ' ' in destination:
        return template('plane', title="New Plane", warning="To cannot contain whitespace.")

    depart_date = request.forms.get('depart_date')
    depart_time = request.forms.get('depart_time')
    departure_date = depart_date + " " + depart_time + ":00"

    if depart_date == "" or depart_time == "":
        return template('plane', title="New Plane", warning="Depart cannot be empty.")

    arrive_date = request.forms.get('arrive_date')
    arrive_time = request.forms.get('arrive_time')
    arrival_date = arrive_date + " " + arrive_time + ":00"

    if depart_date == "" or depart_time == "":
        return template('plane', title="New Plane", warning="Arrive cannot be empty.")

    price = request.forms.get('price')
    
    if price == "":
        return template('plane', title="New Plane", warning="Price cannot be empty.")
        
    db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
    cursor = db.cursor()
    cursor.execute('insert into `flight` values(0, %s, %s, %s, %s, %s, %s)',
            (flight_number, depart, destination, departure_date, arrival_date, price))
    db.commit()
    db.close()

    return template('plane', title="New Plane", warning="Sucessfully add.")

app = bottle.default_app()
