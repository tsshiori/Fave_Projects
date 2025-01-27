package com.example.fave.GoodsFile;

import java.io.*;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.faveBean;
import utils.Bean.osikatuBean;
import utils.Bean.userBean;
import utils.DAO.goodsDAO;
import java.util.Collections;
import java.util.Comparator;

@WebServlet("/Goods")
public class GoodsServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        // osi_id_listを取得
        ArrayList<Integer> osi_id_list = utils.DAO.goodsDAO.selectOsikatu_id(log_id);

// 結果を保持するリスト
        ArrayList<osikatuBean> purchaseZeroList = new ArrayList<>();
        ArrayList<osikatuBean> purchaseOtherList = new ArrayList<>();

        if (osi_id_list != null && !osi_id_list.isEmpty()) {
            for (int osi_id : osi_id_list) {
                // osi_id を使って osikatuBean のリストを取得
                ArrayList<osikatuBean> beans = goodsDAO.selectOsikatuByOsi_id(osi_id);

                if (beans != null) {
                    for (osikatuBean bean : beans) {
                        if (bean.getPurchase() == 0) {
                            purchaseZeroList.add(bean); // purchaseが0の場合
                        } else {
                            purchaseOtherList.add(bean); // その他の場合
                        }
                    }
                }
            }

            // `priority` でソート（小さい順）
            purchaseZeroList.sort(Comparator.comparingInt(osikatuBean::getPriority));
            purchaseOtherList.sort(Comparator.comparingInt(osikatuBean::getPriority));
        } else {
            System.out.println("osi_id_list is empty or null.");
        }

        session.setAttribute("0_list",purchaseZeroList);
        session.setAttribute("1_list",purchaseOtherList);


    //    全部のservletに貼るコード

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

        String path = "/WEB-INF/view/GoodsFile/goods.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }
}