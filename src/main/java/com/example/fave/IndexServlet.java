package com.example.fave;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/IndexServlet")
public class IndexServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
            request.setAttribute("errorMessage", "ログインIDまたはパスワードが入力されていません。");
            request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);

    }
}



