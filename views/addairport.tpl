<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/main.css" />
    <link rel="stylesheet" type="text/css" href="../static/signin.css" />
</head>
<body>
    <div id="signin">
        <div id="header">
            <ul><li><a href="airport">Back</a></li></ul>
        </div>
        <div id="content">
        % if warning !="":
            <h3> {{warning}} </h3>
        % end
            <h1>New airport</h1>
            <form action="/database/flight/addairport" method="post">
                <h2><label>Name</label><input name="name" type="text" /></h2>
                <h2><label>Location</label><input name="location" type="text" /></h2>
                <h2><label>Longitude</label><input name="longitude" type="number" step="any" /></h2>
                <h2><label>Latitude</label><input name="latitude" type="number" step="any" /></h2>
                <h2><label>Country</label><input name="country" type="text" /></h2>
                <h2><label>Timezone</label><input name="timezone" type="text" /></h2>
                <input type="submit" value="Create"></br>
            </form>
        </div>
        <div id="footer">
            <p>May 2014, database project done by joyqul, hmlin</p>
        </div>
    </div>
</body>
</html>
