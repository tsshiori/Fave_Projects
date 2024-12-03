package com.example.fave;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        if (session != null){
            session.invalidate();
        }
        response.sendRedirect("LoginServlet");
    }
}