package com.example.fave;

import java.io.*;
import java.util.ArrayList;
import java.util.Comparator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.*;
import utils.DAO.goodsDAO;
import utils.DAO.workDAO;

@WebServlet("/IndexServlet")
public class IndexServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // セッションを取得
        HttpSession session = request.getSession();

        // セッションからユーザー情報を取得
        userBean user = (userBean) session.getAttribute("user");

        String log_id;
        if (user != null) {
            // ユーザーのlog_idを取得
            log_id = user.getLog_id();

            ArrayList<faveBean> favelist = utils.DAO.faveDAO.selectFaveAll(log_id);
            session.setAttribute("favelist", favelist);

            ArrayList<Integer> osi_id = goodsDAO.selectOsikatu_id(log_id);
            // 商品情報を取得
            ArrayList<osikatuBean> goodsList = new ArrayList<>();
            for(int osi : osi_id) {
                ArrayList<osikatuBean> goods = goodsDAO.selectGoods(osi);
                goodsList.addAll(goods);
            }

            if(goodsList != null) {
                goodsList.sort(Comparator.comparing(osikatuBean::getPriority));
            }
            // 取得した商品情報をリクエストスコープにセット
            session.setAttribute("goodsList", goodsList);
            int sum = 0;

            for (osikatuBean good : goodsList) {
                if(good.getPurchase() != 1) {
                    sum = sum + good.getPrice();
                }
            }

            session.setAttribute("sum", sum);
        } else {
            // ユーザーがセッションにいない場合の処理（例: ログイン画面にリダイレクト）
            response.sendRedirect("/login.jsp");
            return;
        }
        // index.jsp に転送
        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
    }
}
