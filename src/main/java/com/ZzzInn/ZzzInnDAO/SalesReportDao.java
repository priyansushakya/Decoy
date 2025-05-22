package com.ZzzInn.ZzzInnDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ZzzInn.ZzzInn.SalesReport;

public class SalesReportDao {
    private Connection conn;

    public SalesReportDao(Connection conn) {
        this.conn = conn;
    }

    public List<SalesReport> getSalesReport() throws SQLException {

            List<SalesReport> list = new ArrayList<>();
            String sql = """
                SELECT 
                    DATE_FORMAT(cr.CheckOutDate, '%M %Y') AS Month,
                    SUM(r.Price) AS total_sales
                FROM 
                    customer_room cr
                JOIN 
                    room r ON cr.RoomNumber = r.RoomNumber
                GROUP BY 
                    YEAR(cr.CheckOutDate), MONTH(cr.CheckOutDate)
                ORDER BY 
                    cr.CheckOutDate DESC;
            """;

            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String month = rs.getString("Month");
                        double total = rs.getDouble("total_sales");

                        list.add(new SalesReport(month, total));
                    }
            }
            return list;
        }
}