package com.example.fave.ShiftFile;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.shiftBean;
import utils.Bean.userBean;
import utils.Bean.workBean;

@WebServlet("/ShiftEditServlet")
public class ShiftEditServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                response.setContentType("text/html; charset=UTF-8");
                request.setCharacterEncoding("UTF-8");
                HttpSession session = request.getSession();

                userBean user = (userBean) session.getAttribute("user");
                String log_id = user.getLog_id();
                ArrayList<workBean> worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                session.setAttribute("worklist", worklist);

                // セッションからエラーメッセージを取得してJSPに渡す
                String errorMessage = (String) session.getAttribute("errorMessage");
                if (errorMessage != null) {
                        request.setAttribute("errorMessage", errorMessage);
                        session.removeAttribute("errorMessage");  // メッセージは一度表示したら削除
                }

                try {
                        ArrayList<shiftBean> shiftlist = utils.DAO.shiftDAO.selectShiftAll(log_id);
                } catch (SQLException e) {
                        throw new RuntimeException(e);
                }

                request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift_edit.jsp").forward(request, response);
        }


        public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                response.setContentType("text/html; charset=UTF-8");
                request.setCharacterEncoding("UTF-8");
                HttpSession session = request.getSession();

                userBean user = (userBean) session.getAttribute("user");
                String log_id = user.getLog_id();

                int work_id = 0;
                int shift_id = 0;
                LocalDateTime startdatetime = null;
                LocalDateTime enddatetime = null;
                int breaktime = 0;
                int wage = 0;
                int zikyuchange = 0;

                try {
                        String shiftIdParam = request.getParameter("shift_id");
                        if (shiftIdParam != null && !shiftIdParam.isEmpty()) {
                                try {
                                        shift_id = Integer.parseInt(shiftIdParam);
                                } catch (NumberFormatException e) {
                                        e.printStackTrace();
                                }
                        }


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
                                session.setAttribute("errorMessage", "終了時刻は開始時刻より前にはできません。");

                                // リダイレクト時にshift_idを正しく渡す
                                response.sendRedirect("ShiftEditServlet?shift_id=" + shift_id);
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

                        // zikyuchange のチェック
                        zikyuchange = Integer.parseInt(request.getParameter("zikyu-change"));

                } catch (Exception e) {
                        e.printStackTrace();
                }

                try {
                        utils.DAO.shiftDAO.updateShift(shift_id,startdatetime,enddatetime,work_id,breaktime,wage, zikyuchange);
                } catch (SQLException e) {
                        throw new RuntimeException(e);
                }
                response.sendRedirect("ShiftServlet");
        }
}



