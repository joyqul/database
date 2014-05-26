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
            <a href="../country"> Go Back </a>
        </header>
        % if warning !="":
            <h3> {{warning}} </h3>
        % end
        <h1>{{title}}</h1>
        <form action="/database/flight/editcountry/{{country_id}}" method="post">
            <h2><label>Name</label><input name="name" type="text" value="{{data[1]}}"/></h2>
            <h2><label>Abbre.</label><input name="abbre" type="text" value="{{data[2]}}"/></h2>
            <input type="submit" value="Edit">
        </form>
    </div>
</body>
</html>
