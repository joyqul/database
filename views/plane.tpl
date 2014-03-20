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
        <select>
        <!-- for statement -->
            %for i in xrange(2000, 2020):
                <option> {{i}} </option>
            %end
        <!-- end for -->
        </select>
        <select>
            <option>January</option>
            <option>Febuary</option>
            <option>March</option>
            <option>April</option>
            <option>May</option>
            <option>June</option>
            <option>July</option>
            <option>August</option>
            <option>September</option>
            <option>Octorber</option>
            <option>Nomenber</option>
            <option>December</option>
        </select>
        <select>
        <!-- for statement -->
            %for i in xrange(1, 32):
                <option> {{i}} </option>
            %end
        <!-- end for -->
        </select>
        -
        <select>
        <!-- for statement -->
            %for i in xrange(0, 9):
                <option> 0{{i}} </option>
            %end
            %for i in xrange(10, 24):
                <option> {{i}} </option>
            %end
        <!-- end for -->
        </select>
        <select>
        <!-- for statement -->
            %for i in xrange(0, 9):
                <option> 0{{i}} </option>
            %end
            %for i in xrange(10, 60):
                <option> {{i}} </option>
            %end
        <!-- end for -->
        </select>
        </br>
        Arrive</br>
        <select>
        <!-- for statement -->
            %for i in xrange(2000, 2020):
                <option> {{i}} </option>
            %end
        <!-- end for -->
        </select>
        <select>
            <option>January</option>
            <option>Febuary</option>
            <option>March</option>
            <option>April</option>
            <option>May</option>
            <option>June</option>
            <option>July</option>
            <option>August</option>
            <option>September</option>
            <option>Octorber</option>
            <option>Nomenber</option>
            <option>December</option>
        </select>
        <select>
        <!-- for statement -->
            %for i in xrange(1, 32):
                <option> {{i}} </option>
            %end
        <!-- end for -->
        </select>
        -
        <select>
        <!-- for statement -->
            %for i in xrange(0, 9):
                <option> 0{{i}} </option>
            %end
            %for i in xrange(10, 24):
                <option> {{i}} </option>
            %end
        <!-- end for -->
        </select>
        <select>
        <!-- for statement -->
            %for i in xrange(0, 9):
                <option> 0{{i}} </option>
            %end
            %for i in xrange(10, 60):
                <option> {{i}} </option>
            %end
        <!-- end for -->
        </select>
        </br>
        Company </br>
        <input name="commit" type="text" />
        </br>
    <p><input type="submit" value="Create Plane"></br></p>
    </form>
</body>
</html>
