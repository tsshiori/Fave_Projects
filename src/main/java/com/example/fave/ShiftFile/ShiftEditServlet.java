package com.example.fave.ShiftFile;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/ShiftEditServlet")
public class ShiftEditServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift_edit.jsp").forward(request, response);
        }
}



