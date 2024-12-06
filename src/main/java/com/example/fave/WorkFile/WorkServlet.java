package com.example.fave.WorkFile;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/WorkServlet")
public class WorkServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.getRequestDispatcher("/WEB-INF/view/WorkFile/work.jsp").forward(request, response);
        }
}



