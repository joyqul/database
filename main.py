import bottle
from bottle import debug, template, route, error, static_file, redirect
import subprocess
import re

@route('/')
def index():
    return template('index')

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='/var/www/database/static/')

@route('/<filename>')
def server_static(filename):
    return static_file(filename, root='/var/www/database/')

#@error(404)
#def error404(error):
#    return 'Nothing here >"<'

debug(True)
application = bottle.default_app()
