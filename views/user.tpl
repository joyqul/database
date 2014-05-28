<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/main.css" />
    <link rel="stylesheet" type="text/css" href="../static/ticket.css" />
</head>
<body>
    <div id="time">
    <div id="header">
       <ul>
           <li><a href="user">Manage user</a></li>
           <li><a href="airport">Manage Airport</a></li>
           <li><a href="country">Manage Country</a></li>
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
        <h1>Manage Users</h1>
        <div id="sort">
            <label><h2>User</h2></label>
            <a href="adduser"><input type="submit" value="Add" /></a>
        </div>
        <table>
            <tr>
                <th><h4>ID</h4></th>
                <th><h4>Account</h4></th>
                <th><h4>Identity</h4></th>
                <th><h4>Operation</h4></th>
            </tr>
            % for user in data:
                <tr>
                    <td>{{user[0]}}</td>
                    <td>{{user[1]}}</td>
                    % if user[3] == 0:
                        <td>user</td>
                    % else:
                        <td>admin</td>
                    % end
                    <td>
                        % if user[3] == 0:
                        <a href="edituser/{{user[0]}}" type="submit" name="edit" value="{{user[0]}}">Edit</a>
                        % end
                        <a href="deluser/{{user[0]}}" type="submit" name="delete" value="{{user[0]}}">Delete</a>
                    </td>
                </tr>
            % end
        </table>
    <div id="footer">
        <p>May 2014, database project done by joyqul, hmlin</p>
    </div>
    </div>
</body>
</html>
