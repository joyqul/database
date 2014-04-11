<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../../static/style.css" />
</head>
<body>
    <div id="signin">
        <p><a href="../user"> Go Back </a></p>
        % if warning !="":
            <h3> {{warning}} </h3>
        % end
        <h1>Edit User</h1>
        <form action="/database/flight/edituser/{{user_id}}" method="post">
            <h2><label>Account</label></h2>
            <h4>{{data[1]}}</h4>
            <h2><label>Identity</label></h2>
            <h4><input name="is_admin" type="checkbox" value="on"> Admin</h4>
            <input type="submit" value="Edit">
        </form>
    </div>
</body>
</html>
