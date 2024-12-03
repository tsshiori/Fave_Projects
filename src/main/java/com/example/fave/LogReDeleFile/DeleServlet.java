package com.example.fave.LogReDeleFile;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import utils.Bean.userBean;
import utils.DAO.userDAO;
import java.sql.SQLException;

@WebServlet("/DeleServlet")
public class DeleServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // dele.jsp へのリダイレクト
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // セッションから現在のユーザーIDを取得
        HttpSession session = request.getSession();
        request.setCharacterEncoding("utf-8");
        String log_id = session.getAttribute("log_id").toString();
        userBean user = utils.DAO.userDAO.selectById(log_id);
        // パスワードをリクエストから取得
        String password = request.getParameter("password");
//
//        try {
//            // パスワードが一致するか確認
//            if (userDAO.checkPassword(userId, password)) {
//                // アカウント削除処理
//                boolean isDeleted = userDAO.deleteUser(userId);
//                if (isDeleted) {
//                    // セッションを無効化し、ログアウト状態にする
//                    request.getSession().invalidate();
//                    // 削除後はログインページにリダイレクト
//                    response.sendRedirect(request.getContextPath() + "/login.jsp");
//                } else {
//                    request.setAttribute("errorMessage", "アカウント削除に失敗しました。");
//                    request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
//                }
//            } else {
//                request.setAttribute("errorMessage", "パスワードが一致しません。");
//                request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "サーバーエラーが発生しました。");
//        }
    }
}