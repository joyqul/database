import bottle
from bottle import route, template, debug, request, redirect
import bottle_session
import MySQLdb
import hashlib

# My implement
from db import *

# Homework2 pages
@route('/flight/signin')
def server_static_signin(session):
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
    db = db_login()
    cursor = db.cursor()
    cursor.execute("select `password` from `user` where `account`= %s", (user_email)) 
    data = cursor.fetchall()
    cursor.execute("select `id` from `user` where `account`= %s", (user_email)) 
    user_id = cursor.fetchall()[0][0]
    db.close()
    if data == ():
        return template('signin', title="Sign In For Flight Time Table", 
                warning="No such user")
    else:
        session['user_id'] = user_id
        correct_passwd = data[0][0]
        if correct_passwd != None and passwd == correct_passwd:
            db = db_login()
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
def server_static_signup(session):
    session['is_admin'] = False
    session['title'] = "Sign up"
    session['action'] = "signup"
    return template('signup', title="Sign up", warning="",
            is_admin=False, action="signup")

@route('/flight/signup', method = 'POST')
def do_signup(session):
    user_email = request.forms.get('email')
    passwd = request.forms.get('password')
    passwd_conf = request.forms.get('password_confirm')

    title = session.get('title')
    action = session.get('action')

    if session['is_admin'] in [False, "False"]:
        is_admin = False
    else:
        is_admin = True

    if user_email == "":
        return template('signup', title = title, is_admin = is_admin,
                warning = "Email cannot be empty.", action = action)
    elif ' ' in user_email:
        return template('signup', title = title, is_admin = is_admin,
                warning = "Email cannot contain whitespace.", action = action)
    elif passwd == "":
        return template('signup', title = title, is_admin = is_admin,
                warning = "Password cannot be empty.", action = action)
    elif passwd != passwd_conf:
        return template('signup', title = title, is_admin = is_admin,
                warning = "Password Confirmation Failed.", action = action)

    db = db_login()
    cursor = db.cursor()
    cursor.execute('select * from `user` where `account` = %s', (user_email))

    if cursor.fetchall() != ():
        db.close()
        return template('signup', title = title, is_admin = is_admin, 
                warning = "Email is repeate.", action = action)
        
    else:
        if is_admin == False:
            is_admin = False
            passwd = hashlib.sha224(passwd).hexdigest()
            cursor.execute('insert into `user` values(0, %s, %s, %s)', (user_email, passwd, is_admin))
            db.commit()
            db.close()
            session['is_admin'] = is_admin
            session['sign_in'] = False
            redirect('/database/flight/signin')
        else:
            is_admin = request.forms.get('is_admin')
            if is_admin == 'on':
                is_admin = True
            else:
                is_admin = False

            passwd = hashlib.sha224(passwd).hexdigest()
            cursor.execute('insert into `user` values(0, %s, %s, %s)', (user_email, passwd, is_admin))
            db.commit()
            db.close()

            is_admin = True
            return template('signup', title = title, is_admin = is_admin, 
                    warning = "Sucessfully add user.", action = action)
            

@route('/flight/signout')
def signout(session):
    session['sign_in'] = False
    redirect('/database/flight/signin')

@route('/flight/timetable')
def index(session):
    if session['sign_in'] in [None, False, "False"]:
        redirect('/database/flight/signin')
    
    db = db_login()
    cursor = db.cursor()
    cursor.execute('select * from `flight`')
    data = cursor.fetchall()
    db.close()

    is_admin = session.get('is_admin')
    user_id = session.get('user_id')
    if is_admin in [True, 1, '1', 'True']:
        return template('timetable', title="Time table for flight - Admin mode", warning="", 
                is_admin = True, data = data, user_id = user_id)
    else:
        return template('timetable', title="Time table for flight - Admin mode", warning="", 
                is_admin = False, data = data, user_id = user_id)

@route('/flight/timetable', method = 'POST')
def timetable_request(session):

    db_col = {'ID':'id', 'Code':'flight_number', 'From':'departure',
        'To':'destination', 'Depart':'departure_date', 'Arrive':'arrival_date',
        'Price':'price'}

    user_id = session.get('user_id')

    if 'sort' in request.forms: # Do order by
        column = request.forms.get('column')
        way = request.forms.get('way')

        db = db_login()
        cursor = db.cursor()
        
        if way == "Ascending":
            cursor.execute('select * from `flight` order by %s, flight_number' %(db_col[column]))
        else:
            cursor.execute('select * from `flight` order by %s desc, flight_number' %(db_col[column]))
    
        data = cursor.fetchall()
        db.close()
    
        return template('timetable', title="Time table for flight - Admin mode", warning="",
                is_admin = True, data = data, user_id = user_id)
    else: # Do search
        column = request.forms.get('col')
        pattern = request.forms.get('pattern')
        redirect('/database/flight/search/%s/%s' %(column, pattern))

@route('/flight/favorite/<flight_id>')
def add_favorite(session, flight_id):
    user_id = session.get('user_id')
    db = db_login()
    cursor = db.cursor()
    cursor.execute('select * from `favorite` where user_id = %s and flight_id = %s', (user_id, flight_id))
    data = cursor.fetchall()
    if data == ():
        cursor.execute('insert into `favorite` values(0, %s, %s)', (user_id, flight_id))
        db.commit()
        db.close()
    redirect('/database/flight/timetable')

@route('/flight/favorite')
def favorite(session):
    user_id = session.get('user_id')

    db = db_login()
    cursor = db.cursor()
    cursor.execute('select flight_id from `favorite` where user_id = %s', (user_id))
    favorite = cursor.fetchall()
    data = []
    
    for flight_id in favorite:
        cursor.execute('select * from `flight` where id = %s', (flight_id))
        data.append(cursor.fetchall()[0])

    db.close()

    return template('favorite', title="Comparison sheet", warning="",
            is_admin = True, data = data, user_id = user_id)

@route('/flight/delfavorite/<flight_id>')
def del_favorite(session, flight_id):
    user_id = session.get('user_id')
    
    db = db_login()
    cursor = db.cursor()
    cursor.execute('delete from `favorite` where user_id = %s and flight_id = %s', (user_id, flight_id))
    db.commit()
    db.close()

    redirect('/database/flight/favorite')
    
        
    
@route('/flight/search/<col>/<pattern>')
def do_search(session, col, pattern):

        db = db_login()
        cursor = db.cursor()
        
        if col == "Code":
            cursor.execute('select * from `flight` where flight_number = %s', (pattern))
        elif col == "From":
            cursor.execute('select * from `flight` where departure = %s', (pattern))
        else:
            cursor.execute('select * from `flight` where destination = %s', (pattern))
    
        data = cursor.fetchall()
        db.close()

        return template('search', title="Search flight", warning="", 
                col = col, pattern = pattern,
                is_admin = True, data = data)
    
@route('/flight/search/<col>/<pattern>', method = 'POST')
def do_search(session, col, pattern):

    db_col = {'ID':'id', 'Code':'flight_number', 'From':'departure',
        'To':'destination', 'Depart':'departure_date', 'Arrive':'arrival_date',
        'Price':'price'}

    column = request.forms.get('column')
    way = request.forms.get('way')

    db = db_login()
    cursor = db.cursor()
        
    if way == "Ascending":
        cursor.execute('select * from `flight` where %s = "%s" order by %s, flight_number' 
                %(db_col[col], pattern, db_col[column]))
    else:
        cursor.execute('select * from `flight` where %s = "%s" order by %s desc, flight_number' 
                %(db_col[col], pattern, db_col[column]))
        
    data = cursor.fetchall()
    db.close()

    return template('search', title="Search flight", warning="", 
            col = col, pattern = pattern,
            is_admin = True, data = data)

@route('/flight/edit/<flight_id>')
def edit(session, flight_id):
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')
    else:
        db = db_login()
        cursor = db.cursor()
        cursor.execute('select * from `flight` where id = %s', (flight_id))
        data = (cursor.fetchall())[0]
        db.close()
        return template('edit', title="Edit flight", warning="",
                is_admin = True, data = data, flight_id = flight_id)

@route('/flight/edit/<flight_id>', method='POST')
def do_edit(session, flight_id):
    db = db_login()
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
        

    db = db_login()
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
        db = db_login()
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
        
    db = db_login()
    cursor = db.cursor()
    cursor.execute('insert into `flight` values(0, %s, %s, %s, %s, %s, %s)',
            (flight_number, depart, destination, departure_date, arrival_date, price))
    db.commit()
    db.close()

    return template('plane', title="New Plane", warning="Sucessfully add.")

# Homework 3 pages
@route('/flight/user')
def manage_user(session):
    if session['sign_in'] in [None, False, "False"]:
        redirect('/database/flight/signin')
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')

    db = db_login()
    cursor = db.cursor()
    cursor.execute('select * from `user`')
    data = cursor.fetchall()
    db.close()
    return template('user', title="Manage Users", warning="",
            data = data)

@route('/flight/adduser')
def add_user(session):
    if session['sign_in'] in [None, False, "False"]:
        redirect('/database/flight/signin')
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')
    return template('signup', title="Add user", warning="",
            is_admin=True, action="adduser")

@route('/flight/adduser', method = 'POST')
def add_user(session):
    if session['sign_in'] in [None, False, "False"]:
        redirect('/database/flight/signin')
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')
    session['is_admin'] = True
    session['title'] = "Add user"
    session['action'] = "adduser"
    return do_signup(session)

@route('/flight/deluser/<user_id>')
def del_user(session, user_id):
    if session['sign_in'] in [None, False, "False"]:
        redirect('/database/flight/signin')
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')

    db = db_login()
    cursor = db.cursor()
    cursor.execute('delete from `user` where id = %s', user_id)
    db.commit()
    db.close()

    redirect('/database/flight/user')

@route('/flight/edituser/<user_id>')
def edit_user(session, user_id):
    if session['is_admin'] in [False, "False", 0, "0"]:
        redirect('/database/flight/timetable')
    else:
        db = db_login()
        cursor = db.cursor()
        cursor.execute('select * from `user` where id = %s', (user_id))
        data = (cursor.fetchall())[0]
        db.close()
        return template('edituser', title="Edit User", warning="",
                is_admin = True, data = data, user_id = user_id)

@route('/flight/edituser/<user_id>', method='POST')
def edit_user(session, user_id):
    db = db_login()
    cursor = db.cursor()
    cursor.execute('select * from `user` where id = %s', (user_id))
    data = (cursor.fetchall())[0]
    db.close()

    is_admin = request.forms.get('is_admin')

    db = db_login()
    cursor = db.cursor()
    cursor.execute('update `user` set is_admin = %s where id = %s', (is_admin, user_id))
    db.commit()
    db.close()

    redirect('/database/flight/user')

@route('/flight/airport')
def airport():
    db = db_login()
    cursor = db.cursor()
    cursor.execute('select * from `airport`')
    data = cursor.fetchall()
    db.close()
    return template('airport', title="Airport Management", warning="",
            data = data)

@route('/flight/addairport')
def add_airport():
    return template('addairport', title="New Airport", warning="")

@route('/flight/addairport', method = 'POST')
def do_add_airport():
    location = request.forms.get('location')
    longitude = request.forms.get('longitude')
    latitude = request.forms.get('latitude')

    db = db_login()
    cursor = db.cursor()
    cursor.execute('insert into `airport` values(0, %s, %s, %s)', (location, longitude, latitude))
    db.commit()
    db.close()

    return template('addairport', title="New Airport", warning="Sucessfully add")

@route('/flight/delairport/<airport_id>')
def del_airport(airport_id):
    db = db_login()
    cursor = db.cursor()
    cursor.execute('delete from `airport` where id = %s', (airport_id))
    db.commit()
    db.close()
    redirect('/database/flight/airport')
    

@route('/flight/editairport/<airport_id>')
def edit_airport(airport_id):
    db = db_login()
    cursor = db.cursor()
    cursor.execute('select * from `airport` where id = %s', (airport_id))
    data = (cursor.fetchall())[0]
    db.close()
    return template('editairport', title="Edit Airport", warning="",
            data = data, airport_id = airport_id)
            

@route('/flight/editairport/<airport_id>', method = 'POST')
def do_edit_airport(airport_id):
    location = request.forms.get('location')
    longitude = request.forms.get('longitude')
    latitude = request.forms.get('latitude')
    
    db = db_login()
    cursor = db.cursor()
    cursor.execute('update `airport` set location = %s where id = %s', (location, airport_id))
    cursor.execute('update `airport` set longitude = %s where id = %s', (longitude, airport_id))
    cursor.execute('update `airport` set latitude = %s where id = %s', (latitude, airport_id))
    db.commit()
    db.close()

    redirect('/database/flight/airport')
    
