//package com.example.fave.FaveFile.CateTag;
//
//import java.io.*;
//
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.*;
//import utils.Bean.userBean;
//
//@WebServlet("/TagAddServlet")
//public class TagAddServlet extends HttpServlet {
//    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        response.setContentType("text/html; charset=UTF-8");
//        request.setCharacterEncoding("UTF-8");
//        HttpSession session = request.getSession();
//
//        userBean user = (userBean) session.getAttribute("user");
//        String log_id = user.getLog_id();
//    }
//
//    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        response.setContentType("text/html; charset=UTF-8");
//        request.setCharacterEncoding("UTF-8");
//        HttpSession session = request.getSession();
//
//        userBean user = (userBean) session.getAttribute("user");
//        String log_id = user.getLog_id();
//
//        String tag = request.getParameter("tag");
//        int cate_id = Integer.parseInt(request.getParameter("cate_id"));
//
//
//        utils.DAO.tagDAO.insertTag(cate_id,tag);
//
//        response.sendRedirect("relate");
//    }
//}
//
//
//
