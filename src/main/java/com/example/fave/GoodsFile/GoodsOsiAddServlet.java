package com.example.fave.GoodsFile;

import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.time.LocalDate;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.faveBean;
import utils.Bean.userBean;
import utils.DAO.goodsDAO;

@WebServlet("/GoodsOsiAdd")
public class GoodsOsiAddServlet extends HttpServlet{
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
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "ログインが必要です。");
            return;
        }

        String log_id = user.getLog_id();
        String modalosi = request.getParameter("modalosi");

        if (modalosi == null || modalosi.isEmpty()) {
            response.getWriter().println("エラー: 推しの名前が入力されていません。");
            response.sendRedirect("relate");
        }

        try {
            utils.DAO.faveDAO.insertFave("def.png", modalosi, null, null, log_id, 1);
            response.sendRedirect("goods_add");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("エラー: 推しの追加に失敗しました。");
        }
    }

}
