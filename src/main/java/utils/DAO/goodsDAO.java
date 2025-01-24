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
            pstmt.setInt(8, itemtype);  // itemtype に変更



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

  
    public static ArrayList<osikatuBean> selectGoods(int osi_id) {
        String sql = "SELECT * FROM osikatu WHERE osi_id = ?";  // osikatuテーブルから全件を取得
        ArrayList<osikatuBean> goodsList = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            // プレースホルダーに値を設定
            pstmt.setInt(1, osi_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                // データが見つかった場合に faveBean を生成
                while (rs.next()) { // 修正：複数の結果を扱えるように変更
                    goodsList.add(new osikatuBean(
                            rs.getInt("osikatu_id"),
                            rs.getDate("day") != null ? rs.getDate("day").toLocalDate() : null,
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

        // データが見つからなければ null を返す
        return goodsList;
    }

    public static ArrayList<Integer> selectOsikatu_id(String log_id){
        String sql = "SELECT osi_id FROM osi WHERE log_id = ?";
        ArrayList<Integer> osi_id = new ArrayList<>();



        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setString(1, log_id);

            try (ResultSet rs = pstmt.executeQuery()) {
                 while (rs.next()) {// 1件の結果を取得
                     osi_id.add(
                        rs.getInt("osi_id")
                     );
                 }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return osi_id;
    }

    public static void changeBuyBought(int osikatu_id) {
        String selectSql = "SELECT purchase FROM osikatu WHERE osikatu_id = ?";
        String updateSql = "UPDATE osikatu SET purchase = ? WHERE osikatu_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement selectStmt = con.prepareStatement(selectSql);
                PreparedStatement updateStmt = con.prepareStatement(updateSql);
        ) {
            // 現在の purchase の値を取得
            selectStmt.setInt(1, osikatu_id);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                int currentPurchase = rs.getInt("purchase");

                // 値を切り替え (1 -> 0, 0 -> 1)
                int newPurchase = (currentPurchase == 1) ? 0 : 1;

                // 更新処理
                updateStmt.setInt(1, newPurchase);
                updateStmt.setInt(2, osikatu_id);
                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    System.out.println("Successfully updated purchase to " + newPurchase + " for osikatu_id: " + osikatu_id);
                } else {
                    System.out.println("No rows were updated. Please check osikatu_id: " + osikatu_id);
                }
            } else {
                System.out.println("No record found for osikatu_id: " + osikatu_id);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void goodsDel(int osikatu_id) {
        String sql = "DELETE FROM osikatu WHERE osikatu_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // 3.プレースホルダに値をセット
            pstmt.setInt(1, osikatu_id);

            // 4.SQLの実行＆コミット
            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
