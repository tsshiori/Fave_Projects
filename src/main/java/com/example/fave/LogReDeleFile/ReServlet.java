package com.example.fave.LogReDeleFile;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.userBean;
import utils.DAO.userDAO;
import utils.DAO.faveDAO;

@WebServlet("/ReServlet")
public class ReServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = "/WEB-INF/view/LogReDeleFile/re.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // パラメータ受け取り
        request.setCharacterEncoding("UTF-8");
        String log_id = request.getParameter("log_id");
        String password = request.getParameter("password");
        String nick = request.getParameter("nick");
        int regimg = Integer.parseInt(request.getParameter("regimg"));
        int amounthand = Integer.parseInt(request.getParameter("amounthand"));
        int living = Integer.parseInt(request.getParameter("living"));
        String saiosi = request.getParameter("saiosi");

//        if (utils.DAO.userDAO.selectById(log_id)){
//
//        }
//        utils.DAO.faveDAO.insertFave(null,saiosi,null,null,log_id,null);
//        utils.DAO.userDAO.insertAccount(log_id,password,nick,regimg,amounthand,living,,null);

        response.sendRedirect("LoginServlet");
    }
}