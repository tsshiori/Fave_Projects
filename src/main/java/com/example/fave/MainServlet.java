package com.example.fave;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MainServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                if (request.getSession().getAttribute("user") == null) {
                        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                } else {
                        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
                }
        }
}
