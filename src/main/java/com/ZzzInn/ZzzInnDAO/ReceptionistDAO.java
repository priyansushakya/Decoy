package com.ZzzInn.ZzzInnDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.ZzzInn.ZzzInn.receptionist;
import com.ZzzInn.Database.DatabaseConnector;

public class ReceptionistDAO {

    private static final String SELECT_ALL_RECEPTIONISTS =
        "SELECT FirstName, LastName, Email, EmpPhone, Role, Salary, JoinedDate, Photo FROM employee WHERE Role = 'receptionist'";

    private static final String UPDATE_RECEPTIONIST =
        "UPDATE employee SET Role = ?, Salary = ?, JoinedDate = ? WHERE Email = ? AND Role = 'receptionist'";

    private static final String DELETE_RECEPTIONIST =
        "DELETE FROM employee WHERE Email = ? AND Role = 'receptionist'";

    public List<receptionist> getAllReceptionists() {
        List<receptionist> list = new ArrayList<>();

        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_RECEPTIONISTS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                receptionist r = new receptionist(
                    rs.getString("FirstName"),
                    rs.getString("LastName"),
                    rs.getString("Email"),
                    rs.getString("EmpPhone"),
                    rs.getString("Role"),
                    rs.getInt("Salary"),
                    rs.getString("JoinedDate"),
                    rs.getString("Photo")
                );
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateReceptionistFields(String email, String role, int salary, String joinedDate) {
        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_RECEPTIONIST)) {

            ps.setString(1, role);
            ps.setInt(2, salary);
            ps.setString(3, joinedDate);
            ps.setString(4, email);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReceptionistByEmail(String email) {
        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_RECEPTIONIST)) {

            ps.setString(1, email);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}