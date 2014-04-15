import bottle, re
from bottle import debug, template, route, error, static_file
import bottle_session
from login import *

# Index pages
@route('/')
def index():
    return template('index')

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='/var/www/database/static/')

@route('/static/js/<filename>')
def server_static(filename):
    return static_file(filename, root='/var/www/database/static/js/')

@route('/<filename>')
def server_static(filename):
    return static_file(filename, root='/var/www/database/')

@error(404)
def error404(error):
    return template('sorry', title="Error 404", warning="Nothing here Q_Q")

@error(500)
def error500(error):
    return template('sorry', title="Error 500", warning="Something went wrong Q_Q")

debug(True)
application = bottle.app()
plugin = bottle_session.SessionPlugin(cookie_lifetime=6000)
application.install(plugin)
