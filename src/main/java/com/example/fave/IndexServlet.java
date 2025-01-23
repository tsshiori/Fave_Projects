package com.example.fave;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDateTime;
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

            ArrayList<shiftBean> shiftFuture = null;
            int futureWage = 0;

            try {
                shiftFuture = utils.DAO.shiftDAO.selectShiftAllFuture(log_id);


                for (shiftBean shift : shiftFuture) {
                    LocalDateTime startdatetime = shift.getStartdatetime();
                    LocalDateTime enddatetime = shift.getEnddatetime();
                    int work_id = shift.getWork_id();
                    int breaktime = shift.getBreaktime();
                    int wage = shift.getWage();

                    int addWage = utils.DAO.amounthandDAO.futureWage(startdatetime,enddatetime,work_id,breaktime,wage,log_id);
                    futureWage += addWage;
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }


            int almosthand = user.getAmounthand();
            int totalhand = almosthand + futureWage;
            request.setAttribute("futureWage",totalhand);
            request.setAttribute("almosthand",almosthand);

            workBean mainwork = workDAO.selectWork(user.getMainwork());
            session.setAttribute("mainwork", mainwork);
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

