package com.example.fave.WorkFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.userBean;
import utils.Bean.workBean;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/WorkEditServlet")
public class WorkEditServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.setCharacterEncoding("UTF-8");
                String workIdParam = request.getParameter("work_id");

                if (workIdParam == null || workIdParam.isEmpty()) {
                        request.setAttribute("errorMessage", "編集対象のデータが指定されていません。");
                        response.sendRedirect("WorkServlet"); // 必要に応じてエラーページへ
                        return;
                }

                HttpSession session = request.getSession();
                userBean user = (userBean) session.getAttribute("user");
                if (user == null) {
                        response.sendRedirect("login"); // セッションが切れている場合ログイン画面にリダイレクト
                        return;
                }

                String log_id = user.getLog_id();
                int work_id = Integer.parseInt(workIdParam);

                ArrayList<workBean> worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                workBean targetWork = worklist.stream()
                        .filter(work -> work.getWork_id() == work_id)
                        .findFirst()
                        .orElse(null);

                if (targetWork == null) {
                        request.setAttribute("errorMessage", "対象のバイト先が見つかりません。");
                        response.sendRedirect("WorkServlet");
                        return;
                }

                request.setAttribute("targetWork", targetWork);
                request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_edit.jsp").forward(request, response);
        }

        public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/UTF-8");
                HttpSession session = request.getSession();

                userBean user = (userBean) session.getAttribute("user");
                if (user == null) {
                        response.sendRedirect("login"); // セッションが切れている場合ログイン画面にリダイレクト
                        return;
                }
                String log_id = user.getLog_id();

                try {
                        // フォームデータ取得
                        int work_id = Integer.parseInt(request.getParameter("work_id"));
                        String work = request.getParameter("work");
                        int hourlywage = Integer.parseInt(request.getParameter("hourlywage"));
                        boolean mainwork = "on".equals(request.getParameter("main"));

                        // バイト情報を更新
                        utils.DAO.workDAO.editWork(work_id, hourlywage, work, mainwork, log_id);

                        // メインバイトの場合、ユーザー情報を更新
                        if (mainwork) {
                                utils.DAO.userDAO.updateMainWork(work_id, log_id);
                        }

                        // セッションデータを更新
                        user = utils.DAO.userDAO.selectById(log_id);
                        session.setAttribute("user", user);
                        ArrayList<workBean> worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                        session.setAttribute("worklist", worklist);

                        // 完了後リダイレクト
                        response.sendRedirect("WorkServlet");
                } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "入力されたデータが無効です。");
                        request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_edit.jsp").forward(request, response);
                } catch (Exception e) {
                        request.setAttribute("errorMessage", "編集処理中にエラーが発生しました。");
                        request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_edit.jsp").forward(request, response);
                }
        }
}
