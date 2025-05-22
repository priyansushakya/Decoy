package com.ZzzInn.Controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ZzzInn.ZzzInn.Employee;
import com.ZzzInn.Database.DatabaseConnector;
import com.ZzzInn.utility.EncryptDecrypt;

@WebServlet("/UpdateAdminController")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
public class UpdateAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Employee loggedInUser = (Employee) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect("Pages/Login/Login.jsp");
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String imagePath = loggedInUser.getImagePath();
        Part imagePart = null;
        String fileName = "";

        try {
            imagePart = request.getPart("profileImage");
            if (imagePart != null) {
                fileName = imagePart.getSubmittedFileName();
                if (!fileName.isEmpty()) {
                    String appPath = request.getServletContext().getRealPath("");
                    String uploadPath = appPath + File.separator + "Pages/Images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();

                    imagePath = "Pages/Images/" + fileName;
                    imagePart.write(uploadPath + File.separator + fileName);
                }
            }
        } catch (Exception e) {
            // profileImage might not exist on password-only update — skip error
        }

        try {
            Connection conn = DatabaseConnector.getConnection();
            String sql;
            PreparedStatement ps;
            boolean updatePassword = newPassword != null && !newPassword.isEmpty();

            if (updatePassword) {
                String decryptedStoredPassword = EncryptDecrypt.decrypt(loggedInUser.getPassword());

                if (currentPassword == null || !currentPassword.equals(decryptedStoredPassword)) {
                    request.setAttribute("errorMsg", "❌ Current password is incorrect.");
                    request.getRequestDispatcher("Pages/AdminFolder/AdminProfile.jsp").forward(request, response);
                    return;
                }

                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("errorMsg", "❌ New password and Confirm password do not match.");
                    request.getRequestDispatcher("Pages/AdminFolder/AdminProfile.jsp").forward(request, response);
                    return;
                }

                String encryptedNewPassword = EncryptDecrypt.encrypt(newPassword);
                sql = "UPDATE employee SET FirstName=?, LastName=?, Username=?, EmpPhone=?, Photo=?, Password=? WHERE Email=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, firstName != null ? firstName : loggedInUser.getFirstName());
                ps.setString(2, lastName != null ? lastName : loggedInUser.getLastName());
                ps.setString(3, username != null ? username : loggedInUser.getUsername());
                ps.setString(4, phone != null ? phone : loggedInUser.getPhone());
                ps.setString(5, imagePath);
                ps.setString(6, encryptedNewPassword);
                ps.setString(7, email);
            } else {
                sql = "UPDATE employee SET FirstName=?, LastName=?, Username=?, EmpPhone=?, Photo=? WHERE Email=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, username);
                ps.setString(4, phone);
                ps.setString(5, imagePath);
                ps.setString(6, email);
            }

            int updated = ps.executeUpdate();

            if (updated > 0) {
                loggedInUser.setFirstName(firstName);
                loggedInUser.setLastName(lastName);
                loggedInUser.setUsername(username);
                loggedInUser.setPhone(phone);
                loggedInUser.setImagePath(imagePath);
                if (updatePassword) {
                    loggedInUser.setPassword(EncryptDecrypt.encrypt(newPassword));
                }

                session.setAttribute("loggedInUser", loggedInUser);
                session.setAttribute("successMsg", updatePassword ? "✅ Password updated successfully." : "✅ Profile updated successfully.");
                response.sendRedirect("Pages/AdminFolder/AdminProfile.jsp");
            } else {
                request.setAttribute("errorMsg", "❌ Failed to update profile.");
                request.getRequestDispatcher("Pages/AdminFolder/AdminProfile.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "❌ Error: " + e.getMessage());
            request.getRequestDispatcher("Pages/AdminFolder/AdminProfile.jsp").forward(request, response);
        }
    }
}