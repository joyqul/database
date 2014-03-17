import bottle
from bottle import debug, template, request, route, error, static_file

@error(404)
def error404(error):
    return 'Nothing here >"<'

@route('/')
def index():
    return template('index')

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='/var/www/database/static/')
    
application = bottle.default_app()
