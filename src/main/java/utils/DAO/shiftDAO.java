package utils.DAO;

import utils.Bean.shiftBean;
import utils.Bean.workBean;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class shiftDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";
    public static ArrayList<shiftBean> selectShiftAll(String log_id) throws SQLException {
        // worklists を取得
        ArrayList<workBean> worklists = workDAO.selectWorkAll(log_id);

        // work_id をリスト化
        ArrayList<Integer> workIds = new ArrayList<>();
        for (workBean work : worklists) {
            workIds.add(work.getWork_id());
        }

        // work_id リストが空の場合、空の結果を返す
        if (workIds.isEmpty()) {
            return new ArrayList<>();
        }

        // SQL クエリを動的に作成 (IN 句)
        StringBuilder sql = new StringBuilder("SELECT * FROM shift WHERE work_id IN (");
        for (int i = 0; i < workIds.size(); i++) {
            sql.append("?");
            if (i < workIds.size() - 1) {
                sql.append(", ");
            }
        }
        sql.append(")");

        ArrayList<shiftBean> results = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql.toString())
        ) {
            // プレースホルダーに値を設定
            for (int i = 0; i < workIds.size(); i++) {
                pstmt.setInt(i + 1, workIds.get(i));
            }

            // デバッグ: SQL とパラメータの確認
            System.out.println("Executing SQL: " + sql);
            System.out.println("With work_ids: " + workIds);

            // クエリ実行
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // shiftBeanのインスタンスを作成
                    shiftBean shift = new shiftBean(
                            rs.getInt("shift_id"),
                            rs.getTimestamp("startdatetime").toLocalDateTime(),
                            rs.getTimestamp("enddatetime").toLocalDateTime(),
                            rs.getInt("work_id"),
                            rs.getInt("breaktime"),
                            rs.getInt("wage")
                    );

                    // work_idに基づいて勤務先（work_name）を取得
                    for (workBean work : worklists) {
                        if (work.getWork_id() == shift.getWork_id()) {
                            shift.setWork_name(work.getWork()); // 勤務先名を設定
                            break;
                        }
                    }

                    results.add(shift);
                }
            }
        } catch (SQLException e) {
            // エラー出力
            System.err.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
        }

        return results;
    }

    public static void insertShift(int shift_id, LocalDateTime startdatetime, LocalDateTime enddatetime, int work_id, int breaktime, int wage) {
        String sql = "INSERT INTO shift VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, shift_id);
            pstmt.setTimestamp(2, Timestamp.valueOf(startdatetime)); // LocalDateTime → Timestamp
            pstmt.setTimestamp(3, Timestamp.valueOf(enddatetime));
            pstmt.setInt(4, work_id);
            pstmt.setInt(5, breaktime);
            pstmt.setInt(6, wage);

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteShift(int shift_id){
        // SQL文
        String sql = "DELETE FROM shift WHERE shift_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // 3.プレースホルダに値をセット
            pstmt.setInt(1, shift_id);

            // 4.SQLの実行＆コミット
            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }

    }
}
