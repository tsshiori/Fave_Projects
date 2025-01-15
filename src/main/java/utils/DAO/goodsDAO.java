package utils.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class goodsDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";
    public void addGoods(String date, String name, String amount, String favorite, String memo) throws Exception {
        String sql = "INSERT INTO osikatu (day, price, item, , memo) VALUES (?, ?, ?, ?, ?)";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            pstmt.setString(1, date);
            pstmt.setString(2, name);
            pstmt.setString(3, amount);
            pstmt.setString(4, favorite);
            pstmt.setString(5, memo);
            pstmt.executeUpdate();
        }
    }
}
