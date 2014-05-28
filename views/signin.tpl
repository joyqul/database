<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/signin.css" />
</head>
<body>
    <div id="header">
        <ul>
            <li><a href="ticket">Ticket Search</a></li>
            <li><a href="signup">Sign up</a></li>
        <ul>
    </div>
    <div id="content">
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>Flight Company</h1>
        <form action="/database/flight/signin" method="post">
            <h2><label>Account</label><strong><input name="email" type="text"></strong></h2>
            <h2><label>Password</label><strong><input name="passwd" type="password"></strong></h2>
            <input type="submit" value="Sign in"></br>
        </form>
    </div>
    <div id="footer">
        <p>May 2014, database project done by joyqul, hmlin</p>
    </div>
</body>
</html>
