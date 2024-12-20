package com.example.fave.MypageFile;

import java.io.*;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.faveBean;
import utils.Bean.userBean;
import utils.DAO.faveDAO;

@WebServlet("/MypageEditServlet")
public class MypageEditServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<faveBean> favelist = faveDAO.selectFaveAll(log_id);
        session.setAttribute("favelist",favelist);


        String path = "/WEB-INF/view/MypageFile/mypage_edit.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        String nick = request.getParameter("nick");
        int saiosi = Integer.parseInt(request.getParameter("saiosi"));
        int regimg = Integer.parseInt(request.getParameter("regimg"));
        int amounthand = Integer.parseInt(request.getParameter("amount"));
        int living = Integer.parseInt(request.getParameter("living"));


        response.sendRedirect("MypageServlet");
    }
}



