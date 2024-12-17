package utils.DAO;

import utils.Bean.categoryBean;
import utils.Bean.tagBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;

public class tagDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    public static String selectTag(int osi_id) {
        String sql = "SELECT tag.tag FROM tag INNER JOIN ositag ON tag.tag_id = ositag.tag_id WHERE ositag.osi_id = ?";
        String tag = null;

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setInt(1, osi_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) { // 1件の結果を取得
                    tag = rs.getString("tag");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tag; // タグを返す（見つからない場合はnull）
    }

}
