package utils.DAO;

import utils.Bean.faveBean;
import utils.Bean.osikatuBean;

import java.sql.*;
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
}

