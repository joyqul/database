<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <div id="signin">
        <p><a href="signin">Sign in</a></p>
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>Sign up</h1>
        <form action="/database/flight/signup" method="post">
            <h2><label>Email</label><input name="email" type="text" /></h2>
            <h2><label>Password</label><input name="password" type="password" /></h2>
            <h2><label>Confirm</label> <input name="password_confirm" type="password" /></h2>
            <input type="submit" value="Sign up">
        </form>
    </div>
</body>
</html>
