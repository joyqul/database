<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <div id="signin">
        <p><a href="airport"> Back </a></p>
        % if warning !="":
            <h3> {{warning}} </h3>
        % end
        <h1>New airport</h1>
        <form action="/database/flight/addairport" method="post">
            <h2><label>Location</label><input name="location" type="text" /></h2>
            <h2><label>Longitude</label><input name="longitude" type="number" step="any"/></h2>
            <h2><label>Latitude</label><input name="latitude" type="number" step="any"/></h2>
            <input type="submit" value="Create"></br>
        </form>
    </div>
</body>
</html>
