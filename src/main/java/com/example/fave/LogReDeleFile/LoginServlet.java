package com.example.fave.LogReDeleFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.DAO.GenerateHash;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                HttpSession session = request.getSession();
                request.setCharacterEncoding("utf-8");

                String log_id = request.getParameter("log_id");
                String password = request.getParameter("password");

                // 入力値の検証
                if (log_id == null || log_id.isEmpty() || password == null || password.isEmpty()) {
                        request.setAttribute("errorMessage", "ログインIDまたはパスワードが入力されていません。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                        return;
                }

                // ユーザーの取得
                utils.Bean.userBean user = utils.DAO.userDAO.selectById(log_id);

                // ユーザーが存在しない場合
                if (user == null) {
                        request.setAttribute("errorMessage", "ユーザーが見つかりません。ログインIDを確認してください。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                        return;
                }

                // パスワードの検証
                if (GenerateHash.checkPassword(password, user.getPassword())) {
                        session.setAttribute("log_id", user.getLog_id());
                        session.setAttribute("password", user.getPassword());
                        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
                } else {
                        request.setAttribute("errorMessage", "パスワードが間違っています。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                }
        }
}
