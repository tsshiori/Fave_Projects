package utils.DAO;

import java.lang.Class;

import utils.Bean.userBean;
import utils.Bean.workBean;

import java.sql.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

public class workDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    // SELECT 条件なし（全件）
    public static ArrayList<workBean> selectWorkAll(String log_id) {
        String sql = "SELECT * FROM work WHERE log_id = ?";
        ArrayList<workBean> results = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダーに値を設定
            pstmt.setString(1, log_id);

            // クエリ実行
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    results.add(
                            new workBean(
                                    rs.getInt("work_id"),         // カラム名を確認
                                    rs.getInt("hourlywage"),
                                    rs.getString("work"),
                                    rs.getString("log_id")
                            )
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("エラー: " + e.getMessage());
            e.printStackTrace();
        }

        return results;
    }

    public static void insertWork(int work_id,int hourlywage,String work,String log_id) {
        String sql = "INSERT INTO work VALUES (?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, work_id);
            pstmt.setInt(2, hourlywage);
            pstmt.setString(3, work);
            pstmt.setString(4, log_id);


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
