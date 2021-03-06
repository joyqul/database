<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../../static/style.css" />
</head>
<body>
    <div id="signin">
        <header>
            <a href="../airport"> Go Back </a>
        </header>
        % if warning !="":
            <h3> {{warning}} </h3>
        % end
        <h1>Edit flight</h1>
        <form action="/database/flight/editairport/{{airport_id}}" method="post">
            <h2><label>Name</label><input name="name" type="text" value="{{data[1]}}"/></h2>
            <h2><label>Location</label><input name="location" type="text" value="{{data[2]}}"/></h2>
            <h2><label>Longitude</label><input name="longitude" type="number" step="any" value="{{data[3]}}" /></h2>
            <h2><label>Latitude</label><input name="latitude" type="number" step="any" value="{{data[4]}}" /></h2>
            <h2><label>Country</label><input name="country" type="text" value="{{data[5]}}" /></h2>
            <h2><label>Timezone</label><input name="timezone" type="text" value="{{data[6]}}" /></h2>
            <input type="submit" value="Edit">
        </form>
    </div>
</body>
</html>
