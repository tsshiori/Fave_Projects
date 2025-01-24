package com.example.fave.GoodsFile;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.DAO.goodsDAO;

@WebServlet("/GoodsDelServlet")
public class GoodsDelServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8;"); //レスポンスデータ

        int osikatu_id = Integer.parseInt(request.getParameter("goods_id"));
        goodsDAO.goodsDel(osikatu_id);

        response.sendRedirect("fave");
    }
}
