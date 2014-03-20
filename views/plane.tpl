<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
    <p> {{warning}} </p>
    <h1>New plane</h1>
    <form action="/database/flight/plane" method="post">
        Code </br>
        <input name="code" type="text" />
        </br>
        From </br>
        <input name="from" type="text" />
        </br>
        To </br>
        <input name="to" type="text" />
        </br>
        Depart</br>
        <input name="depart_date" value="yyyy-mm-dd" type="date">
        <input name="depart_time" value="hh:mm" type="time">
        </br>
        Arrive</br>
        <input name="arrive_date" value="yyyy-mm-dd" type="date">
        <input name="arrive_time" value="hh:mm" type="time">
        </br>
        Company </br>
        <input name="commit" type="text" />
        </br>
    <p><input type="submit" value="Create Plane"></br></p>
    </form>
</body>
</html>
