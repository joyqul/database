<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <p> {{warning}} </p>
    <h1>Listing planes</h1>
    <table>
        <tr>
            <td><b>ID</b></td>
            <td><b>Code</b></td>
            <td><b>from</b></td>
            <td><b>To</b></td>
            <td><b>Depart</b></td>
            <td><b>Arrive</b></td>
            <!-- -->
            % if is_admin:
                <td><b>Operations</b></td>
            % end
            <!-- -->
        </tr>
        <!-- -->
        % for flight in data:
        <tr>
            <!-- -->
            % for i in xrange(6):
                <td> {{flight[i]}} </td>
            % end
            <!-- -->
            % if is_admin:
                <td>
                    <a href="edit/{{flight[0]}}" type="submit" name="edit" value="{{flight[0]}}">Edit</a>
                    <a href="delete/{{flight[0]}}" type="submit" name="delete" value="{{flight[0]}}">Delete</a>
                </td>
            % end
            <!-- -->
        </tr>
        % end
        <!-- -->
    </table>
    <p><a href="signout">Sign out</a></p>
    <!-- if statement -->
    % if is_admin:
        <p><a href="plane">New Plane</a></p>
    % end
    <!-- end if statement -->
</body>
</html>
