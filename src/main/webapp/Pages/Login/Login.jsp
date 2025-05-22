<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>ZzzInn</title>  
  	<style>
/* login.css */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	background: url('../Images/PhotoJava2.jpg');
	background-size: cover; /* photo lai full area cover garne */
	background-position: center; /* photo center ma rakhne */
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
}

.top-gradient-bar {
	position: absolute;
	top: 0;
	width: 100%;
	height: 80px; /* Adjust height if needed */
	background: linear-gradient(to bottom, rgba(0, 0, 0, 0.8),
		rgba(0, 0, 0, 0.0));
	z-index: 1000;
}
/* black transparent overlay */
.login-wrapper {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0; /* sabai side cover garne */
	background-color: rgba(0, 0, 0, 0.6); /* half transparent black */
	display: flex; /* flex use gareko */
	flex-direction: column; /* tala tala aune content */
	align-items: center; /* horizontal center */
	justify-content: center; /* vertical center */
	text-align: center; /* text center align */
	color: #fdfaf0; /* light color text */
	padding: 20px; /* bhitra space */
}

.login-wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
	padding: 20px;
}

.login-box {
	background-color: #fdfaf0;
	border-radius: 16px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
	padding: 40px 30px;
	max-width: 400px;
	width: 100%;
	text-align: center;
	position: relative;
}

.logoimage {
	width: 115px; /* Smaller size */
	height: 115px;
	background-color: #473c38;
	border-radius: 50%; /* Circle */
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15); /* Softer shadow */
}

.logoimage img {
	width: 110px; /* Smaller logo inside */
	height: 110px;
	object-fit: contain;
	transition: transform 0.3s ease;
}

.logoimage img:hover {
	transform: scale(1.05);
}

.form-group {
	margin-bottom: 20px;
	text-align: left;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
	color: #333;
}

input[type="email"], input[type="password"] {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 16px;
	transition: border-color 0.3s;
}

input[type="email"]:focus, input[type="password"]:focus {
	border-color: #3498db;
	outline: none;
}

.login-btn {
	width: 100%;
	padding: 12px;
	background-color: #473c38;
	color: #fff;
	font-size: 16px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.login-btn:hover {
	background-color: #64544e;
}

/* Wrapper to hold the spinning border */
.close-btn-wrapper {
	position: absolute;
	top: 20px;
	right: 20px;
	width: 40px;
	height: 40px;
	display: flex;
	align-items: center;
	justify-content: center;
}

/* Close button styling */
.close-btn {
	text-decoration: none;
	font-size: 35px;
	color: #555;
	font-weight: bold;
	cursor: pointer;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 2;
	line-height: 1;
}

.close-btn:hover {
	color: black;
}

/* Spinning border effect */
.close-btn-wrapper::before {
	content: '';
	position: absolute;
	width: 40px;
	height: 40px;
	border: 2px solid transparent;
	border-radius: 50%;
	z-index: 1;
	transform: rotate(0deg);
	transition: transform 0.6s ease;
	opacity: 0; /* initially hidden */
}

.close-btn-wrapper:hover::before {
	border-top: 2px solid black;
	transform: rotate(360deg);
	opacity: 1; /* becomes visible only on hover */
}
</style>	
</head>
<body>
<div class="top-gradient-bar"></div>
  <div class="login-wrapper">
    <div class="login-box">
    <div class="close-btn-wrapper">
            <a href="${pageContext.request.contextPath}/Pages/LandingPage/landingPage.jsp" class="close-btn" title="Close">&times;</a>
        </div>
      <div class="logoimage">
      	<img src="${pageContext.request.contextPath}/Pages/Images/LOGO.png" alt="logo">
      </div>

      <c:if test="${not empty error}">
				<div class="alert alert-danger alert-dismissible fade show"
					role="alert">
					
					<p style="color: red;">${error}</p>
					<button type="button" class="btn-close" data-bs-dismiss="alert"
						aria-label="Close"></button>
				</div>
			</c:if>

			<%
			String success = request.getParameter("success");
			%>

			<%
			if ("1".equals(success)) {
			%>
			<div
				style="padding: 10px; background-color: #d4edda; color: #155724; border-radius: 5px; margin-bottom: 15px;">
				❌ Unauthorized role.</div>
			<%
			} else if ("2".equals(success)) {
			%>
			<div
				style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
				❌ Invalid password, Please Try again.</div>
			<%
			} else if ("3".equals(success)) {
			%>
			<div
				style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
				❌ Invalid email, Try again.</div>
			<%
			} else if ("4".equals(success)) {
			%>
			<div
				style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
				❌ An system error occurred!</div>
			<%
			}
			%>
			<form method="POST" action="${pageContext.request.contextPath}/LoginController">
        <div class="form-group">
          <label for="email">Email address</label>
          <input type="email" id="email" name="email" required />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required />
        </div>

        <button type="submit" class="login-btn">Log In</button> 
      </form>

      <!--  <p class="register-link">Don't have an account? <a href="registerUser.jsp">Register</a></p>-->
    </div>
</div>
</body>
</html>