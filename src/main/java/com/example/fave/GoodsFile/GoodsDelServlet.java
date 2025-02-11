package com.example.fave.GoodsFile;

import java.io.*;
import java.util.ArrayList;
import java.util.Comparator;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import utils.Bean.faveBean;
import utils.Bean.osikatuBean;
import utils.Bean.userBean;

import utils.DAO.goodsDAO;

@WebServlet("/GoodsDelServlet")
public class GoodsDelServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8;"); //レスポンスデータ


        // セッションを取得
        HttpSession session = request.getSession();

        // セッションからユーザー情報を取得
        userBean user = (userBean) session.getAttribute("user");

        String log_id;
       // 全部のservletに貼るコード

         if (user != null) {
            // ユーザーのlog_idを取得
            log_id = user.getLog_id();

            int osikatu_id = Integer.parseInt(request.getParameter("goods_id"));
            goodsDAO.goodsDel(osikatu_id);

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

        response.sendRedirect("fave");

    }
}
