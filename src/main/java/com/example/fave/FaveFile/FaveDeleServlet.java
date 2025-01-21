package com.example.fave.FaveFile;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.DAO.faveDAO;
import utils.DAO.tagDAO;

@WebServlet("/FaveDeleServlet")
public class FaveDeleServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/view/FaveFile/fave.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        int osi_id = Integer.parseInt(request.getParameter("osi_id"));
        tagDAO.delTag(osi_id);
        faveDAO.faveDel(osi_id);

        response.sendRedirect("Fave");
    }
}