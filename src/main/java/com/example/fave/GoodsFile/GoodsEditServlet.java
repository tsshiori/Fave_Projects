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
//        if (osikatuidParam == null || osikatuidParam.trim().isEmpty()) {
//            // エラー応答
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid osikatu_id parameter.");
//            return;
//        }

        try {
            // 数値変換
            int osikatu_id = Integer.parseInt(osikatuidParam.trim());
            session.setAttribute("osikatu_id", osikatu_id);

            // データベース操作
            goodsBean goods = goodsDAO.getFaveByOsikatu_id(osikatu_id);
            session.setAttribute("goods", goods);

            session.setAttribute("itemType", goods.getItemtype());
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
                    ArrayList<osikatuBean> good = goodsDAO.selectGoods(osi);
                    goodsList.addAll(good);
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
            request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods_edit.jsp").forward(request, response);

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
            int osikatu_id = -1;
            String osikatuIdParam = request.getParameter("osikatu_id");
            if (osikatuIdParam != null && !osikatuIdParam.isEmpty()) {
                try {
                    osikatu_id = Integer.parseInt(osikatuIdParam);
                } catch (NumberFormatException e) {
                    errors.add("オシカツIDは正しい形式で入力してください。");
                }
            }

            String dayParam = request.getParameter("day");
            LocalDate day = null;
            if (dayParam != null && !dayParam.isEmpty()) {
                try {
                    day = LocalDate.parse(dayParam);
                } catch (Exception e) {
                    errors.add("日付の形式が正しくありません。");
                }
            }

            int price = -1;
            String priceParam = request.getParameter("price");
            if (priceParam != null && !priceParam.isEmpty()) {
                try {
                    price = Integer.parseInt(priceParam);
                } catch (NumberFormatException e) {
                    errors.add("価格は数字で入力してください。");
                }
            }

            String item = "sample";
             item = request.getParameter("item");
            if (item == null || item.trim().isEmpty()) {
                errors.add("アイテム名を入力してください。");
            }

            int purchase = -1;
            String purchaseParam = request.getParameter("purchase");
            if (purchaseParam != null && !purchaseParam.isEmpty()) {
                try {
                    purchase = Integer.parseInt(purchaseParam);
                } catch (NumberFormatException e) {
                    errors.add("購入数は数字で入力してください。");
                }
            }else{
                purchase = 0;
            }

            int osi_id = -1;
            String osiIdParam = request.getParameter("osi_id");
            if (osiIdParam != null && !osiIdParam.isEmpty()) {
                try {
                    osi_id = Integer.parseInt(osiIdParam);
                } catch (NumberFormatException e) {
                    errors.add("オシIDは正しい形式で入力してください。");
                }
            }

            String memo = request.getParameter("memo");

            // itemtype（0:グッズ, 1:イベント）の取得
            int itemType = 0; // デフォルトはグッズ
            String itemTypeString = request.getParameter("itemtype");
            if (itemTypeString != null) {
                try {
                    itemType = Integer.parseInt(itemTypeString);
                    if (itemType != 0 && itemType != 1) {
                        errors.add("itemtypeは0または1でなければなりません。");
                    }
                } catch (NumberFormatException e) {
                    errors.add("itemtypeの形式が正しくありません。");
                }
            }

            // エラーがあれば適切に処理（例: エラーページに遷移）
            if (!errors.isEmpty()) {
                // エラーメッセージがあればリクエストにセットしてforward
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods_edit.jsp").forward(request, response);
                return; // ここで処理を終了
            }

            // formTypeの取得
            String formType = "goods";
             formType = request.getParameter("formType");
            if (formType != null && !formType.trim().isEmpty()) {
                if (formType.equals("goods")) {
                    // グッズモーダルからのデータ処理
                    int goodsicon = 0;
                    String goodsiconString = request.getParameter("goodsicon");
                    if (goodsiconString != null && !goodsiconString.trim().isEmpty()) {
                        try {
                            goodsicon = Integer.parseInt(goodsiconString);
                        } catch (NumberFormatException e) {
                            errors.add("優先度の形式が正しくありません。");
                        }
                    }

                    // DAOの更新メソッドを呼び出し
                    utils.DAO.goodsDAO.updateGoods(osikatu_id, day, price, item, purchase, osi_id, goodsicon, memo, itemType);
                } else if (formType.equals("event")) {
                    // イベントモーダルからのデータ処理
                    int eventicon = 0;
                    String eventiconString = request.getParameter("eventicon");
                    if (eventiconString != null && !eventiconString.trim().isEmpty()) {
                        try {
                            eventicon = Integer.parseInt(eventiconString);
                        } catch (NumberFormatException e) {
                            errors.add("優先度の形式が正しくありません。");
                        }
                    }

                    // DAOの更新メソッドを呼び出し
                    utils.DAO.goodsDAO.updateGoods(osikatu_id, day, price, item, purchase, osi_id, eventicon, memo, itemType);
                }
            }

            // セッションデータを更新
            ArrayList<Integer> goodslist = goodsDAO.selectOsikatu_id(log_id);
            session.setAttribute("goodslist", goodslist);

            // 完了後リダイレクト
            response.sendRedirect("fave");

        } catch (Exception e) {
            // 予期しないエラーが発生した場合もエラーメッセージを表示
            errors.add("予期しないエラーが発生しました。再度お試しください。");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods.jsp").forward(request, response);
        }
    }
}
