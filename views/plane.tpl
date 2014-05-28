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
            <ul><li><a href="timetable">Back</a></li></ul>
        </div>
        <div id="content">
        % if warning !="":
            <h3> {{warning}} </h3>
        % end
            <h1>New plane</h1>
            <form action="/database/flight/plane" method="post">
                <h2><label>Code</label><input name="code" type="text" /></h2>
                <h2><label>From</label><input name="from" type="text" /></h2>
                <h2><label>To</label><input name="to" type="text" /></h2>
                <h2><label>Depart</label><input name="depart_date" value="yyyy-mm-dd" type="date"></br>
                <h2><label></label><input name="depart_time" value="hh:mm" type="time"></h2>
                <h2><label>Arrive</label><input name="arrive_date" value="yyyy-mm-dd" type="date"></h2>
                <h2><label></label><input name="arrive_time" value="hh:mm" type="time"></h2>
                <h2><label>Price</label><input name="price" type="number" /></h2>
                <input type="submit" value="Create"></br>
            </form>
        </div>
        <div id="footer">
            <p>May 2014, database project done by joyqul, hmlin</p>
        </div>
    </div>
</body>
</html>
