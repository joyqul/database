<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/signin.css" />
</head>
<body>
    <div id="header">
        % if is_admin == True:
            <p><a href="user">Back</a></p>
        % else:
            <header>
                <ul>
                    <li><a href="ticket">Ticket Search</a></li>
                    <li><a href="signin">Sign in</a></li>
                <ul>
            </header>
        % end
    </div>
    <div id="content">
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>{{title}}</h1>
        <form action="/database/flight/{{action}}" method="post">
            <h2><label>Email</label><input name="email" type="text" /></h2>
            <h2><label>Password</label><input name="password" type="password" /></h2>
            <h2><label>Confirm</label><input name="password_confirm" type="password" /></h2>
            % if is_admin == True:
                <h4><input name="is_admin" type="checkbox">Admin User</h4>
            % end
            <input type="submit" value="{{title}}">
        </form>
    </div>
    <div id="footer">
        <p>May 2014, database project done by joyqul, hmlin</p>
    </div>
</body>
</html>
