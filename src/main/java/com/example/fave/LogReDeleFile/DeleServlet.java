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
        HttpSession session = request.getSession();
        request.setCharacterEncoding("utf-8");

        // セッションからユーザーIDを取得
        String log_id = (String) session.getAttribute("log_id");

        // リクエストからパスワードを取得
        String password = request.getParameter("pass");

        // パスワードが未入力の場合
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "パスワードを入力してください。");
            request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
            return;
        }

        try {
            // アカウント削除処理
            boolean isDeleted = userDAO.deleteUser(log_id, password);

            if (isDeleted) {
                // パスワードが正しい場合、削除処理を実行し、結果ページにリダイレクト
                response.sendRedirect("削除完了ページへのリダイレクトURL"); // 成功時のリダイレクト先を指定
            } else {
                // パスワードが間違っている場合
                request.setAttribute("errorMessage", "パスワードが間違っています。再度入力してください。");
                request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // サーバーエラー発生時の処理
            e.printStackTrace();
            request.setAttribute("errorMessage", "サーバーエラーが発生しました。");
            request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
        }
    }
}
