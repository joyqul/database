<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="/database/static/tablesorter.css" />
    <link rel="stylesheet" type="text/css" href="/database/static/main.css" />
    <link rel="stylesheet" type="text/css" href="/database/static/ticket.css" />
    <script type="text/javascript" src="/database/static/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="/database/static/js/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="/database/static/js/sort.js"></script>
</head>
<body>
    <div id="time">
    <div id="header">
        <ul><li><a href="signout">Sign out</a> </li></ul>
    </div>
    <div id="content">
        % if warning != "":
            <h3> {{warning}} </h3>
        % end
        <h1>{{title}}</h1>
        <div id="sort">
            <label><a href="/database/flight/timetable"><input type="button" value="End search" /></a></label>
        </div>
        <table id="flight" class="tablesorter">
        <thead>
            <tr>
                <th><h4>ID</h4></th>
                <th><h4>Code</h4></th>
                <th><h4>From</h4></th>
                <th><h4>To</h4></th>
                <th><h4>Depart</h4></th>
                <th><h4>Arrive</h4></th>
                <th><h4>Price</h4></th>
                <th data-sorter="false"><h4>Favorite</h4></th>
            </tr>
        </thead>
        <tbody>
            % for flight in data:
            <tr>
            % for i in xrange(7):
                <td> {{flight[i]}} </td>
            % end
                <td>
                    <a href="/database/flight/favorite/{{flight[0]}}" type="submit" name="edit" value="{{flight[0]}}">Add</a>
                </td>
            </tr>
            % end
        </tbody>
        </table>
    </div>
    <div id="footer">
        <p>May 2014, database project done by joyqul, hmlin</p>
    </div>
    </div>
</body>
</html>
