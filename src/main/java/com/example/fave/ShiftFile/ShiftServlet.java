package com.example.fave.ShiftFile;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/ShiftServlet")
public class ShiftServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
            request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift.jsp").forward(request, response);
    }
}



