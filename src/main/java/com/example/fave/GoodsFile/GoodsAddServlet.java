package com.example.fave.GoodsFile;

import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.faveBean;
import utils.Bean.shiftBean;
import utils.Bean.userBean;
import utils.DAO.goodsDAO;

@WebServlet("/GoodsAdd")
public class GoodsAddServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        ArrayList<faveBean> favelist = utils.DAO.faveDAO.selectFaveAll(log_id);
        session.setAttribute("favelist", favelist);

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
        session.setAttribute("futureWage",totalhand);
        session.setAttribute("almosthand",almosthand);


        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods_add.jsp");
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // セッションからユーザー情報を取得
        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        // リクエストパラメータを取得
        LocalDate day = null;
        try {
            // 日付のパースエラー処理
            day = LocalDate.parse(request.getParameter("day"));
        } catch (Exception e) {
            // 日付が正しくない場合、エラーメッセージを表示して処理を中断
            request.setAttribute("errorMessage", "日付の形式が正しくありません。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/error.jsp");
            dispatcher.forward(request, response);
            return; // 処理を中断
        }

        // 価格と商品名を取得
        int price = Integer.parseInt(request.getParameter("price"));
        String item = request.getParameter("item");

        // purchaseパラメータの取得
        String pur_before = request.getParameter("purchase");

        // null または空文字の場合は 0 を設定
        int purchase = 0;
        if (pur_before != null && !pur_before.trim().isEmpty()) {
            try {
                purchase = Integer.parseInt(pur_before);
            } catch (NumberFormatException e) {
                // 購入金額のパースエラーが発生した場合、エラーメッセージを設定
                request.setAttribute("errorMessage", "購入金額の形式が正しくありません。");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/error.jsp");
                dispatcher.forward(request, response);
                return; // 処理を中断
            }
        }

        // その他のパラメータを取得
        int osiId = Integer.parseInt(request.getParameter("osi_id"));
        int priority = Integer.parseInt(request.getParameter("priority"));
        String memo = request.getParameter("memo");

        // 購入済チェックボックスの判定
        int itemType = request.getParameter("itemtype") != null ? 1 : 0;


            // goodsDAOを使用してデータベースに登録
            goodsDAO dao = new goodsDAO();
            dao.insertGoods(day, price, item, purchase, osiId, priority, memo, itemType);

            // 処理後、リダイレクト先を設定
            response.sendRedirect("goods_add"); // リダイレクト先を設定
            return; // リダイレクト後のコードは実行されない

    }

}