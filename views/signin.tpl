<!DOCTYPE html>
<html>
<head>
    <title> {{title}} </title>
    <meta charset = "utf-8" />
    <link rel="stylesheet" type="text/css" href="../static/style.css" />
</head>
<body>
<div id="index">
   <p id="top"><a href="signup">Sign up</a></p>
   <p> {{warning}} </p>
   <h1> Sign in</h1>
   <form action="/database/flight/signin" method="post">
       <h3>Email: <input name="email" type="text" /> </h3>
       <h3>Password: <input name="passwd" type="password" /> </h3>
   <p><input type="submit" value="Sign in"></br></p>
   </form>
   <p><a href="">Forgot your password?</a></p>
</div>
</body>
</html>
