package utils.DAO;

import java.sql.*;
import java.time.LocalDate;

public class faveDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db";
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
            if (birthday != null) {
                pstmt.setDate(3, java.sql.Date.valueOf(birthday)); // birthdayに値がある場合、変換してセット
            } else {
                pstmt.setNull(3, java.sql.Types.DATE); // birthdayがnullの場合、NULLをセット
            }

            pstmt.setString(4, osimemo); // osimemo
            pstmt.setString(5, log_id); // log_id
            pstmt.setInt(6, cate_id); // cate_id


            // 4.SQLの実行＆コミット
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // エラーの詳細を表示
        }
    }

    public static int selectNameFave(String log_id, String name) {
        if (name == null || log_id == null) {
            System.out.println("name または log_id が null です");
            return -2; // エラーを示す特別な値
        }

        String sql = "SELECT osi_id FROM osi WHERE name = ? AND log_id = ?";
        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            pstmt.setString(1, name);
            pstmt.setString(2, log_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("osi_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -3; // データが見つからなかった場合
    }
}
