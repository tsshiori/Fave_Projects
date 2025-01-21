package utils.DAO;

import utils.Bean.categoryBean;
import utils.Bean.tagBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

    public static ArrayList<tagBean> selectTags(int osi_id) {
        String sql = "SELECT * FROM tag INNER JOIN ositag ON tag.tag_id = ositag.tag_id WHERE ositag.osi_id = ?";
        ArrayList<tagBean> tags = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setInt(1, osi_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) { // 複数の結果を取得可能に変更
                    tags.add(
                            new tagBean(
                                    rs.getInt("tag_id"),
                                    rs.getInt( "cate_id"),
                                    rs.getString("tag")
                            )
                    ); // ArrayList に追加
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tags; // 見つからない場合は空の ArrayList を返す
    }


    // カテゴリIDに基づいてタグリストを取得するメソッド
        public static Map<Integer, String> selectTagsByCategory(int cate_id) {
            String sql = "SELECT tag_id,tag FROM tag WHERE cate_id = ?";
            Map<Integer, String> tags = new HashMap<>();

            try (
                    Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                    PreparedStatement pstmt = con.prepareStatement(sql);
            ) {
                pstmt.setInt(1, cate_id);

                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        int tag_id = rs.getInt("tag_id");
                        String tag = rs.getString("tag");
                        tags.put(tag_id, tag);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return tags; // タグのリストを返す
        }

    public static void insertOsiTag(int osi_id, int tag_id) {
        String sql = "INSERT INTO ositag (ositag_id, osi_id, tag_id) VALUES (NULL, ?, ?)";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            // 受け取った引数をパラメータとして設定
            pstmt.setInt(1, osi_id);  // 必須引数
            pstmt.setInt(2, tag_id);  // 必須引数

            // クエリを実行
            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("データベースエラー: " + e.getMessage());
            e.printStackTrace();        }
    }

    public static void delTag(int osi_id) {
        String sql = "DELETE FROM ositag WHERE osi_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // 3.プレースホルダに値をセット
            pstmt.setInt(1, osi_id);

            // 4.SQLの実行＆コミット
            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
