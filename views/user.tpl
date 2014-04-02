<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <div id="time">
        <p><a href="signout">Sign out</a></p>
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>Manage Users</h1>
    <table>
        <tr>
            <th><h4>ID</h4></th>
            <th><h4>Account</h4></th>
            <th><h4>Identity</h4></th>
            <th><h4>Operation</h4></th>
        </tr>
        <!-- -->
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
        <!-- -->
    </table>
        <div id="button">
        <table>
            <tr>
                <td><a href="timetable"><input type="button" value="Listing planes" /></a></td>
                <td><a href="airport"><input type="button" value="Manage airport" /></a></td>
                <td></td>
                <td><a href="adduser"><input type="button" value="Add user" /></a></td>
            </tr>
        </table>
        </div>
    </div>
</body>
</html>
