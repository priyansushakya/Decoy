package com.ZzzInn.ZzzInnDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ZzzInn.ZzzInn.OccupancyReport;

public class OccupancyReportDao {
    private Connection conn;

    public OccupancyReportDao(Connection conn) {
        this.conn = conn;
    }

    public List<OccupancyReport> getOccupancyReport() throws SQLException {

            List<OccupancyReport> list = new ArrayList<>();
            String sql = """
                SELECT 
                    r.RoomType,
                    COUNT(r.RoomType) AS total_rooms,
                    SUM(CASE WHEN cr.CheckOutDate >= CURDATE() THEN 1 ELSE 0 END) AS occupied,
                    COUNT(r.RoomNumber) - SUM(CASE WHEN cr.CheckOutDate >= CURDATE() THEN 1 ELSE 0 END) AS vacant
                FROM 
                    room r
                LEFT JOIN 
                    customer_room cr ON r.RoomNumber = cr.RoomNumber
                GROUP BY 
                    r.RoomType;
            """;

            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new OccupancyReport(
                        rs.getString("RoomType"),
                        rs.getInt("total_rooms"),
                        rs.getInt("occupied"),
                        rs.getInt("vacant")
                    ));
                }
            }
            return list;
        }

}