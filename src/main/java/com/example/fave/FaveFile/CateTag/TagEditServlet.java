//package com.example.fave.FaveFile.CateTag;
//
//import java.io.*;
//
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.*;
//import utils.Bean.userBean;
//
//import static utils.DAO.tagDAO.editTag;
//
//@WebServlet("/TagEditServlet")
//public class TagEditServlet extends HttpServlet {
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
//        // フォームから送信されたパラメータを取得
//        String tag = request.getParameter("tag"); // 編集されたタグ名
//        String tag_before = request.getParameter("tag_before"); // 元のタグ名
//        int cate_id = Integer.parseInt(request.getParameter("cate_id")); // カテゴリID
//
//        // デバッグ用に確認
//        System.out.println("タグ名 (新): " + tag);
//        System.out.println("タグ名 (元): " + tag_before);
//        System.out.println("カテゴリID: " + cate_id);
//
//        // タグIDを取得
//        int tag_id = utils.DAO.tagDAO.selectTagByCategory(cate_id, tag_before);
//
//        // タグを編集
//        editTag(tag_id, tag);
//
//        // 編集後のページにリダイレクト
//        response.sendRedirect("relate");
//    }
//
//}
//
//
//
