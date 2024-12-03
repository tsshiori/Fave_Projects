package com.example.fave.LogReDeleFile;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import utils.DAO.userDAO;
import java.sql.SQLException;

@WebServlet("/DeleServlet")
public class DeleServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // dele.jsp へのリダイレクト
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp");
        dispatcher.forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");

//        // セッションからユーザーIDを取得
//        Integer userId = (Integer) session.getAttribute("user_id");
//
//        if (userId == null) {
//            // ユーザーがログインしていない場合、エラーページまたはログインページにリダイレクト
//            response.sendRedirect("LoginServlet");
//            return;
//        }
//
//        // userId を String 型に変換
//        String logId = String.valueOf(userId);  // Integer を String に変換
//
//        // ユーザーが入力したパスワードを取得
//        String inputPassword = request.getParameter("pw");
//
//        try {
//            // パスワードの検証
//            boolean isDeleted = userDAO.deleteUser(logId, inputPassword);  // String 型の logId を渡す
//
//            if (isDeleted) {
//                // アカウント削除成功時
//                session.invalidate(); // セッションを無効化
//                response.sendRedirect("/WEB-INF/view/LogReDeleFile/login.jsp"); // 削除完了ページへリダイレクト
//            } else {
//                // アカウント削除失敗時（例: パスワード不一致）
//                request.setAttribute("errorMessage", "パスワードが正しくありません。");
//                request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
//            }
//        } catch (SQLException e) {
//            // SQLExceptionの処理
//            System.err.println("SQL エラー: " + e.getMessage());
//            // エラーメッセージをリクエストにセット
//            request.setAttribute("errorMessage", "アカウント削除中にエラーが発生しました。");
//            // エラーページにフォワード
//            request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/dele.jsp").forward(request, response);
//        }
    }
}
