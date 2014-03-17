<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <h1> Sign up</h1>
    <form action="/login" method="post">
        Email </br>
        <input name="email" type="text" />
        </br>
        Password </br>
        <input value="Sign in" type="password" />
        </br>
        Password confirmation</br>
        <input value="Sign in" type="password" />
        </br>
    </form>
    <p><input type="checkbox"> Admin User </br></p>
    <p><input type="submit" value="Sign up"></br></p>
    <p><a href="signin">Sign in</a></p>
</body>
</html>
