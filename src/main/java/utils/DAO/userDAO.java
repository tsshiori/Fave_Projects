package utils.DAO;

import java.lang.Class;

import utils.Bean.userBean;

import java.sql.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class userDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    //private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";
    // データの追加(INSERT)
    public static void insertAccount(String log_id, String password, String nick, int regimg, int amounthand, int living, int saiosi, Integer mainwork) {
        String sql = "INSERT INTO account VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Connection con = DriverManager.getConnection(DB_URL);
            Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setString(1, log_id);
            String salt = GenerateHash.getSalt();
            String hashPW = GenerateHash.getHashPw(password, salt);
            pstmt.setString(2, "aa");
            pstmt.setString(3, nick);
            pstmt.setInt(4, regimg);
            pstmt.setInt(5, amounthand);
            pstmt.setInt(6, living);
            pstmt.setInt(7, saiosi);
            pstmt.setInt(8, 0);

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);  // 挿入された行数を表示

            if (rowsAffected == 0) {
                System.out.println("データが挿入されませんでした。");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();  // エラー詳細を表示
        }
    }


    // SELECT 条件あり
    public static userBean selectById(String id) {
        String sql = "SELECT * FROM account WHERE log_id = ?";
        userBean result = null;

        try (

                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setString(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    result = new userBean(
                            rs.getString("log_id"),
                            rs.getString("password"),
                            rs.getString("nick"),
                            rs.getInt("regimg"),
                            rs.getInt("amounthand"),
                            rs.getInt("living"),
                            rs.getInt("saiosi"),
                            rs.getInt("mainwork")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result; // ユーザーが見つからなければnull
    }

    public static boolean deleteUser(String log_id, String password) throws SQLException {
        String sqlSelect = "SELECT password FROM account WHERE log_id = ?";
        String sqlDelete = "DELETE FROM account WHERE log_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL);
                PreparedStatement pstmtSelect = con.prepareStatement(sqlSelect);
                PreparedStatement pstmtDelete = con.prepareStatement(sqlDelete)
        ) {
            // ユーザーのパスワードを取得
            pstmtSelect.setString(1, log_id);
            try (ResultSet rs = pstmtSelect.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");

                    // パスワードが一致するかを確認
                    if (GenerateHash.checkPassword(password, storedPassword)) {
                        // 一致した場合は削除
                        pstmtDelete.setString(1, log_id);
                        int rowsAffected = pstmtDelete.executeUpdate();
                        return rowsAffected > 0; // 削除成功ならtrueを返す
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("削除中のエラー: " + e.getMessage());
            throw e; // エラーを呼び出し元に伝える
        }

        return false; // パスワードが一致しない、または削除できなかった場合
    }

}
