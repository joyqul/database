<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <h1> Sign in</h1>
    <form action="/login" method="post">
        Email </br>
        <input name="email" type="text" />
        </br>
        Password </br>
        <input value="Signin" type="password" />
        </br>
    </form>
    <p><input type="checkbox"> Remember me </br></p>
    <p><input type="submit" value="Sign in"></br></p>
    <p><a href="signup">Sign up</a></p>
    <p><a href="">Forgot your password?</a></p>
</body>
</html>
