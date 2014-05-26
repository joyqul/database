<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <div id="signin">
        <p><a href="country"> Back </a></p>
        % if warning !="":
            <h3> {{warning}} </h3>
        % end
        <h1>New Country</h1>
        <form action="/database/flight/addcountry" method="post">
            <h2><label>Name</label><input name="name" type="text" /></h2>
            <h2><label>Abbre.</label><input name="abbre" type="text" /></h2>
            <input type="submit" value="Create"></br>
        </form>
    </div>
</body>
</html>
