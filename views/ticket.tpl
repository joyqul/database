<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
    <script type="text/javascript" src="../static/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="../static/js/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="../static/js/sort.js"></script>
</head>
<body>
    <div id="time">
        <header>
            <ul>
            % if signin:
                % if is_admin:
                    <li><a href="user">Manage user</a></li>
                    <li><a href="airport">Manage Airport</a></li>
                    <li><a href="country">Manage Country</a></li>
                % end
                <li><a href="timetable">Listing planes</a></li>
                <li><a href="favorite">Favorite sheet</a></li>
                <li><a href="signout">Sign out</a> </li>
                <li><a href="ticket">Ticket Search</a></li>
            % else:
                <li><a href="signin">Sign in</a></li>
                <li><a href="signup">Sign up</a></li>
            % end
            <ul>
        </header>
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>{{title}}</h1>
        <div id="sort">
            <form action="/database/flight/ticket" method="post">
                <h2> From:</h2>
                <select name="depart">
                    % for place in data:
                        <option>{{place[0]}}</option>
                    % end
                </select>
                <h2> To:</h2>
                <select name="dest">
                    % for place in data:
                        <option>{{place[0]}}</option>
                    % end
                </select>
                <h2> Transport times:</h2>
                <select name="times">
                    % for i in xrange(3):
                        <option>{{i}}</option>
                    % end
                </select>
                </br>
                </br>
                <label><input type="submit" name="search" value="Go"></label>
            </form>
        <br>
        </div>
    </div>
</body>
</html>
