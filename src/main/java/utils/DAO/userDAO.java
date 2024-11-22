package utils.DAO;

import utils.Bean.userBean;

import java.sql.*;

public class userDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/your_database_name?useSSL=false&serverTimezone=UTC";

    // SELECT 条件あり
    public static userBean selectById(int id) {
        String sql = "SELECT * FROM students WHERE id = ?";
        userBean result = null;

        try (
                Connection con = DriverManager.getConnection(DB_URL);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setInt(1, id);

            // 実行＆結果をResultSetに格納
            try (ResultSet rs = pstmt.executeQuery()) {
                // 検索結果をStudentsBeanに代入
                if (rs.next()) {
                    result = new userBean(
                            rs.getString("log_id"),
                            rs.getString("password"),
                            rs.getString("nick"),
                            rs.getInt("regimg"),
                            rs.getInt("amounthand"),
                            rs.getInt("living"),
                            rs.getInt("saiosi"),
                            rs.getInt("mainwork")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return result; // 検索結果の追加がなければnullが返却される
    }
}
