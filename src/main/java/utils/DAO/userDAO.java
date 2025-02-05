package utils.DAO;

import java.lang.Class;

import org.mindrot.jbcrypt.BCrypt;
import utils.Bean.categoryBean;
import utils.Bean.shiftBean;
import utils.Bean.userBean;
import utils.Bean.workBean;

import java.sql.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static utils.DAO.workDAO.selectWorkAll;

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

    // アカウント削除処理
    public static boolean deleteUser(String log_id, String password) throws SQLException {
        // 1. ログイン情報からパスワードを取得
        String selectSql = "SELECT password FROM account WHERE log_id = ?";

        try (Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = con.prepareStatement(selectSql)) {

            pstmt.setString(1, log_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                // ユーザーが見つからない場合
                if (!rs.next()) {
                    System.out.println("指定されたlog_idに対応するユーザーは存在しません。");
                    return false;
                }

                String storedPassword = rs.getString("password");

                // パスワードが一致するかチェック（BCryptを使用した例）
                if (BCrypt.checkpw(password, storedPassword)) {
                    // 2. まず、関連するosikatuテーブルのデータを削除
                    String deleteOsikatuSql = "DELETE FROM osikatu WHERE osi_id IN (SELECT osi_id FROM osi WHERE log_id = ?)";
                    try (PreparedStatement deleteOsikatuStmt = con.prepareStatement(deleteOsikatuSql)) {
                        deleteOsikatuStmt.setString(1, log_id);
                        deleteOsikatuStmt.executeUpdate();
                    }

                    // 3. osiテーブルのデータを削除
                    String deleteOsiSql = "DELETE FROM osi WHERE log_id = ?";
                    try (PreparedStatement deleteOsiStmt = con.prepareStatement(deleteOsiSql)) {
                        deleteOsiStmt.setString(1, log_id);
                        deleteOsiStmt.executeUpdate();
                    }

                    // 5. shiftテーブルのデータを削除
                    String deleteShiftSql = "DELETE FROM shift WHERE work_id IN (SELECT work_id FROM work WHERE log_id = ?)";
                    try (PreparedStatement deleteShiftStmt = con.prepareStatement(deleteShiftSql)) {
                        deleteShiftStmt.setString(1, log_id);
                        deleteShiftStmt.executeUpdate();
                    }


                    // 4. workテーブルのデータを削除
                    String deleteWorkSql = "DELETE FROM work WHERE log_id = ?";
                    try (PreparedStatement deleteWorkStmt = con.prepareStatement(deleteWorkSql)) {
                        deleteWorkStmt.setString(1, log_id);
                        deleteWorkStmt.executeUpdate();
                    }

                    String sql = "SELECT * FROM category WHERE log_id = ?";
                    ArrayList<categoryBean> result = new ArrayList<>();

                    try (PreparedStatement pstmtCate = con.prepareStatement(sql)) {
                        // プレースホルダーに値を設定
                        pstmtCate.setString(1, log_id);

                        // クエリ実行
                        try (ResultSet rsCate = pstmtCate.executeQuery()) {
                            while (rsCate.next()) {
                                result.add(
                                        new categoryBean(
                                                rsCate.getInt("cate_id"),     // cate_id カラム
                                                rsCate.getString("category"), // category カラム
                                                rsCate.getString("log_id")    // log_id カラム
                                        )
                                );
                            }
                        }
                    }

                    // `category` のデータがある場合、それを削除
                    if (!result.isEmpty()) {
                        String sql1 = "DELETE FROM category WHERE cate_id = ?";
                        String sql2 = "DELETE FROM tag WHERE cate_id = ?";
                        String sql3 = "DELETE FROM ositag WHERE tag_id = ?";

                        try (
                                PreparedStatement pstmt1 = con.prepareStatement(sql1);
                                PreparedStatement pstmt2 = con.prepareStatement(sql2);
                                PreparedStatement pstmt3 = con.prepareStatement(sql3)
                        ) {
                            for (categoryBean cate : result) {
                                int cate_id = cate.getCate_id(); // `categoryBean` から `cate_id` を取得

                                // `tag` テーブルから `tag_id` を取得
                                String sqlTag = "SELECT tag_id FROM tag WHERE cate_id = ?";
                                List<Integer> tags = new ArrayList<>();

                                try (PreparedStatement pstmtCate = con.prepareStatement(sqlTag)) {
                                    pstmtCate.setInt(1, cate_id);
                                    try (ResultSet rsTag = pstmtCate.executeQuery()) {
                                        while (rsTag.next()) {
                                            tags.add(rsTag.getInt("tag_id")); // 修正：rsTag を使用
                                        }
                                    }
                                }

                                // `ositag` テーブルのデータを削除
                                for (Integer tag : tags) {
                                    pstmt3.setInt(1, tag);
                                    pstmt3.executeUpdate();
                                }

                                // `tag` テーブルの関連データを削除
                                pstmt2.setInt(1, cate_id);
                                pstmt2.executeUpdate();

                                // `category` テーブルのデータを削除
                                pstmt1.setInt(1, cate_id);
                                pstmt1.executeUpdate();
                            }
                        }
                    }



                    // 6. 最後にaccountテーブルのデータを削除
                    String deleteAccountSql = "DELETE FROM account WHERE log_id = ?";
                    try (PreparedStatement deleteAccountStmt = con.prepareStatement(deleteAccountSql)) {
                        deleteAccountStmt.setString(1, log_id);
                        int rowsAffected = deleteAccountStmt.executeUpdate();

                        if (rowsAffected > 0) {
                            System.out.println("ユーザーが削除されました。");
                            return true;
                        } else {
                            System.out.println("削除に失敗しました。");
                            return false;
                        }
                    }
                } else {
                    // パスワードが一致しない場合
                    System.out.println("パスワードが一致しません。");
                    return false;
                }
            }
        }
    }

    public static void updateAll(String log_id,String nick,int saiosi,int regimg,int amounthand,int living) {
        String sql = "UPDATE account SET nick = ?,saiosi =?, regimg = ?,amounthand = ?, living = ? WHERE log_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダに値をセット
            pstmt.setString(1, nick);
            pstmt.setInt(2, saiosi);
            pstmt.setInt(3,regimg);
            pstmt.setInt(4, amounthand);
            pstmt.setInt(5, living);
            pstmt.setString(6, log_id);

            // SQLを実行
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("指定されたlog_idに対応するデータが存在しません。");
            } else {
                System.out.println("正常に更新されました。");
            }
        } catch (SQLException e) {
            e.printStackTrace();  // エラーの詳細を表示
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
