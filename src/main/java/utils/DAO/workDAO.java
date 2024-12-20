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


    public static ArrayList<workBean> selectWorkAll(String log_id) {
        String sql = "SELECT * FROM work WHERE log_id = ?";
        ArrayList<workBean> results = new ArrayList<>();

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
                    results.add(
                            new workBean(
                                    rs.getInt("work_id"),         // work_id カラム
                                    rs.getInt("hourlywage"),      // hourlywage カラム
                                    rs.getString("work"),         // work カラム
                                    rs.getString("log_id")        // log_id カラム
                            )
                    );
                }
            }
        } catch (SQLException e) {
            // エラー出力
            System.err.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
        }

        return results;
    }

    public static void insertWork(int work_id,int hourlywage,String work,String log_id) {
        String sql = "INSERT INTO work VALUES (NULL, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, hourlywage);
            pstmt.setString(2, work);
            pstmt.setString(3, log_id);


            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);  // 挿入された行数を表示

            if (rowsAffected == 0) {
                System.out.println("データが挿入されませんでした。");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();  // エラー詳細を表示
        }
    }

    public static workBean selectWork(int work_id) {
        String sql = "SELECT * FROM work WHERE work_id = ?";
        workBean result = null; // 結果を格納するオブジェクト

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            pstmt.setInt(1, work_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) { // データが存在する場合
                    result = new workBean(
                            rs.getInt("work_id"),        // work_id カラム
                            rs.getInt("hourlywage"),     // hourlywage カラム
                            rs.getString("work"),        // work カラム
                            rs.getString("log_id")       // log_id カラム
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result; // データが見つからない場合はnullを返す
    }

    public static int selectNameWork(String log_id, String work) {
        if (work == null || log_id == null) {
            System.out.println("work または log_id が null です");
            return -2; // エラーを示す特別な値
        }

        String sql = "SELECT work_id FROM work WHERE work = ? AND log_id = ?";
        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            pstmt.setString(1, work);
            pstmt.setString(2, log_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("work_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -3; // データが見つからなかった場合
    }

    public static void editWork(int work_id, int hourlywage, String work, boolean mainwork, String log_id) {
        // SQL文: 指定された work_id のレコードを更新
        String sql = "UPDATE work SET hourlywage = ?, work = ? WHERE work_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダーに値を設定
            pstmt.setInt(1, hourlywage);
            pstmt.setString(2, work);
            pstmt.setInt(3, work_id);

            // SQLの実行
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows updated: " + rowsAffected);

            // メイン設定を更新する場合
            if (mainwork) {
                userDAO.updateMainWork(work_id, log_id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void editWorkHourlyWage(int work_id, int hourlywage) {
        // SQL文: 指定された work_id のレコードを更新
        String sql = "UPDATE work SET hourlywage = ? WHERE work_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダーに値を設定
            pstmt.setInt(1, hourlywage);
            pstmt.setInt(2, work_id);

            // SQLの実行
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows updated: " + rowsAffected);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static void deleteWork(int work_id){
        // SQL文
        String sql = "DELETE FROM work WHERE work_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // 3.プレースホルダに値をセット
            pstmt.setInt(1, work_id);

            // 4.SQLの実行＆コミット
            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }

    }

}
