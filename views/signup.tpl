<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <p> {{warning}} </p>
    <h1> Sign up</h1>
    <form action="/database/flight/signup" method="post">
        Email </br>
        <input name="email" type="text" />
        </br>
        Password </br>
        <input name="password" type="password" />
        </br>
        Password confirmation</br>
        <input name="password_confirm" type="password" />
        </br>
    <p><input name="is_admin" type="checkbox"> Admin User </br></p>
    <p><input type="submit" value="Sign up"></br></p>
    </form>
    <p><a href="signin">Sign in</a></p>
</body>
</html>
