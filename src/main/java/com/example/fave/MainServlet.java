package com.example.fave;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class MainServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                // リクエストの文字エンコーディングを設定
                request.setCharacterEncoding("utf-8");

                // レスポンスの文字エンコーディングを設定
                response.setContentType("text/html; charset=utf-8");
                response.setCharacterEncoding("utf-8");

                // ユーザーがログインしているかを確認
                if (request.getSession().getAttribute("user") == null) {
                        // 未ログインの場合はログインページへ
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                } else {
                        // ログイン済みの場合はインデックスページへ
                        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
                }
        }
}
