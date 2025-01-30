package com.example.fave.FaveFile.CateTag;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.userBean;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/CategoryAddServlet3")
public class CategoryAddServlet3 extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        String category = request.getParameter("category");
        int id = Integer.parseInt(request.getParameter("osi_id"));

        utils.DAO.categoryDAO.insertCategory(log_id,category);
        response.sendRedirect("fave_edit?osi_id=" + URLEncoder.encode(String.valueOf(id), "UTF-8"));
    }
}



