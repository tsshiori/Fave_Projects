package com.example.fave.ShiftFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.shiftBean;
import utils.Bean.userBean;
import utils.Bean.workBean;
import utils.DAO.shiftDAO;
import utils.DAO.workDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/ShiftAddServlet")
public class ShiftAddServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<workBean> worklist = utils.DAO.workDAO.selectWorkAll(log_id);
        session.setAttribute("worklist", worklist);

        request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift_add.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        int work_id = 0;
        int shift_id = 0;
        LocalDateTime startdatetime = null;
        LocalDateTime enddatetime = null;
        int breaktime = 0;
        int wage = 0;

        try {
            // work_id のチェック
            String workIdParam = request.getParameter("work_id");
            if (workIdParam != null && !workIdParam.isEmpty()) {
                work_id = Integer.parseInt(workIdParam);
            }

            // startdatetime と enddatetime のチェック
            String startDateParam = request.getParameter("startdatetime");
            String endDateParam = request.getParameter("enddatetime");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

            if (startDateParam != null && !startDateParam.isEmpty()) {
                startdatetime = LocalDateTime.parse(startDateParam, formatter);
            }

            if (endDateParam != null && !endDateParam.isEmpty()) {
                enddatetime = LocalDateTime.parse(endDateParam, formatter);
            }

            // startdatetime が enddatetime より後かチェック
            if (startdatetime != null && enddatetime != null && enddatetime.isBefore(startdatetime)) {
                // エラー処理: 終了時刻が開始時刻より前の場合
                request.setAttribute("errorMessage", "終了時刻は開始時刻より前にはできません。");
                request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift_add.jsp").forward(request, response);
                return;  // 処理を中止
            }

            // breaktime のチェック
            String breaktimeParam = request.getParameter("breaktime");
            if (breaktimeParam != null && !breaktimeParam.isEmpty()) {
                breaktime = Integer.parseInt(breaktimeParam);
            }

            // wage のチェック
            String wageParam = request.getParameter("wage");
            if (wageParam != null && !wageParam.isEmpty()) {
                wage = Integer.parseInt(wageParam);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 正常な場合のみシフトをデータベースに挿入
        shiftDAO.insertShift(shift_id, startdatetime, enddatetime, work_id, breaktime, wage);
        response.sendRedirect("ShiftServlet");
    }
}

