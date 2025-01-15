package com.example.fave.GoodsFile;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.DAO.goodsDAO;

@WebServlet("/GoodsAdd")
public class GoodsAddServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods_add.jsp");
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // リクエストパラメータを取得
        String goodsDate = request.getParameter("goods_date");
        String goodsName = request.getParameter("goods_name");
        String goodsAmount = request.getParameter("amount_cost");
        String goodsFavorite = request.getParameter("goods_favorite");
        String goodsMemo = request.getParameter("goods_memo");

        try {
            // DAOを使用してデータベースに登録
            goodsDAO dao = new goodsDAO();
            dao.addGoods(goodsDate, goodsName, goodsAmount, goodsFavorite, goodsMemo);

            // 処理後、リダイレクトまたは結果ページへ
            response.sendRedirect("WorkServlet");
        } catch (Exception e) {
            e.printStackTrace();
            // エラーページに遷移する場合
            request.setAttribute("errorMessage", "登録処理中にエラーが発生しました。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
//    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/UTF-8");
//        HttpSession session = request.getSession();
//
//        response.sendRedirect("WorkServlet");
//    }
//}