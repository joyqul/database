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
        <h1>Listing planes</h1>
    <table>
        <tr>
            <th><h4>ID</h4></th>
            <th><h4>Code</h4></th>
            <th><h4>from</h4></th>
            <th><h4>To</h4></th>
            <th><h4>Depart</h4></th>
            <th><h4>Arrive</h4></th>
            <th><h4>Price</h4></th>
            <!-- -->
            % if is_admin:
                <th><h4>Operations</h4></th>
            % end
            <!-- -->
        </tr>
        <!-- -->
        % for flight in data:
        <tr>
            <!-- -->
            % for i in xrange(7):
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
    <!-- if statement -->
    % if is_admin:
        <a href="plane"><input type="button" value="Add" /></a>
    % end
    <!-- end if statement -->
    </div>
</body>
</html>
