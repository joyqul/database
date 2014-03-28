<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <div id="time">
        <p><a href="timetable">Back</a></p>
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>Manage Users</h1>
    <table>
        <tr>
            <th><h4>Account</h4></th>
            <th><h4>Identity</h4></th>
            <th><h4>Operation</h4></th>
        </tr>
        <!-- -->
        % for user in data:
            <tr>
                <td>{{user[1]}}</td>
                % if user[3] == 0:
                    <td>user</td>
                % else:
                    <td>admin</td>
                % end
                <td>
                    <a href="edit/{{user[0]}}" type="submit" name="edit" value="{{user[0]}}">Edit</a>
                    <a href="delete/{{user[0]}}" type="submit" name="delete" value="{{user[0]}}">Delete</a>
                </td>
            </tr>
        % end
        <!-- -->
    </table>
    <a href="adduser"><input type="button" value="Add" /></a>
    </div>
</body>
</html>
