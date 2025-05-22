package com.ZzzInn.ZzzInnDAO;

import java.sql.*;
import java.util.*;
import com.ZzzInn.Database.DatabaseConnector;

public class ReceptionistDashboardDAO {
    private Connection conn;

    public ReceptionistDashboardDAO() throws Exception {
        conn = DatabaseConnector.getConnection();
    }

    public Integer getTotalBookings() {
        String query = "SELECT COUNT(*) FROM customer_room";
        try (PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Integer getAvailableRooms() {
        String query = "SELECT COUNT(*) FROM room WHERE status = 'notBooked'";
        try (PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Integer getGuestsCheckedIn() {
        String query = "SELECT COUNT(*) FROM customer_room WHERE CheckOutDate IS NULL";
        try (PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<String[]> getRecentActivities() {
        List<String[]> activities = new ArrayList<>();
        String query = """
            SELECT CONCAT(c.FirstName, ' ', c.LastName) AS guest,
                   cr.CheckInDate,
                   cr.CheckOutDate,
                   cr.RoomNumber
            FROM customer_room cr
            JOIN customer c ON cr.CustomerID = c.CustomerID
            ORDER BY cr.CheckInDate DESC
            LIMIT 5
        """;

        try (PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String guest = rs.getString("guest");
                String checkIn = rs.getString("CheckInDate");
                String checkOut = rs.getString("CheckOutDate");
                String room = rs.getString("RoomNumber");
                String activity = (checkOut == null) ? "checked in" : "checked out";
                String time = (checkOut == null) ? checkIn : checkOut;
                activities.add(new String[] {
                    "Guest \"" + guest + "\" " + activity + " (Room " + room + ")",
                    time
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }

}