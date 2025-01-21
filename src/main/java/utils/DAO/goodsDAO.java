package utils.DAO;

import utils.Bean.faveBean;
import utils.Bean.osikatuBean;

import java.sql.*;
import java.util.ArrayList;

import utils.Bean.goodsBean;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

public class goodsDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";

    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    public static ArrayList<osikatuBean> selectOsikatuByOsi_id(int osi_id){
        String sql = "SELECT * FROM osikatu WHERE osi_id = ?";
        ArrayList<osikatuBean> goodslist = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setInt(1, osi_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) { // 修正：複数の結果を扱えるように変更
                    goodslist.add(new osikatuBean(
                            rs.getInt("osikatu_id"),
                            rs.getDate("day") != null ? rs.getDate("day").toLocalDate() : null, // Date -> LocalDate に変換
                            rs.getInt("price"),
                            rs.getString("item"),
                            rs.getInt("purchase"),
                            rs.getInt("osi_id"),
                            rs.getInt("priority"),
                            rs.getString("memo"),
                            rs.getInt("itemtype")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return goodslist; // 見つからない場合は空のリストを返す
    }

//追加
    public static void insertGoods(LocalDate day, int price, String item, int purchase, int osi_id, int priority, String memo, int itemtype) {
        String sql = "INSERT INTO osikatu (osikatu_id, day, price, item, purchase, osi_id, priority, memo, itemtype) "
                + " VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setDate(1, day != null ? java.sql.Date.valueOf(day) : null);
            pstmt.setInt(2, price);
            pstmt.setString(3, item);
            pstmt.setInt(4, purchase);
            pstmt.setInt(5, osi_id);
            pstmt.setInt(6, priority);
            pstmt.setString(7, memo);
            pstmt.setInt(8, itemtype);  // 修正: itemtype に変更

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
    public static ArrayList<goodsBean> selectGoods(int osikatu_id) {
        String sql = "SELECT * FROM osikatu";  // osikatuテーブルから全件を取得
        ArrayList<goodsBean> goodsList = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                // 各カラムの値を取得
                int osikatuId = rs.getInt("osikatu_id");
                java.sql.Date day = rs.getDate("day");  // sql.Date型に変更
                int price = rs.getInt("price");
                String item = rs.getString("item");
                int purchase = rs.getInt("purchase");
                int osiId = rs.getInt("osi_id");
                int priority = rs.getInt("priority");
                String memo = rs.getString("memo");
                int itemtype = rs.getInt("itemtype");

                // goodsBeanオブジェクトを作成し、リストに追加
                goodsBean goods = new goodsBean(osikatuId, day, price, item, purchase, osiId, priority, memo, itemtype);
                goodsList.add(goods);
            }

        } catch (SQLException e) {
            System.out.println("データベースエラー: " + e.getMessage());
            e.printStackTrace();
        }
        return goodsList;  // 取得した全件データをリストとして返す
    }


}
