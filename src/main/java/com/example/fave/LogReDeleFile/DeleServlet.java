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
        // セッションから現在のユーザーIDを取得
        HttpSession session = request.getSession();
        request.setCharacterEncoding("utf-8");

        // セッションからユーザーIDを取得
        String log_id = (String) session.getAttribute("log_id");

        // リクエストからパスワードを取得
        String password = request.getParameter("password");

        try {
            // アカウント削除処理
            userDAO.deleteUser(log_id, password);  // void型なので結果を受け取らない

            // 削除処理が成功した場合、セッションを無効化
            session.invalidate();
            // ログインページにリダイレクト
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } catch (SQLException e) {
            // エラー発生時の処理
            e.printStackTrace();
            request.setAttribute("errorMessage", "サーバーエラーが発生しました。");
            request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
        } catch (Exception e) {
            // パスワードが一致しない、または削除に失敗した場合
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());  // deleteUser()内で出力したメッセージを使う
            request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
        }
    }
}