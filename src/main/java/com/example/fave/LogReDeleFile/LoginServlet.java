package com.example.fave.LogReDeleFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.userBean;
import utils.DAO.GenerateHash;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                request.setAttribute("errorMessage", "ログインIDまたはパスワードが入力されていません。");
                request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                // セッションとリクエストの設定
                HttpSession session = request.getSession();
                request.setCharacterEncoding("utf-8");
                response.setContentType("text/UTF-8");

                // フォームデータの取得
                String log_id = request.getParameter("log_id");
                String password = request.getParameter("password");

                // 入力値の検証
                if (log_id == null || log_id.isEmpty() || password == null || password.isEmpty()) {
                        request.setAttribute("errorMessage", "ログインIDまたはパスワードが入力されていません。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                        return;
                }

                // ユーザー情報の取得
                utils.Bean.userBean user = utils.DAO.userDAO.selectById(log_id);

                if (user == null) {
                        // ユーザーが存在しない場合
                        request.setAttribute("errorMessage", "該当するユーザーが見つかりません。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                        return;
                }

                // ユーザー情報を取得した後
                if (GenerateHash.checkPassword(password, user.getPassword())) {
                        // パスワードが一致する場合、セッションにユーザー情報を保存
                        session.setAttribute("user", user);

                        // デバッグ用：セッションに保存された情報を確認
                        System.out.println("User saved in session: " + session.getAttribute("user"));

                        // ログイン後のページへリダイレクト
                        response.sendRedirect(request.getContextPath() + "/fave");
                } else {
                        // 認証失敗
                        request.setAttribute("errorMessage", "パスワードが間違っています。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);

                }
        }
}
