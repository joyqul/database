<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <div id="time">
        <header>
            <ul>
                <li><a href="user">Manage user</a></li>
                <li><a href="airport">Manage Airport</a></li>
                <li><a href="country">Manage Country</a></li>
                <li><a href="timetable">Listing planes</a></li>
                <li><a href="favorite">Favorite sheet</a></li>
                <li><a href="signout">Sign out</a> </li>
            <ul>
        </header>
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>{{title}}</h1>
    <table>
        <tr>
            <th><h4>ID</h4></th>
            <th><h4>Name</h4></th>
            <th><h4>Abbreviation</h4></th>
            <th><h4>Operation</h4></th>
        </tr>
        % for country in data:
        <tr>
            % for i in xrange(3):
                <td> {{country[i]}} </td>
            % end
            <td>
                <a href="editcountry/{{country[0]}}" type="submit" name="edit" value="{{country[0]}}">Edit</a>
                <a href="delcountry/{{country[0]}}" type="submit" name="delete" value="{{country[0]}}">Delete</a>
            </td>
        </tr>
        % end
    </table>
    <div id="button">
        <table>
            <tr>
                <td><a href="addcountry"><input type="button" value="Add country" /></a></td>
            </tr>
        </table>
    </div>
    </div>
</body>
</html>
