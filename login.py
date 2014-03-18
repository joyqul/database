import bottle
from bottle import route, template
import bottle_session

# Homework 2 pages
@route('/flight/signin')
def server_static():
    return template('signin', title="Sign In For Flight Time Table")

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
