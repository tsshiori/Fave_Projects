package utils.DAO;

import java.sql.*;
import java.time.LocalDate;

public class faveDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";

    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    // データの追加(INSERT)
    public static void insertFave(String img, String name, LocalDate birthday, String osimemo, String log_id, int cate_id) {
        // 必須の外部キー log_id, cate_id を含む SQL
        String sql = "INSERT INTO osi (osi_id, img, name, birthday, osimemo, log_id, cate_id) "
                + "VALUES (NULL, ?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            // 受け取った引数をパラメータとして設定
            pstmt.setString(1, img != null ? img : null);  // img（NULLの場合を許容）
            pstmt.setString(2, name);  // 必須なのでnullでは設定しない
            pstmt.setDate(3, birthday != null ? java.sql.Date.valueOf(birthday) : null); // birthday（NULLの場合を許容）
            pstmt.setString(4, osimemo);  // osimemo（NULLの場合を許容）

            // 外部キーとして必須の log_id と cate_id
            pstmt.setString(5, log_id);  // log_id（必須）
            pstmt.setInt(6, cate_id);    // cate_id（必須）

            // SQLを実行して、影響を受けた行数を取得
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("データが正常に登録されました。");
            } else {
                System.out.println("データの登録に失敗しました。");
            }
        } catch (SQLException e) {
            System.out.println("データベースエラー: " + e.getMessage());
            e.printStackTrace();
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
