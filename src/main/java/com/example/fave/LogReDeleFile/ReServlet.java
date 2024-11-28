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
        int regimg = parseInteger(request.getParameter("regimg"), 0);
        int amounthand = parseInteger(request.getParameter("amounthand"), 0);
        int living = parseInteger(request.getParameter("living"), 0);
        String name = request.getParameter("name");

        try {
            if (utils.DAO.userDAO.selectById(log_id) != null) {
                request.setAttribute("errorMessage", "既に存在するユーザIDです。");
                request.getRequestDispatcher("/WEB-INF/view/DAOerror.jsp").forward(request, response);
                return;
            }

            int saiosi = -1;
            if (name != null) {
                utils.DAO.faveDAO.insertFave(null, name, null, null, log_id, 1);
                saiosi = utils.DAO.faveDAO.selectNameFave(log_id, name);
            }

            utils.DAO.userDAO.insertAccount(log_id, password, nick, regimg, amounthand, living, saiosi, null);

            String path = "/WEB-INF/view/LogReDeleFile/login.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(path);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "登録処理中にエラーが発生しました。");
            request.getRequestDispatcher("/WEB-INF/view/DAOerror.jsp").forward(request, response);
        }
    }

    private int parseInteger(String param, int defaultValue) {
        try {
            return (param == null || param.isEmpty()) ? defaultValue : Integer.parseInt(param);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
