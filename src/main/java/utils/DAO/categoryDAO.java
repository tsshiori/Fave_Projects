package utils.DAO;

import utils.Bean.categoryBean;
import utils.Bean.faveBean;
import utils.Bean.workBean;

import java.sql.*;
import java.util.ArrayList;

public class categoryDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";

    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    public static void insertCategory(String log_id, String category) {
        // オートインクリメントされるカラム（id）を除外して挿入
        String sql = "INSERT INTO category (category, log_id) VALUES (?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Connection con = DriverManager.getConnection(DB_URL);
            Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setString(1, category);
            pstmt.setString(2, log_id);

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);  // 挿入された行数を表示

            if (rowsAffected == 0) {
                System.out.println("データが挿入されませんでした。");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();  // エラー詳細を表示
        }
    }

    public static void editCategory(int cate_id, String category) {
        // SQL文: 指定された work_id のレコードを更新
        String sql = "UPDATE category SET category = ? WHERE cate_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダーに値を設定
            pstmt.setString(1, category);
            pstmt.setInt(2, cate_id);


            // SQLの実行
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows updated: " + rowsAffected);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static void deleteCategory(int cate_id) {
        // SQL文
        String sql1 = "DELETE FROM category WHERE cate_id = ?";
        String sql2 = "DELETE FROM tag WHERE cate_id = ?";  // 修正: 不要な "tag" を削除

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt1 = con.prepareStatement(sql1);
                PreparedStatement pstmt2 = con.prepareStatement(sql2)
        ) {
            // 1. tag テーブルの関連レコードを削除
            pstmt2.setInt(1, cate_id);
            pstmt2.executeUpdate();

            // 2. category テーブルのレコードを削除
            pstmt1.setInt(1, cate_id);
            pstmt1.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }



    public static ArrayList<categoryBean> selectCategoryAll(String log_id){
        String sql = "SELECT * FROM category WHERE log_id = ?";
        ArrayList<categoryBean> result = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダーに値を設定
            pstmt.setString(1, log_id);

            // クエリ実行
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    result.add(
                            new categoryBean(
                                    rs.getInt("cate_id"),         // cate_id_id カラム
                                    rs.getString("category"),      // category カラム
                                    rs.getString("log_id")         // log_id カラム
                            )
                    );
                }
            }
        } catch (SQLException e) {
            // エラー出力
            System.err.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    public  static categoryBean selectCategory(int cate_id){
        String sql = "SELECT * FROM category WHERE cate_id = ?";
        categoryBean result = null;

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            // プレースホルダーに値を設定
            pstmt.setInt(1, cate_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                // データが見つかった場合に faveBean を生成
                if (rs.next()) {
                    result = new categoryBean(
                            rs.getInt("cate_id"),
                            rs.getString("category"),
                            rs.getString("log_id")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // データが見つからなければ null を返す
        return result;
    }

    public static ArrayList<categoryBean> selectCategory2 (String log_id) {
        String sql = "SELECT * FROM category WHERE log_id = ?";
        ArrayList<categoryBean> result = new ArrayList<>();
        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setString(1, log_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) { // 修正：複数の結果を扱えるように変更
                    result.add(new categoryBean(
                            rs.getInt("cate_id"),
                            rs.getString("category"),
                            rs.getString("log_id")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
