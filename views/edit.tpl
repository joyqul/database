<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../../static/style.css" />
</head>
<body>
    <p> {{warning}} </p>
    <h1>Edit flight</h1>
    <form action="/database/flight/edit/{{flight_id}}" method="post">
        <b>Code:</b> <input name="code" type="text" value="{{data[1]}}"/> </br>
        <b>From:</b> <input name="from" type="text" value="{{data[2]}}" /> </br>
        <b>To:</b> <input name="to" type="text" value="{{data[3]}}" /> </br>
        <b>Depart:</b>
        <input name="depart_date" value="yyyy-mm-dd" type="date">
        <input name="depart_time" value="hh:mm" type="time">
        </br>
        <b>Arrive</b>
        <input name="arrive_date" value="yyyy-mm-dd" type="date">
        <input name="arrive_time" value="hh:mm" type="time">
        </br>
        <p><input type="submit" value="Edit"></p>
    </form>
    <p><a href="../timetable"></br> Go Back </p>
</body>
</html>
