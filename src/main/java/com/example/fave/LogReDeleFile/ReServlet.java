package com.example.fave.LogReDeleFile;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.userBean;
import utils.DAO.userDAO;
import utils.DAO.faveDAO;


public class ReServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = "/WEB-INF/view/LogReDeleFile/re.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // パラメータ受け取り
        request.setCharacterEncoding("UTF-8");
        String log_id = request.getParameter("log_id");
        String password = request.getParameter("password");
        String nick = request.getParameter("nick");
        int regimg = Integer.parseInt(request.getParameter("regimg"));
        int amounthand = Integer.parseInt(request.getParameter("amounthand"));
        int living = Integer.parseInt(request.getParameter("living"));
        String name = request.getParameter("name");

        if (utils.DAO.userDAO.selectById(log_id) != null){
            request.setAttribute("errorMessage", "既に存在するユーザIDです。");
            request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
        } else {
            utils.DAO.faveDAO.insertFave(null, name, null, null, log_id, 1);
            int saiosi = utils.DAO.faveDAO.selectNameFave(log_id, name);
            utils.DAO.userDAO.insertAccount(log_id, password, nick, regimg, amounthand, living, saiosi, null);

            // リダイレクト先を修正
            response.sendRedirect(request.getContextPath() + "/fave");  // /faveがLoginServletのURLパターン
        }
    }

}