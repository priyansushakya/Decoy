<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Contact Us - ZzzInn</title>
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
      padding-top: 240px;
      padding-left: 40px;
      padding-right: 40px;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      overflow-y: auto;
    }

    .contact-container {
      background-color: rgba(0, 0, 0, 0.5);
      padding: 30px;
      border-radius: 10px;
      max-width: 1000px;
      width: 100%;
      color: #fdfaf0;
      display: flex;
      gap: 40px;
      flex-wrap: wrap;
    }

    .contact-info, .contact-form {
      flex: 1 1 400px;
    }

    .contact-info h1 {
      font-size: 32px;
      margin-bottom: 15px;
    }

    .contact-info p {
      margin: 10px 0;
      font-size: 16px;
    }

    .contact-info span {
      font-weight: bold;
    }

    .contact-form input,
    .contact-form textarea {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: none;
      border-radius: 5px;
      font-size: 15px;
    }

    .contact-form textarea {
      resize: vertical;
      height: 100px;
    }

    .contact-form button {
      background-color: #473c38;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .contact-form button:hover {
      background-color: #64544e;
    }

    @media (max-width: 768px) {
      .overlay {
        padding-top: 120px;
      }
    }
    .contact-form input::placeholder,
    .contact-form textarea::placeholder {
      font-family: 'Segoe UI', sans-serif;
      color: #aaa;
      font-size: 15px;
    }
  </style>
</head>
<body>
  <div class="hero">
    <%@ include file="../Nav/header.jsp" %>
    <div class="overlay">
      <div class="contact-container">
        <div class="contact-info">
          <h1>Contact Us</h1>
          <p>We’re happy to help you! Whether you have a question, need help with bookings, or just want to give feedback — feel free to contact us.</p>
          <p>📍 <span>Address:</span> Pokhara, Nepal</p>
          <p>📞 <span>Phone:</span> +977 9800000000</p>
          <p>📧 <span>Email:</span> support@zzzinn.com</p>
          <p>⏰ <span>Hours:</span> 8:00 AM – 10:00 PM, Everyday</p>
        </div>
        <div class="contact-form">
          <form>
            <input type="text" placeholder="Your Name" required>
            <input type="email" placeholder="Your Email" required>
            <textarea placeholder="Your Message" required></textarea>
            <button type="submit">Send Message</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
</html>