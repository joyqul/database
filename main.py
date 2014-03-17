import bottle, re
from bottle import debug, template, route, error, static_file
import bottle_session


# Index pages
@route('/')
def index():
    return template('index')

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='/var/www/database/static/')

@route('/<filename>')
def server_static(filename):
    return static_file(filename, root='/var/www/database/')

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

#@error(404)
#def error404(error):
#    return 'Nothing here >"<'

debug(True)
application = bottle.app()
plugin = bottle_session.SessionPlugin()
application.install(plugin)
