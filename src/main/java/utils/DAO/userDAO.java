package utils.DAO;

import java.lang.Class;

import org.mindrot.jbcrypt.BCrypt;
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
            pstmt.setString(2, hashPW);
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

    // アカウント削除
    public static boolean deleteUser(String log_id, String password) throws SQLException {
        // ログイン情報からパスワードを取得
        String selectSql = "SELECT password FROM account WHERE log_id = ?";

        try (Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = con.prepareStatement(selectSql)) {

            pstmt.setString(1, log_id);
            ResultSet rs = pstmt.executeQuery();

            // ユーザーが見つからない場合
            if (!rs.next()) {
                System.out.println("指定されたlog_idに対応するユーザーは存在しません。");
                return false;
            }

            String storedPassword = rs.getString("password");

            // パスワードが一致するかチェック（BCryptを使用した例）
            if (BCrypt.checkpw(password, storedPassword)) {
                // パスワードが一致した場合、削除処理
                String deleteSql = "DELETE FROM account WHERE log_id = ?";
                try (PreparedStatement deleteStmt = con.prepareStatement(deleteSql)) {
                    deleteStmt.setString(1, log_id);
                    int rowsAffected = deleteStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        System.out.println("ユーザーが削除されました。");
                        return true;
                    } else {
                        System.out.println("削除に失敗しました。");
                        return false;
                    }
                }
            } else {
                System.out.println("パスワードが一致しません。");
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;  // エラーが発生した場合は例外を投げる
        }
    }


    public static void updateSaiosi(int saiosi, String log_id) {
        String sql = "UPDATE account SET saiosi = ? WHERE log_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダに値をセット
            pstmt.setInt(1, saiosi);  // saiosi
            pstmt.setString(2, log_id);  // log_id

            // SQLを実行
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("指定されたlog_idに対応するデータが存在しません。");
            } else {
                System.out.println("saiosiが正常に更新されました。");
            }
        } catch (SQLException e) {
            e.printStackTrace();  // エラーの詳細を表示
        }
    }

    public static void updateMainWork(int work_id, String log_id) {
        String sql = "UPDATE account SET mainwork = ? WHERE log_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダに値をセット
            pstmt.setInt(1, work_id);  //
            pstmt.setString(2, log_id);  // log_id

            // SQLを実行
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("指定されたlog_idに対応するデータが存在しません。");
            } else {
                System.out.println("mainworkが正常に更新されました。");
            }
        } catch (SQLException e) {
            e.printStackTrace();  // エラーの詳細を表示
        }
    }


}
