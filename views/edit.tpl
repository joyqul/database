<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../../static/style.css" />
</head>
<body>
    <div id="signin">
        <p><a href="../timetable"> Go Back </a></p>
        % if warning !="":
            <h3> {{warning}} </h3>
        % end
        <h1>Edit flight</h1>
        <form action="/database/flight/edit/{{flight_id}}" method="post">
            <h2><label>Code</label><input name="code" type="text" value="{{data[1]}}"/></h2>
            <h2><label>From</label><input name="from" type="text" value="{{data[2]}}" /></h2>
            <h2><label>To</label><input name="to" type="text" value="{{data[3]}}" /></h2>
            <h2><label>Depart</label><input name="depart_date" value="{{data[4]}}" type="datetime"></h2>
            <h2><label>Arrive</label><input name="arrive_date" value="{{data[5]}}" type="datetime"></h2>
            <h2><label>Price</label><input name="price" value="{{data[6]}}" type="datetime"></h2>
            <input type="submit" value="Edit">
        </form>
    </div>
</body>
</html>
