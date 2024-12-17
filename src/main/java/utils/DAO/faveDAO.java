package utils.DAO;

import utils.Bean.categoryBean;
import utils.Bean.faveBean;
import utils.Bean.tagBean;
import utils.Bean.userBean;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class faveDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";

    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    // データの追加(INSERT)
    public static void insertFave(String img, String name, LocalDate birthday, String osimemo, String log_id, int cate_id) {
        // 必須の外部キー log_id, cate_id を含む SQL
        String sql = "INSERT INTO osi (osi_id, img, name, birthday, osimemo, log_id, cate_id) "
                + "VALUES (NULL, ?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            // 受け取った引数をパラメータとして設定
            pstmt.setString(1, img != null ? img : null);  // img（NULLの場合を許容）
            pstmt.setString(2, name);  // 必須なのでnullでは設定しない
            pstmt.setDate(3, birthday != null ? java.sql.Date.valueOf(birthday) : null); // birthday（NULLの場合を許容）
            pstmt.setString(4, osimemo);  // osimemo（NULLの場合を許容）

            // 外部キーとして必須の log_id と cate_id
            pstmt.setString(5, log_id);  // log_id（必須）
            pstmt.setInt(6, cate_id);    // cate_id（必須）

            // SQLを実行して、影響を受けた行数を取得
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("データが正常に登録されました。");
            } else {
                System.out.println("データの登録に失敗しました。");
            }
        } catch (SQLException e) {
            System.out.println("データベースエラー: " + e.getMessage());
            e.printStackTrace();
        }
    }


    public static void addFave(faveBean faveB){
        String sql = "INSERT INTO osi (osi_id, img, name, birthday, osimemo, log_id, cate_id) "
                + "VALUES (NULL, ?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            // faveBean からデータを取得
            String img = faveB.getImg(); // img を取得
            String name = faveB.getName(); // name を取得
            String birthday = String.valueOf(faveB.getBirthday()); // birthday を取得
            String osimemo = faveB.getOsimemo(); // osimemo を取得
            String logId = faveB.getLog_id(); // log_id を取得
            int cateId = faveB.getCate_id(); // cate_id を取得

            // パラメータ設定
            pstmt.setString(1, img); // img（NULL 許容）
            pstmt.setString(2, name); // name（必須）
            pstmt.setDate(3, birthday != null ? java.sql.Date.valueOf(birthday) : null); // birthday（NULL 許容）
            pstmt.setString(4, osimemo); // osimemo（NULL 許容）
            pstmt.setString(5, logId); // log_id（必須）
            pstmt.setInt(6, cateId); // cate_id（必須）

            // SQLを実行して、影響を受けた行数を取得
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("データが正常に登録されました。");
            } else {
                System.out.println("データの登録に失敗しました。");
            }
        } catch (SQLException e) {
            System.out.println("データベースエラー: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static ArrayList<faveBean> selectFaveAll(String id) {
        String sql = "SELECT * FROM osi WHERE log_id = ?";
        ArrayList<faveBean> result = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setString(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) { // 修正：複数の結果を扱えるように変更
                    result.add(new faveBean(
                            rs.getInt("osi_id"),
                            rs.getString("img"),
                            rs.getString("name"),
                            rs.getDate("birthday") != null ? rs.getDate("birthday").toLocalDate() : null, // Date -> LocalDate に変換
                            rs.getString("osimemo"),
                            rs.getString("log_id"),
                            rs.getInt("cate_id")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result; // 見つからない場合は空のリストを返す
    }

    public static Map<Integer, Integer> selectPrice(String log_id) {
        String sql = "SELECT osikatu.osi_id, SUM(osikatu.price) AS total_price FROM osi INNER JOIN osikatu ON osi.osi_id = osikatu.osi_id WHERE osi.log_id = ? GROUP BY osikatu.osi_id";
        Map<Integer, Integer> result = new HashMap<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setString(1, log_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int osiId = rs.getInt("osi_id");
                    int totalPrice = rs.getInt("total_price");
                    result.put(osiId, totalPrice);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }


    public static int selectNameFave(String log_id, String name) {
        if (name == null || log_id == null) {
            System.out.println("name または log_id が null です");
            return -2; // エラーを示す特別な値
        }

        String sql = "SELECT osi_id FROM osi WHERE name = ? AND log_id = ?";
        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            pstmt.setString(1, name);
            pstmt.setString(2, log_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("osi_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -3; // データが見つからなかった場合
    }




    public static ArrayList<String> selectByLog_id(String log_id) {
        String sql = "SELECT name FROM osi WHERE log_id = ?";
        ArrayList<String> results = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setString(1, log_id); // log_id をセット
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // 'name' カラムの値を取得して、results に追加
                    results.add(rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e); // エラー発生時に例外をスロー
        }
        return results; // 結果のリストを返す
    }



}

