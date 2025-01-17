package utils.DAO;

import utils.Bean.shiftBean;
import utils.Bean.workBean;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;

import static utils.DAO.workDAO.selectWorkAll;

public class shiftDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";
    public static ArrayList<shiftBean> selectShiftAll(String log_id) throws SQLException {
        // worklists を取得
        ArrayList<workBean> worklists = selectWorkAll(log_id);

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

    public static ArrayList<shiftBean> selectShiftWorkId(int work_id) throws SQLException {
        String sql = "SELECT * FROM shift WHERE work_id = ?";
        ArrayList<shiftBean> results = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // パラメータ設定
            pstmt.setInt(1, work_id);

            // クエリ実行
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Timestampのnullチェック
                    Timestamp startTimestamp = rs.getTimestamp("startdatetime");
                    Timestamp endTimestamp = rs.getTimestamp("enddatetime");

                    LocalDateTime startDateTime = (startTimestamp != null) ? startTimestamp.toLocalDateTime() : null;
                    LocalDateTime endDateTime = (endTimestamp != null) ? endTimestamp.toLocalDateTime() : null;

                    // shiftBeanのインスタンスを作成
                    shiftBean shift = new shiftBean(
                            rs.getInt("shift_id"),
                            startDateTime,
                            endDateTime,
                            rs.getInt("work_id"),
                            rs.getInt("breaktime"),
                            rs.getInt("wage")
                    );
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

    public static shiftBean selectShiftShiftId(int shift_id) throws SQLException {
        String sql = "SELECT * FROM shift WHERE shift_id = ?";
        shiftBean result = null; // 修正: 変数名を変更

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // パラメータ設定
            pstmt.setInt(1, shift_id);

            // クエリ実行
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) { // 修正: 最初の結果のみ取得
                    // Timestampのnullチェック
                    Timestamp startTimestamp = rs.getTimestamp("startdatetime");
                    Timestamp endTimestamp = rs.getTimestamp("enddatetime");

                    LocalDateTime startDateTime = (startTimestamp != null) ? startTimestamp.toLocalDateTime() : null;
                    LocalDateTime endDateTime = (endTimestamp != null) ? endTimestamp.toLocalDateTime() : null;

                    // ShiftBeanのインスタンスを作成
                    result = new shiftBean(
                            rs.getInt("shift_id"),
                            startDateTime,
                            endDateTime,
                            rs.getInt("work_id"),
                            rs.getInt("breaktime"),
                            rs.getInt("wage")
                    );
                }
            }
        } catch (SQLException e) {
            // エラー出力
            System.err.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
            throw e; // 修正: エラーをスローして呼び出し元に通知
        }

        return result;
    }



    public static void insertShift(int shift_id, LocalDateTime startdatetime, LocalDateTime enddatetime, int work_id, int breaktime, int wage, int zikyuchange, String log_id) {
        String sql = "INSERT INTO shift VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, shift_id);
            pstmt.setTimestamp(2, Timestamp.valueOf(startdatetime)); // LocalDateTime → Timestamp
            pstmt.setTimestamp(3, Timestamp.valueOf(enddatetime));
            pstmt.setInt(4, work_id);
            pstmt.setInt(5, breaktime);
            pstmt.setInt(6, wage);

            if (zikyuchange == 2) {
                workDAO.editWorkHourlyWage(work_id, wage);
                ArrayList<shiftBean> shiftlists = shiftDAO.selectShiftWorkId(work_id);

                // shiftlists に対する繰り返し処理
                for (shiftBean shift : shiftlists) {
                    if (Timestamp.valueOf(shift.getStartdatetime()).compareTo(Timestamp.valueOf(startdatetime)) >= 0) {
                        int shift_id_roop = shift.getShift_id();
                        shiftDAO.editShiftWage(shift_id_roop,wage);
                    }
                }
                
            }

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void updateShift(int shift_id, LocalDateTime startdatetime, LocalDateTime enddatetime, int work_id, int breaktime, int wage, int zikyuchange) throws SQLException {
        String sql = "UPDATE shift SET startdatetime = ?, enddatetime = ?, work_id = ?, breaktime = ?, wage = ? WHERE shift_id = ?";

        try (Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setTimestamp(1, Timestamp.valueOf(startdatetime));
            pstmt.setTimestamp(2, Timestamp.valueOf(enddatetime));
            pstmt.setInt(3, work_id);
            pstmt.setInt(4, breaktime);
            pstmt.setInt(5, wage);
            pstmt.setInt(6, shift_id);

            if (zikyuchange == 2) {
                workDAO.editWorkHourlyWage(work_id, wage);
                ArrayList<shiftBean> shiftlists = shiftDAO.selectShiftWorkId(work_id);

                // shiftlists に対する繰り返し処理
                for (shiftBean shift : shiftlists) {
                    if (Timestamp.valueOf(shift.getStartdatetime()).compareTo(Timestamp.valueOf(startdatetime)) >= 0) {
                        int shift_id_roop = shift.getShift_id();
                        shiftDAO.editShiftWage(shift_id_roop,wage);
                    }
                }

            }


            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("シフト情報の更新に失敗しました。");
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

    public static void editShiftWage(int shift_id, int wage) {
        // SQL文: 指定された work_id のレコードを更新
        String sql = "UPDATE shift SET wage = ? WHERE shift_id = ?";

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            // プレースホルダーに値を設定
            pstmt.setInt(1, wage);
            pstmt.setInt(2, shift_id);

            // SQLの実行
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows updated: " + rowsAffected);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<shiftBean> selectShiftAllFuture(String log_id) throws SQLException {
        // worklists を取得
        ArrayList<workBean> worklists = selectWorkAll(log_id);

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
        sql.append(") AND startdatetime >= ?"); // 今日以降のシフトのみ

        ArrayList<shiftBean> results = new ArrayList<>();

        try (
                Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
                PreparedStatement pstmt = con.prepareStatement(sql.toString())
        ) {
            // プレースホルダーに値を設定
            for (int i = 0; i < workIds.size(); i++) {
                pstmt.setInt(i + 1, workIds.get(i));
            }

            // 今日の日付（現在の日時）を設定
            pstmt.setTimestamp(workIds.size() + 1, Timestamp.valueOf(LocalDateTime.now()));

            // デバッグ: SQL とパラメータの確認
            System.out.println("Executing SQL: " + sql);
            System.out.println("With work_ids: " + workIds);
            System.out.println("With current timestamp: " + LocalDateTime.now());

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

                    // 結果リストに追加
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

}
