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
}
