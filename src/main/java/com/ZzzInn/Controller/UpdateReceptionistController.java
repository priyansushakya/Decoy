package com.ZzzInn.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ZzzInn.ZzzInnDAO.ReceptionistDAO;

@WebServlet("/UpdateReceptionist")
public class UpdateReceptionistController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("_method");

        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
        } else if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Method not allowed.");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");
        String joinedDate = request.getParameter("joinedDate");
        String email = request.getParameter("email");

        int salary = 0;
        try {
            salary = Integer.parseInt(request.getParameter("salary"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("❌ Invalid salary.");
            return;
        }

        ReceptionistDAO dao = new ReceptionistDAO();
        boolean updated = dao.updateReceptionistFields(email, role, salary, joinedDate);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/Pages/AdminFolder/manageRecep.jsp");
        } else {
            response.getWriter().println("❌ Failed to update receptionist.");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        ReceptionistDAO dao = new ReceptionistDAO();
        boolean deleted = dao.deleteReceptionistByEmail(email);

        if (deleted) {
            response.sendRedirect(request.getContextPath() + "/Pages/AdminFolder/manageRecep.jsp");
        } else {
            response.getWriter().println("❌ Failed to delete receptionist.");
        }
    }
}