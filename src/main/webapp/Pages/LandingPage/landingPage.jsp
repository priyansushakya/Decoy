<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>ZzzInn - Welcome</title>
  <style>
    body, html {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      height: 100%;
    }

    /* photo background rakhne */
    .hero {
      background-image: url('../Images/PhotoJava2.jpg');
      background-size: cover; /* photo lai full area cover garne */
      background-position: center; /* photo center ma rakhne */
      height: 100vh; /* screen ko full height */
      position: relative; /* overlay ko lagi */
    }

    /* black transparent overlay */
    .overlay {
      position: absolute;
      top: 0; left: 0; right: 0; bottom: 0; /* sabai side cover garne */
      background-color: rgba(0, 0, 0, 0.6); /* half transparent black */
      display: flex; /* flex use gareko */
      flex-direction: column; /* tala tala aune content */
      align-items: center; /* horizontal center */
      justify-content: center; /* vertical center */
      text-align: center; /* text center align */
      color: #fdfaf0; /* light color text */
      padding: 20px; /* bhitra space */
    }

    /* overlay ko heading */
    .overlay h1 {
      font-size: 48px;
      font-weight: bold;
      margin-bottom: 15px;
    }

    /* overlay ko paragraph */
    .overlay p {
      font-size: 18px;
      margin-bottom: 30px;
    }

    /* button design */
    .btn {
      padding: 12px 30px;
      background-color: #473c38; /* brown color */
      color: white; /* white text */
      text-decoration: none;
      font-weight: bold;
      border-radius: 6px; /* round corner */
      transition: background-color 0.3s ease; /* smooth hover effect */
    }

    /* button hover ma color change */
    .btn:hover {
      background-color: #64544e;
    }

    /* navbar design */
    .navbar {
      position: absolute; /* top fix */
      top: 0;
      width:100%;
      background: rgba(0, 0, 0, 0.5); /* transparent black */
      display: flex; /* flex layout */
      align-items: center; /* vertically center */
      justify-content: space-between; /* space between logo and nav */
      padding: 10px 50px;
      box-sizing: border-box;
      z-index: 1000; /* sabai bhanda mathi */
    }

    /* logo image size */
    .nav-left img {
      width: 120px;
    }

    /* nav links design */
    .nav-right {
      display: flex;
      gap: 30px; /* nav links bich 30px gap */
    }

    /* nav links ko color and size */
    .nav-right a {
      color: #fdfaf0;
      text-decoration: none;
      font-weight: 500;
      font-size: 16px;
    }

    /* nav links hover garda color change */
    .nav-right a:hover {
      color: #dcd4c8;
    }

    /* Responsive - mobile screen adjust */
    @media (max-width: 768px) {
      .nav-right {
        flex-direction: column; /* mobile ma tala tala nav links */
        gap: 10px;
      }
    }
  </style>
</head>
<body>

<div class="hero">

  <%@ include file="../Nav/header.jsp" %>
  <!-- Hero Overlay -->
  <div class="overlay">
    <h1>Welcome to ZzzInn</h1>
    <p>Get Your Zzz's in Our Inn.</p>
    <a href="../Login/Login.jsp" class="btn">Login</a>
  </div>
</div>

</body>
</html>