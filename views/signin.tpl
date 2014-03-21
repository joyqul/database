<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <div id="index">
        <a href="signup">Sign up</a>
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>Flight Company</h1>
        <form action="/database/flight/signin" method="post">
            <h2><label>Account</label><strong><input name="email" type="text"> </strong></h2>
            <h2><label>Password</label><strong><input name="passwd" type="password"> </strong></h2>
            <p><input type="submit" value="Sign in"></br></p>
        </form>
    </div>
</body>
</html>
