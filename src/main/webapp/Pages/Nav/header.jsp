<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>HomeHeading</title>
	<!-- MainNavbar.jsp -->
	<style>
		.navbar {
		  position: absolute;
		  top: 0;
		  width: 100%;
		  background: linear-gradient(to bottom, rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.0)); /* Gradient */
		  display: flex;
		  align-items: center;
		  justify-content: space-between;
		  padding: 10px 50px;
		  box-sizing: border-box;
		  z-index: 1000;
		}
	
	  .nav-left img {
	    width: 22%;
	  }
	
	  .nav-right {
	    display: flex;
	    gap: 30px;
	  }
	
	  .nav-right a {
	    color: #fdfaf0;
	    text-decoration: none;
	    font-weight: 500;
	    font-size: 16px;
	    position: relative;
	  }
	
	  .nav-right a:hover {
	    color: #dcd4c8;
	  }
	  
		  /* Dropdown container */
		.dropdown {
		  position: relative;
		  display: inline-block;
		}
		
		/* Dropdown main button */
		.dropbtn {
		  color: #fdfaf0;
		  text-decoration: none;
		  font-weight: 500;
		  font-size: 16px;
		  cursor: pointer;
	  	  position: relative; /* Required for ::after positioning */
	  		z-index: 1002; /* Higher than dropdown-content */
		}
		
		/* Dropdown hidden content */
		.dropdown-content {
		  display: none;
		  position: absolute;
		  left: 50%; /* Center horizontally */
		  transform: translateX(-50%); /* Shift it back by half its width */
		  background-color: rgba(0, 0, 0, 0.9);
		  width: auto;
		  max-width: 180px;
		  box-shadow: 0px 8px 16px rgba(0,0,0,0.3);
		  z-index: 1001;
		  border-radius: 4px;
		  padding: 10px 0;
		  top: 100%; /* Position right below the button */
		  margin-top: 0px;
		}
		
		/* Each dropdown link */
		.dropdown-content a {
		  color: #fdfaf0;
		  padding: 10px 20px;
		  text-decoration: none;
		  display: block;
		  font-size: 14px;
		}
		
		/* Hover effect on dropdown items */
		.dropdown-content a:hover {
		  background-color: rgba(255, 255, 255, 0.1);
		  color: #dcd4c8;
		}
		
		/* Show dropdown on hover */
		.dropdown:hover .dropdown-content,
		.dropdown-content:hover {
		  display: block;
		}
		
		.nav-right a::after{
	    content: '';
	    height: 3px;
	    width: 0%;
	    background: white;
	    position: absolute;
	    left:0;
	    bottom:-5px;
	    transition: 0.4s;
	  	}
	  	
	  	.nav-right a:hover::after{
	    width:100%;
	  	}
	  	
	  	/* On active (current page) */
		.nav-right a.active::after,
		.dropbtn.active::after {
		  width: 100%;
		}
	
	  @media (max-width: 768px) {
	    .nav-right {
	      flex-direction: column;
	      gap: 10px;
	    }
	  }
	</style>
</head>
<body>
	<%
	    String uri = request.getRequestURI();
	%>
	
	<div class="navbar">
	  <div class="nav-left">
	    <img src="../Images/LOGO.png" alt="ZzzInn Logo" />
	  </div>
	  <div class="nav-right">
	    <a href="../LandingPage/landingPage.jsp" class="<%= uri.contains("landingPage.jsp") ? "active" : "" %>">Home</a>
	    
	    <div class="dropdown">
	      <a href="#" class="dropbtn <%= (uri.contains("AboutZzzinn.jsp") || uri.contains("Developers.jsp")) ? "active" : "" %>">About</a>
	      <div class="dropdown-content">
	        <a href="../AboutUs/AboutZzzinn.jsp" class="<%= uri.contains("AboutZzzinn.jsp") ? "active" : "" %>">ZzzInn</a>
	        <a href="../AboutUs/Developers.jsp" class="<%= uri.contains("Developers.jsp") ? "active" : "" %>">Developers</a>
	      </div>
	    </div>
	    
	    <a href="../Rooms/room.jsp" class="<%= uri.contains("room.jsp") ? "active" : "" %>">Rooms</a>
	    <a href="../Contact/contact.jsp" class="<%= uri.contains("contact.jsp") ? "active" : "" %>">Contact</a>
	  </div>
	</div>
</body>
</html>