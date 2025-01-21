//package com.example.fave;
//
//import java.io.*;
//import java.util.ArrayList;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.*;
//import utils.Bean.goodsBean;
//import utils.Bean.workBean;
//import utils.DAO.goodsDAO;
//import utils.Bean.userBean;
//import utils.DAO.workDAO;
//
//@WebServlet("/IndexServlet")
//public class IndexServlet extends HttpServlet {
//
//    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        // セッションを取得
//        HttpSession session = request.getSession();
//
//        // セッションからユーザー情報を取得
//        userBean user = (userBean) session.getAttribute("user");
//
//        String log_id;
//        if (user != null) {
//            // ユーザーのlog_idを取得
//            log_id = user.getLog_id();
//
//            // log_idを使ってgoodslistを取得
//            ArrayList<workBean> goodslist = workDAO.selectWorkAll(log_id);
//
//            // worklistをセッションにセット
//            session.setAttribute("goodslist", goodslist);
//        } else {
//            // ユーザーがセッションにいない場合の処理（例: ログイン画面にリダイレクト）
//            response.sendRedirect("/login.jsp");
//            return;
//        }
//
//        // 商品情報を取得
//        ArrayList<goodsBean> goodsList = goodsDAO.selectGoods(Integer.parseInt(log_id));
//
//        // 取得した商品情報をリクエストスコープにセット
//        request.setAttribute("goodsList", goodsList);
//
//        // index.jsp に転送
//        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
//    }
//
//    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
//    }
//}
