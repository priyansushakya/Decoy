<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Developers</title>
	<style>
	    body, html {
	      margin: 0;
	      padding: 0;
	      height: 100%;
	      font-family: 'Segoe UI', sans-serif;
	    }

	    .hero {
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
	      max-width: 1000px;
	      color: #fdfaf0;
	      width: 100%;
	      margin-top: 18%;
	    }

	    .content-box h1 {
	      font-size: 36px;
	      margin-bottom: 30px;
	    }

	    .developers-grid {
	      display: grid;
	      grid-template-columns: repeat(3, 1fr);
	      gap: 20px;
	      justify-items: center;
	    }

	    .developer-card {
	      background-color: rgba(255, 255, 255, 0.05);
	      border-radius: 10px;
	      padding: 10px;
	      width: 100%;
	      max-width: 220px;
	    }

	    .developer-card img {
	      width: 100%;
	      height: 220px;
	      object-fit: cover;
	      border-radius: 8px;
	      border: 2px solid #fdfaf0;
	    }

	    .developer-name {
	      margin-top: 10px;
	      font-size: 16px;
	      font-weight: bold;
	      color: #fdfaf0;
	    }
	</style>
</head>
<body>
	<div class="hero" style="background-image: url('<%= request.getContextPath() %>/Pages/Images/PhotoJava2.jpg');">
    <%@ include file="../Nav/header.jsp" %>

    <div class="overlay">
      <div class="content-box">
        <h1>Developers</h1>
        <div class="developers-grid">

          <!-- Developer 1 -->
          <div class="developer-card">
            <img src="<%= request.getContextPath() %>/Pages/Images/rhythm.png" alt="Rhythm Gurung">
            <div class="developer-name">Rhythm Gurung</div>
          </div>

          <!-- Developer 2 -->
          <div class="developer-card">
            <img src="<%= request.getContextPath() %>/Pages/Images/salina.png" alt="Salina Gurung">
            <div class="developer-name">Salina Gurung</div>
          </div>

          <!-- Developer 3 -->
          <div class="developer-card">
            <img src="<%= request.getContextPath() %>/Pages/Images/priyansu.png" alt="Priyansu Shakya">
            <div class="developer-name">Priyansu Shakya</div>
          </div>

          <!-- Developer 4 -->
          <div class="developer-card">
            <img src="<%= request.getContextPath() %>/Pages/Images/prajwal.png" alt="Prajwal Gurung">
            <div class="developer-name">Prajwal Gurung</div>
          </div>

          <!-- Developer 5 -->
          <div class="developer-card">
            <img src="<%= request.getContextPath() %>/Pages/Images/lucky.png" alt="Lucky Gurung">
            <div class="developer-name">Lucky Gurung</div>
          </div>

          <!-- Developer 6 -->
          <div class="developer-card">
            <img src="<%= request.getContextPath() %>/Pages/Images/sakar.png" alt="Sakar Baniya">
            <div class="developer-name">Sakar Baniya</div>
          </div>

        </div>
      </div>
    </div>
  </div>
</body>
</html>
