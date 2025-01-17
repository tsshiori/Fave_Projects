package utils.DAO;

import java.sql.*;
import java.time.LocalDate;
import java.util.Date;

public class goodsDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    //追加
    public static void insertGoods(LocalDate day, int price, String item, int purchase, int osi_id, int priority, String memo, int itmetype) {
        String sql = "INSERT INTO osikatu (osikatu_id, day, price, item, purchase, osi_id, priority, memo, itmetype) "
                + " VALUES (NULL, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setDate(1,  day != null ? java.sql.Date.valueOf(day) : null);
            pstmt.setInt(2, price);
            pstmt.setString(3, item);
            pstmt.setInt(4, purchase);
            pstmt.setInt(5, osi_id);
            pstmt.setInt(6, priority);
            pstmt.setString(7, memo);
            pstmt.setInt(8, itmetype);

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
//        String query = "INSERT INTO goods (name, description, price) VALUES (?, ?, ?)";
//        try (PreparedStatement stmt = connection.prepareStatement(query)) {
//            stmt.setString(1, goods.getName());
//            stmt.setString(2, goods.getDescription());
//            stmt.setDouble(3, goods.getPrice());
//            int rowsAffected = stmt.executeUpdate();
//            return rowsAffected > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    // 他のグッズ関連のメソッドも追加（例えば、一覧の取得など）
//}
//}

}
