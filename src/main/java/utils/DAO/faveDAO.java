package utils.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

public class faveDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    // データの追加(INSERT)
    public static void insertFave(String img, String name, LocalDate birthday, String osimemo, String log_id, int cate_id) {
        // SQL文
        String sql = "INSERT INTO osi (img, name, birthday, osimemo, log_id, cate_id) VALUES (?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD); // 1.DB接続
                PreparedStatement pstmt = con.prepareStatement(sql); // 2.pstmtの作成
        ) {
            // 3.プレースホルダに値をセット
            pstmt.setString(1, img); // img
            pstmt.setString(2, name); // name
            pstmt.setDate(3, java.sql.Date.valueOf(birthday)); // birthday (LocalDateをjava.sql.Dateに変換)
            pstmt.setString(4, osimemo); // osimemo
            pstmt.setString(5, log_id); // log_id
            pstmt.setInt(6, cate_id); // cate_id


            // 4.SQLの実行＆コミット
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // エラーの詳細を表示
        }
    }
}
