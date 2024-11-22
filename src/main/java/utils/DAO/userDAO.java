package utils.DAO;

import utils.Bean.userBean;

import java.sql.*;

public class userDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";
    // データの追加(INSERT)
    public static void insertAccount(String log_id, String password, String nick, int regimg, int amounthand, int living, int saiosi, int mainwork) {
        // SQL文
        String sql = "INSERT INTO account VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DriverManager.getConnection(DB_URL); // 1.DB接続
                PreparedStatement pstmt = con.prepareStatement(sql); // 2.pstmtの作成
        ) {
            // 3.プレースホルダに値をセット
            pstmt.setString(1, log_id);

            String salt = GenerateHash.getSalt();
            String hashPW = GenerateHash.getHashPw(password,salt);
            pstmt.setString(2,hashPW);

            pstmt.setString(3, nick);
            pstmt.setInt(4,regimg);
            pstmt.setInt(5,amounthand);
            pstmt.setInt(6,living);
            pstmt.setInt(7,saiosi);
            pstmt.setInt(8,mainwork);

            // 4.SQLの実行＆コミット
            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // SELECT 条件あり
    public static userBean selectById(int id) {
        String sql = "SELECT * FROM account WHERE id = ?";
        userBean result = null;

        try (
                Connection con = DriverManager.getConnection(DB_URL);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setInt(1, id);

            // 実行＆結果をResultSetに格納
            try (ResultSet rs = pstmt.executeQuery()) {
                // 検索結果をStudentsBeanに代入
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
            System.out.println(e);
        }

        return result; // 検索結果の追加がなければnullが返却される
    }
}
