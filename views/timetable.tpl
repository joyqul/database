<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/tablesorter.css" />
    <link rel="stylesheet" type="text/css" href="../static/main.css" />
    <link rel="stylesheet" type="text/css" href="../static/ticket.css" />
    <link rel="stylesheet" type="text/css" href="../static/type.css" />
    <script type="text/javascript" src="../static/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="../static/js/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="../static/js/sort.js"></script>
</head>
<body>
    <div id="time">
    <div id="header">
        <ul>
        % if is_admin:
            <li><a href="user">Manage user</a></li>
            <li><a href="airport">Manage Airport</a></li>
            <li><a href="country">Manage Country</a></li>
        % end
            <li><a href="timetable">Listing planes</a></li>
            <li><a href="favorite">Favorite sheet</a></li>
            <li><a href="ticket">Ticket Search</a></li>
            <li><a href="signout">Sign out</a> </li>
        <ul>
    </div>
    <div id="content">
    % if warning != "":
        <h3> {{warning}} </h3>
    % end
        <h1>Listing planes</h1>
        <div id="sort">
            <form action="/database/flight/timetable" method="post">
                <label><h2>Search</h2></label>
                <select name="col">
                    <option selected>Code</option>
                    <option>From</option>
                    <option>To</option>
                </select>
                <input name="pattern" type="text" />
                <input type="submit" name="search" value="Go">
            % if is_admin:
                <br>
                <label><h2>Flight</h2></label>
                <a href="plane"><input type="button" value="Add" /></a>
            % end
            </form>
        </div>
        <table id="flight" class="tablesorter">
        <thead>
            <tr>
                <th><h4>ID</h4></th>
                <th><h4>Code</h4></th>
                <th><h4>From</h4></th>
                <th><h4>To</h4></th>
                <th><h4>Depart</h4></th>
                <th><h4>Arrive</h4></th>
                <th><h4>Price</h4></th>
                % if is_admin:
                    <th data-sorter="false"><h4>Operations</h4></th>
                % end
                <th data-sorter="false"><h4>Favorite</h4></th>
            </tr>
        </thead>
        <tbody>
            % for flight in data:
            <tr>
                % for i in xrange(7):
                    <td> {{flight[i]}} </td>
                % end
                % if is_admin:
                    <td>
                        <a href="edit/{{flight[0]}}" type="submit" name="edit" value="{{flight[0]}}">Edit</a>
                        <a href="delete/{{flight[0]}}" type="submit" name="delete" value="{{flight[0]}}">Delete</a>
                    </td>
                % end
                <td>
                    <a href="favorite/{{flight[0]}}" type="submit" name="fav" value="{{flight[0]}}">Add</a>
                </td>
            </tr>
            % end
        </tbody>
        </table>
    </div>
    <div id="footer">
        <p>May 2014, database project done by joyqul, hmlin</p>
    </div>
    </div>
</body>
</html>
