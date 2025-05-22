package com.ZzzInn.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
@WebFilter(urlPatterns = { "/*"} )
public class AuthenticationFilter implements Filter {
      
    /**
 * 
 */
	//private static final long serialVersionUID = 1L;

	public void init(FilterConfig fConfig) throws ServletException 
	{
// TODO Auto-generated method stub
	}
	
	public void destroy()
	{
// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException 
	{
		HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // Print URI for debugging
        System.out.println("Request URI: " + uri);

        // Allow access to login page or controller without authentication
        //if (uri.contains("/Pages/Login/Login.jsp") || uri.contains("LoginController")) {
            //chain.doFilter(request, response);
            //return
        //}
        
        if(uri.endsWith("landingPage.jsp") || uri.endsWith("AboutZzzinn.jsp") || uri.endsWith("Developers.jsp") || uri.endsWith("contact.jsp") || uri.endsWith("room.jsp") || uri.endsWith("RegisterEmployee.jsp") || uri.endsWith("RegisterEmployee.css") || uri.endsWith("PhotoJava1.jpg") || uri.endsWith("PhotoJava2.jpg") || uri.endsWith("RegisterEmployee") ||  uri.endsWith("rhythm.png") || uri.endsWith("salina.png") || uri.endsWith("priyansu.png") || uri.endsWith("lucky.png") || uri.endsWith("sakar.png") || uri.endsWith("prajwal.png")) 
        {
        	chain.doFilter(request, response);
        	return;
        }
        
        
        // Redirect to login page if not logged in and trying to access protected page
        if (!loggedIn && uri.endsWith("Login.jsp") || uri.endsWith("LoginController") || uri.endsWith("LOGO.png") || uri.endsWith("login.css")){
            //res.sendRedirect(req.getContextPath() + "/Pages/Login/Login.jsp");
        	chain.doFilter(request, response);
        	return;
        }
        
     // Role-based access control
        if (uri.contains("/AdminFolder/") && !"admin".equalsIgnoreCase(role)) 
        {
            res.sendRedirect(req.getContextPath() + "/Pages/Login/Login.jsp");
            return;
        }

        if (uri.contains("/Receptionist/") && !"receptionist".equalsIgnoreCase(role)) {
            res.sendRedirect(req.getContextPath() + "/Pages/Login/Login.jsp");
            return;
        }

        if (loggedIn) 
        {
            
            // Prevent access to login page for logged-in users
            if (uri.endsWith("Login.jsp") || uri.endsWith("LoginController"))
            {
                if ("admin".equalsIgnoreCase(role)) {
                    res.sendRedirect(req.getContextPath() + "/Pages/AdminFolder/AdminDashBoard.jsp");
                    return;
                } else if ("receptionist".equalsIgnoreCase(role)) {
                    res.sendRedirect(req.getContextPath() + "/Pages/Receptionist/ReceptionistDashBoard.jsp");
                    return;
                }
            }


            // Otherwise, allow access
            chain.doFilter(request, response);
            return;
        }
}
}