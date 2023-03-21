<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Alexandria | Find your next read</title>
    <link rel="icon" type="image/x-icon" href="resources/logo.png">
    <link rel="stylesheet" href="resources/styles.css"/>
</head>
<body>
<div id = "header">
    <img class=logo src="resources/logo.png"><a class="sitename"><h2><strong>Alexandria</strong></h2></a>
    <a class="login-btn" href="loginpage.do" role="button">  Log In</a>
    <a class="signin-btn" href="signuppage.do" role="button">  Sign Up  </a>
    <a class="trending-btn" href="" role="button">  Trending  </a>
    <a class="search-btn" href="searchpage.do" role="button">Search</a>
</div>
<div id="home-left">
<div id="home-back-img"></div>
<div id="home-alexandria-greeting"><h1>Welcome to Alexandria</h1></div>
 <div id="home-greeting">
     <h2>Alexandria provides a platform for you to connect with like-minded individuals who share your passion for reading. Search books that suit your interests. Join Book Clubs. Find your community and help us preserve knowledge</h2>
 </div>
<div id="home-cover1"><img src="resources/aristotlecover.png" class="cover"></div>
<div id="home-cover2"><img src="resources/camuscover.jpg" class="cover"></div>
<div id="home-cover3"><img src="resources/cristocover.jpeg" class="cover"></div>
<div id="home-cover4"><img src="resources/hpcover.jpg" class="cover"></div>
<div id="home-cover5"><img src="resources/solitudecover.png" class="cover"></div>
</div>
    <h1 class="home-signup-title">Sign Up</h1>
    <div class="home-signup-container">
    <form action="signup.do" method="POST">
		<input type="text" placeholder="First Name" class="home-input-fname" name="firstName"> 
		<input type="text" placeholder="Last Name" class="home-input-lname" name="lastName"/>
		<br>
		<input type="text" placeholder="Email" class="home-input-email" name="email"/>
		<br>
		<input type="text" placeholder="Username" class="home-input-username" name="username"/> 
		<input type="password" placeholder="Password" class="home-input-password" name="password"/> 
			<button type="submit" role="button" class="home-signup-submit-btn"><img src="resources/loginicon.svg"></button>
	</form>
<div id="home-right-background">
<div id="home-right">
    
	
	</div>
</div>
</div>
</body>
</html>