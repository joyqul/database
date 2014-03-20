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
            <td><b>Code from</b></td>
            <td><b>To</b></td>
            <td><b>Depart</b></td>
            <td><b>Arrive</b></td>
            <td><b>Company</b></td>
        </tr>
    </table>
    <p><a href="signout">Sign out</a></p>
    <!-- if statement -->
    % if is_admin:
        <p><a href="plane">New Plane</a></p>
    % end
    <!-- if statement -->
</body>
</html>
