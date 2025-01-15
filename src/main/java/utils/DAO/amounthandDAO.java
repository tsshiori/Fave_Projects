package utils.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalDateTime;

public class amounthandDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fave_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "morijyobi";

    public static void insertADayWage(LocalDateTime startdatetime, LocalDateTime enddatetime, int work_id, int breaktime, int wage, String log_id, int amounthand) {

        String sql = "UPDATE account SET amounthand = ? WHERE log_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Connection con = DriverManager.getConnection(DB_URL);
            Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(sql);

            // 追加する日の給与計算
            int addwage = 0;

            // 開始時間と終了時間の差を計算
            Duration duration = Duration.between(startdatetime, enddatetime);

            // 時間と分を計算（int型にキャスト）
            int hours = (int) duration.toHours(); // longからintにキャスト
            int minutes = (int) (duration.toMinutes() % 60); // longからintにキャスト

            // breaktimeは分単位で、給与計算に影響を与える場合がある
            // 休憩時間を差し引いて、実働時間を計算
            int totalMinutes = (int) duration.toMinutes() - breaktime;

            // 実働時間を時間と分に再計算
            int finalHours = totalMinutes / 60;
            int finalMinutes = totalMinutes % 60;

            // 時間と分に基づいて給与計算
            addwage = finalHours * wage + (finalMinutes / 60) * wage;
            amounthand += addwage;

            // 給与計算の結果を更新
            pstmt.setInt(1, amounthand);  // 計算した給与額をセット
            pstmt.setString(2, log_id);  // log_idをセット

            // SQL実行
            pstmt.executeUpdate();

            // 終了処理
            pstmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteADayWage(LocalDateTime startdatetime, LocalDateTime enddatetime, int work_id, int breaktime, int wage, String log_id, int amounthand) {

        String sql = "UPDATE account SET amounthand = ? WHERE log_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Connection con = DriverManager.getConnection(DB_URL);
            Connection con = DriverManager.getConnection(DB_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(sql);

            // 追加する日の給与計算
            int delwage = 0;

            // 開始時間と終了時間の差を計算
            Duration duration = Duration.between(startdatetime, enddatetime);

            // 時間と分を計算（int型にキャスト）
            int hours = (int) duration.toHours(); // longからintにキャスト
            int minutes = (int) (duration.toMinutes() % 60); // longからintにキャスト

            // breaktimeは分単位で、給与計算に影響を与える場合がある
            // 休憩時間を差し引いて、実働時間を計算
            int totalMinutes = (int) duration.toMinutes() - breaktime;

            // 実働時間を時間と分に再計算
            int finalHours = totalMinutes / 60;
            int finalMinutes = totalMinutes % 60;

            // 時間と分に基づいて給与計算
            delwage = finalHours * wage + (finalMinutes / 60) * wage;
            amounthand -= delwage;

            // 給与計算の結果を更新
            pstmt.setInt(1, amounthand);  // 計算した給与額をセット
            pstmt.setString(2, log_id);  // log_idをセット

            // SQL実行
            pstmt.executeUpdate();

            // 終了処理
            pstmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int futureWage(LocalDateTime startdatetime, LocalDateTime enddatetime, int work_id, int breaktime, int wage, String log_id) {
        // 追加する日の給与計算
        int futureWage = 0;

        // 開始時間と終了時間の差を計算
        Duration duration = Duration.between(startdatetime, enddatetime);

        // 時間と分を計算（int型にキャスト）
        int hours = (int) duration.toHours(); // longからintにキャスト
        int minutes = (int) (duration.toMinutes() % 60); // longからintにキャスト

        // breaktimeは分単位で、給与計算に影響を与える場合がある
        // 休憩時間を差し引いて、実働時間を計算
        int totalMinutes = (int) duration.toMinutes() - breaktime;

        // 実働時間を時間と分に再計算
        int finalHours = totalMinutes / 60;
        int finalMinutes = totalMinutes % 60;

        // 時間と分に基づいて給与計算
        futureWage = finalHours * wage + (finalMinutes / 60) * wage;

        return futureWage;
    }





}


