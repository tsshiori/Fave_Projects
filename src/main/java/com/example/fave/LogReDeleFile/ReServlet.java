package com.example.fave.LogReDeleFile;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
//import utils.userBean;
//import utils.userDAO;

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
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String pw = request.getParameter("pw");

//        userBean user = new userBean(id, name, pw);
//
//        // DBに登録
//        userDAO.insert(user);

        // Loginにリダイレクト
        response.sendRedirect("");
    }
}