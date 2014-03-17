import bottle
from bottle import debug, template, request, route

@route('/')
def hello():
    return "Hello world!"

@route('/hello/<name>')
def greet(name='Stranger'):
    return template('Hello {{name}}, how are you?', name=name)

@route('/login')
def login():
    return '''
        <form action="/login" method="post">
            Username: <input name="username" type="text" />
            Password: <input name="password" type="password" />
            <input value="Login" type="submit" />
        </form>
    '''

@route('/login', method='POST')
def do_login():
    username = request.forms.get('username')
    password = request.forms.get('password')
    if check_login(username, password):
        return "<p>Your login information was correct. </p>"
    else:
        return "<p>Login failed. </p>"
    
def check_login(username, password):
    if username == "joyqul" and password == "1234":
        return True
    else:
        return False

debug(True)

application = bottle.default_app()
