package utils.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class scheduleDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";

    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    public static void insertEvent(String log_id, int amounthand) {
        // オートインクリメントされるカラム（id）を除外して挿入
        String sql = "INSERT INTO event (log_id, amounthand, futurewage) VALUES (?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Connection con = DriverManager.getConnection(DB_URL);
            Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setString(1, log_id);
            pstmt.setInt(2,amounthand);
            pstmt.setInt(3, 0);

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);  // 挿入された行数を表示

            if (rowsAffected == 0) {
                System.out.println("データが挿入されませんでした。");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();  // エラー詳細を表示
        }
    }

}
