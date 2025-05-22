<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>About Us - ZzzInn</title>
  <style>
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: 'Segoe UI', sans-serif;
    }

    .hero {
      background-image: url('../Images/PhotoJava2.jpg');
      background-size: cover;
      background-position: center;
      height: 100vh;
      position: relative;
    }

    .overlay {
      position: absolute;
      top: 0; left: 0; right: 0; bottom: 0;
      background-color: rgba(0, 0, 0, 0.6);
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px;
      text-align: center;
      overflow-y: auto;
    }

    .content-box {
      background-color: rgba(0, 0, 0, 0.5);
      padding: 30px;
      border-radius: 10px;
      max-width: 800px;
      color: #fdfaf0;
    }

    .content-box h1 {
      font-size: 36px;
      margin-bottom: 20px;
    }

    .content-box p {
      font-size: 17px;
      line-height: 1.6;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
  <div class="hero">
    <%@ include file="../Nav/header.jsp" %>

    <div class="overlay">
      <div class="content-box">
        <h1>About ZzzInn</h1>
        <p>
		  Welcome to <strong>ZzzInn</strong> — your home away from home. We are dedicated to providing <strong>warm hospitality</strong>, <strong>clean and comfortable rooms</strong>, and <strong>exceptional customer service</strong>.
		</p>
		<p>
		  Whether you're traveling for business, enjoying a family vacation, or simply taking a well-deserved break, ZzzInn offers a peaceful retreat where you can relax and recharge in comfort.
		</p>
		<p>
		  At ZzzInn, you're more than just a guest — <em>you're part of our family</em>.
		</p>

      </div>
    </div>
  </div>
</body>
</html>