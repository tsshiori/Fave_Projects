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

@WebServlet("/WorkAddServlet")
public class WorkAddServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_add.jsp").forward(request, response);
        }

        public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/UTF-8");
                HttpSession session = request.getSession();

                // 入力データ取得
                int work_id = -1; // 新規の場合は -1
                int hourlywage = Integer.parseInt(request.getParameter("hourlywage"));
                String work = request.getParameter("work");
                String mainworkParam = request.getParameter("mainwork");
                int mainwork = (mainworkParam != null) ? 1 : 0;

                // ログイン情報を取得
                userBean user = (userBean) session.getAttribute("user");
                if (user == null) {
                        response.sendRedirect("login"); // ログイン情報がない場合はログイン画面にリダイレクト
                        return;
                }
                String log_id = user.getLog_id();

                // 現在のワークリストを取得
                ArrayList<workBean> worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                if (worklist == null) {
                        session.setAttribute("errorMessage", "データベースから情報を取得できませんでした。管理者にお問い合わせください。");
                        response.sendRedirect("error"); // エラーページにリダイレクト
                        return;
                }

                // 重複確認
                boolean isDuplicate = worklist.stream().anyMatch(wb -> wb.getWork().equals(work));
                if (isDuplicate) {
                        request.setAttribute("errorMessage", "既に存在するバイト名です。");
                        request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_add.jsp").forward(request, response);
                        return;
                }

                // 新しいバイト先を追加
                utils.DAO.workDAO.insertWork(work_id, hourlywage, work, log_id);

                // メインバイト設定の更新
                if (mainwork == 1) {
                        work_id = utils.DAO.workDAO.selectNameWork(log_id, work);
                        utils.DAO.userDAO.updateMainWork(work_id, log_id);

                        // 更新したユーザーデータを再取得してセッションに保存
                        user = utils.DAO.userDAO.selectById(log_id);
                        session.setAttribute("user", user);
                }

                // ワークリストを再取得してセッションに保存
                worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                session.setAttribute("worklist", worklist);

                // 完了後、doGetにリダイレクト
                response.sendRedirect("WorkServlet");
        }
}
