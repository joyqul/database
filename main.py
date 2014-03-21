import bottle, re
from bottle import debug, template, route, error, static_file
from login import *

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

@error(404)
def error404(error):
    return 'Nothing here >"<'

@error(500)
def error500(error):
    return 'Something Wrong QAQ'

debug(True)
application = bottle.app()
plugin = bottle_session.SessionPlugin(99999)
application.install(plugin)
