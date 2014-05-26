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
            % if is_admin:
                <li><a href="user">Manage user</a></li>
                <li><a href="airport">Manage Airport</a></li>
                <li><a href="country">Manage Country</a></li>
            % end
                <li><a href="timetable">Listing planes</a></li>
                <li><a href="favorite">Favorite sheet</a></li>
                <li><a href="signout">Sign out</a> </li>
            <ul>
        </header>
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>Listing planes</h1>
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
                    <th><h4>Operations</h4></th>
                % end
                <th><h4>Favorite</h4></th>
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
                    <a href="delfavorite/{{flight[0]}}" type="submit" name="fav" value="{{flight[0]}}">Delete</a>
                </td>
            </tr>
            % end
        </tbody>
    </table> <br>
    </div>
</body>
</html>
