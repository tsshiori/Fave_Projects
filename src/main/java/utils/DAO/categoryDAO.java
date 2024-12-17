package utils.DAO;

import utils.Bean.categoryBean;
import utils.Bean.workBean;

import java.sql.*;
import java.util.ArrayList;

public class categoryDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";

    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";


    public static ArrayList<categoryBean> selectCategoryAll(String log_id){
        String sql = "SELECT * FROM category WHERE log_id = ?";
        ArrayList<categoryBean> result = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダーに値を設定
            pstmt.setString(1, log_id);

            // デバッグ: SQL とプレースホルダーの確認
            System.out.println("Executing SQL: " + sql);
            System.out.println("With log_id: " + log_id);

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


    public static ArrayList<categoryBean> selectCategory (String log_id) {
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
