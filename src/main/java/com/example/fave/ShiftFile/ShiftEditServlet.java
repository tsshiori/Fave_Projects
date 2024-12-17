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

        public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                response.setContentType("text/html; charset=UTF-8");
                request.setCharacterEncoding("UTF-8");

//                if (startdatetime != null && enddatetime != null && enddatetime.isBefore(startdatetime)) {
//                        // エラー処理: 終了時刻が開始時刻より前の場合
//                        request.setAttribute("errorMessage", "終了時刻は開始時刻より前にはできません。");
//                        request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift_add.jsp").forward(request, response);
//                        return;  // 処理を中止
//                }
                request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);

        }
}



