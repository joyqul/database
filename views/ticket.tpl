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
                    % for place in search:
                        <option>{{place[0]}}</option>
                    % end
                </select>
                <h2> To:</h2>
                <select name="dest">
                    % for place in search:
                        <option>{{place[0]}}</option>
                    % end
                </select>
                <h2> Transport times:</h2>
                <select name="times">
                    % for i in xrange(3):
                        <option>{{i}}</option>
                    % end
                </select>
                <h2> Order by:</h2>
                <select name="orderby">
                    <option>Price</option>
                    <option>Arrival time</option>
                    <option>Transfer time</option>
                </select>
                <h2> Asc:</h2>
                <select name="asc">
                    <option>ASC</option>
                    <option>DESC</option>
                </select>
                </br>
                </br>
                <label><input type="submit" name="search" value="Go"></label>
            </form>
        <br>
        </div>
        <table>
            <thead>
            <tr>
                <th>Result</th>
                <th>Flight Number</th>
                <th>Departure Airport</th>
                <th>Destination Airport</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
                <th>Flight Time</th>
                <th>Total Flight Time</th>
                <th>Transfer Time</th>
                <th>Price</th>
            <tr>
            </thead>
            <tbody>
            % i = 1
            % for ticket in data:
                <tr >
                <td rowspan="{{max_row[i-1]}}">{{i}}</td>
                % for j in xrange(6):
                    <td>{{ticket[j]}}</td>
                % end
                <td rowspan="{{max_row[i-1]}}">{{ticket[18]}}</td>
                <td rowspan="{{max_row[i-1]}}">{{ticket[19]}}</td>
                <td rowspan="{{max_row[i-1]}}">{{ticket[20]}}</td>
                </tr>
                % for l in xrange(6, 6 * max_row[i-1]):
                    % if l % 6 == 0:
                        <tr>
                    % end
                    <td>{{ticket[l]}}</td>
                    % if l % 6 == 5:
                        </tr>
                    % end
                % end
                % i = i + 1
            % end
            </tbody>
        </table>
    </div>
</body>
</html>
