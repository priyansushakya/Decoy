<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Rooms - ZzzInn</title>
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
      align-items: flex-start; /* align from top */
      padding-top: 180px; /* 👈 push it down */
      padding-left: 40px;
      padding-right: 40px;
      overflow-y: auto;
    }

    .content-box {
      background-color: rgba(0, 0, 0, 0.5);
      color: #fdfaf0;
      padding: 30px;
      border-radius: 10px;
      max-width: 800px;
      width: 100%;
    }

    .content-box h1 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 36px;
    }

    .content-box h3 {
      margin-top: 0;
      color: #fff;
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
        <h1>Explore Our Rooms</h1>

        <h3>Deluxe Room</h3>
        <p>Elegant and spacious, our Deluxe Room includes a king-size bed, private balcony, air conditioning, high-speed Wi-Fi, and a beautiful city view — perfect for couples or solo travelers who want comfort with style.</p>

        <h3>Standard Room</h3>
        <p>Simple, clean, and cozy — our Standard Room features a queen bed, attached bathroom, smart TV, Wi-Fi, and all basic essentials. A great option for short stays and budget-conscious guests.</p>

        <h3>Family Suite</h3>
        <p>Our Family Suite is designed for comfort and space. It includes two separate bedrooms, a shared living area, dining table, and a balcony. Ideal for families or groups who want to stay together with privacy.</p>
      </div>
    </div>
  </div>
</body>
</html>