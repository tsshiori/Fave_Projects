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

    // パスワードチェック
    public static boolean checkPassword(int userId, String password) throws SQLException {
        boolean isValid = false;
        String sql = "SELECT password FROM account WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String dbPassword = rs.getString("password");
                if (dbPassword.equals(password)) { // 簡略化、ハッシュ化推奨
                    isValid = true;
                }
            }
        }
        return isValid;
    }

    // アカウント削除
    public static boolean deleteUser(int userId) throws SQLException {
        boolean isDeleted = false;
        String sql = "DELETE FROM account WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        }
        return isDeleted;
    }
}
