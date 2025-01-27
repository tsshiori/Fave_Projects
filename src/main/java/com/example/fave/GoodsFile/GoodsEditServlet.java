package com.example.fave.GoodsFile;

import java.io.*;

import java.util.ArrayList;
import java.util.Comparator;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.*;
import utils.Bean.faveBean;
import utils.Bean.osikatuBean;
import utils.Bean.userBean;

import utils.Bean.goodsBean;
import utils.Bean.osikatuBean;
import utils.Bean.userBean;
import utils.Bean.workBean;


import utils.DAO.goodsDAO;


public class GoodsEditServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // osikatu_id パラメータの取得
        String osikatuidParam = request.getParameter("osikatu_id");
        if (osikatuidParam == null || osikatuidParam.trim().isEmpty()) {
            // エラー応答
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid osikatu_id parameter.");
            return;
        }

        try {
            // 数値変換
            int osikatu_id = Integer.parseInt(osikatuidParam.trim());
            session.setAttribute("osikatu_id", osikatu_id);

            // データベース操作
            goodsBean goods = goodsDAO.getFaveByOsikatu_id(osikatu_id);
            session.setAttribute("goods", goods);
          
          
          // セッションからユーザー情報を取得
        userBean user = (userBean) session.getAttribute("user");

        String log_id;
      //  全部のservletに貼るコード

        if (user != null) {
            // ユーザーのlog_idを取得
            log_id = user.getLog_id();

            ArrayList<faveBean> favelist = utils.DAO.faveDAO.selectFaveAll(log_id);
            session.setAttribute("favelist", favelist);

            ArrayList<Integer> osi_id = goodsDAO.selectOsikatu_id(log_id);
            // 商品情報を取得
            ArrayList<osikatuBean> goodsList = new ArrayList<>();
            for (int osi : osi_id) {
                ArrayList<osikatuBean> goods = goodsDAO.selectGoods(osi);
                goodsList.addAll(goods);
            }

            if (goodsList != null) {
                goodsList.sort(Comparator.comparing(osikatuBean::getPriority));
            }
            // 取得した商品情報をリクエストスコープにセット
            session.setAttribute("goodsList", goodsList);
            int sum = 0;

            for (osikatuBean good : goodsList) {
                if (good.getPurchase() != 1) {
                    sum = sum + good.getPrice();
                }
            }

            session.setAttribute("sum", sum);

        }
          
          
          

            // JSP にフォワード
            request.getRequestDispatcher("/WEB-INF/view/FaveFile/goods_edit.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // 数値変換エラー時の応答
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid osikatu_id format. Must be a number.");
        }

    }


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        List<String> errors = new ArrayList<>();
        try {
            // リクエストパラメータの取得
            int osikatu_id = Integer.parseInt(request.getParameter("osikatu_id"));
            String dayParam = request.getParameter("day");
            LocalDate day = dayParam != null && !dayParam.isEmpty() ? LocalDate.parse(dayParam) : null;
            int price = Integer.parseInt(request.getParameter("price"));
            String item = request.getParameter("item");
            int purchase = Integer.parseInt(request.getParameter("purchase"));
            int osi_id = Integer.parseInt(request.getParameter("osi_id"));

            String memo = request.getParameter("memo");
            int itemtype = Integer.parseInt(request.getParameter("itemtype"));


            String formType = request.getParameter("formType");

            if (formType != null && !formType.trim().isEmpty()) {
                if (formType.equals("goods")) {
                    // グッズモーダルからのデータ処理
                    int goodsicon = 0;
                    String priorityString = request.getParameter("goodsicon");
                    if (priorityString != null && !priorityString.trim().isEmpty()) {
                        try {
                            goodsicon = Integer.parseInt(priorityString);
                        } catch (NumberFormatException e) {
                            errors.add("優先度の形式が正しくありません。");
                        }




                    }
                    // DAOの更新メソッドを呼び出し
                    utils.DAO.goodsDAO.updateGoods(osikatu_id, day, price, item, purchase, osi_id, goodsicon, memo, itemtype);


                } else if (formType.equals("event")) {
                    // イベントモーダルからのデータ処理
                    int eventicon = 0;
                    String priorityString = request.getParameter("eventicon");
                    if (priorityString != null && !priorityString.trim().isEmpty()) {
                        try {
                            eventicon = Integer.parseInt(priorityString);
                        } catch (NumberFormatException e) {
                            errors.add("優先度の形式が正しくありません。");
                        }


                    }
                    // DAOの更新メソッドを呼び出し
                    utils.DAO.goodsDAO.updateGoods(osikatu_id, day, price, item, purchase, osi_id, eventicon, memo, itemtype);


                }
            }
// セッションデータを更新
            ArrayList<Integer> goodslist = goodsDAO.selectOsikatu_id(log_id);
            session.setAttribute("goodslist", goodslist);


// 完了後リダイレクト
            response.sendRedirect("fave");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "入力されたデータが無効です。");
            request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_edit.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "編集処理中にエラーが発生しました。");
            request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_edit.jsp").forward(request, response);
        }
    }
}