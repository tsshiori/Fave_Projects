package utils.DAO;

import utils.Bean.categoryBean;
import utils.Bean.tagBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class tagDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    public static void insertTag(int cate_id, String tag) {
        // オートインクリメントされるカラム（id）を除外して挿入
        String sql = "INSERT INTO tag (tag, cate_id) VALUES (?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Connection con = DriverManager.getConnection(DB_URL);
            Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setString(1, tag);
            pstmt.setInt(2, cate_id);

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);  // 挿入された行数を表示

            if (rowsAffected == 0) {
                System.out.println("データが挿入されませんでした。");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();  // エラー詳細を表示
        }
    }

    public static void editTag(int tag_id, String tag) {
        String sql = "UPDATE tag SET tag = ? WHERE tag_id = ?";

        // デバッグログ: SQLと入力パラメータを表示
        System.out.println("DEBUG: Executing SQL: " + sql + " with tag_id = " + tag_id + ", new tag = '" + tag.trim() + "'");

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            pstmt.setString(1, tag.trim());
            pstmt.setInt(2, tag_id);

            // SQL実行の前にパラメータをログ出力
            System.out.println("DEBUG: PreparedStatement parameters set successfully.");

            int rowsAffected = pstmt.executeUpdate();

            // SQLの実行結果を確認
            if (rowsAffected > 0) {
                System.out.println("DEBUG: Tag updated successfully. Rows affected: " + rowsAffected);
            } else {
                System.out.println("DEBUG: No rows were updated. The tag might not exist or the new value is the same as the old one.");
            }
        } catch (SQLException e) {
            // エラーメッセージにSQLの内容も含めて表示
            System.err.println("ERROR: Failed to execute update. SQL: " + sql);
            e.printStackTrace();  // スタックトレースを表示してエラーの詳細を確認
        }
    }



    public static void deleteTag(int tag_id) {
        // SQL文
        String sql1 = "DELETE FROM tag WHERE tag_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt1 = con.prepareStatement(sql1);

        ) {

            // 2. category テーブルのレコードを削除
            pstmt1.setInt(1, tag_id);
            pstmt1.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

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

    public static int selectTagByCategory(int cate_id, String tag) {
        String sql = "SELECT tag_id FROM tag WHERE cate_id = ? AND tag = ?";
        int tag_id = -1;

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setInt(1, cate_id);
            pstmt.setString(2, tag.trim()); // 空白を削除

            System.out.println("DEBUG: Executing SQL: " + sql + " with cate_id = " + cate_id + ", tag = " + tag.trim());

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    tag_id = rs.getInt("tag_id");
                    System.out.println("DEBUG: Found tag_id = " + tag_id);
                } else {
                    System.out.println("DEBUG: No matching tag_id found.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tag_id;
    }

    // カテゴリIDに基づいてタグリストを取得するメソッド
    public static List<String> selectTagsByCategory(int cate_id) {
            String sql = "SELECT tag FROM tag WHERE cate_id = ?";
            List<String> tags = new ArrayList<>();

            try (
                    Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                    PreparedStatement pstmt = con.prepareStatement(sql);
            ) {
                pstmt.setInt(1, cate_id);

                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        tags.add(rs.getString("tag"));
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return tags; // タグのリストを返す
        }

}
