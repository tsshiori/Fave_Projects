//package com.example.fave.FaveFile;
//
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//
//@WebServlet("/categoryServlet")
//public class CategoryServlet extends HttpServlet {
//        @Override
//        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//                String cateId = req.getParameter("cate_id");
//                if (cateId != null) {
//                        System.out.println("受信したカテゴリID: " + cateId);
//                        // 必要な処理をここに記述
//                }
//
//                // レスポンスを返す（必要に応じて調整）
//                resp.setContentType("text/plain;charset=UTF-8");
//                resp.getWriter().write("カテゴリID受信完了");
//        }
//}
