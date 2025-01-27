package com.example.fave.GoodsFile;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.faveBean;
import utils.Bean.osikatuBean;
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

                int addWage = utils.DAO.amounthandDAO.futureWage(startdatetime, enddatetime, work_id, breaktime, wage, log_id);
                futureWage += addWage;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        int almosthand = user.getAmounthand();
        int totalhand = almosthand + futureWage;
        session.setAttribute("futureWage", totalhand);
        session.setAttribute("almosthand", almosthand);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods_add.jsp");
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        List<String> errors = new ArrayList<>();

        // 日付のバリデーション
        LocalDate day = null;
        try {
            day = LocalDate.parse(request.getParameter("day"));
        } catch (Exception e) {
            errors.add("日付の形式が正しくありません。");
        }

        // 価格のバリデーション
        int price = 0;
        String priceString = request.getParameter("price");
        if (priceString != null && !priceString.trim().isEmpty()) {
            try {
                price = Integer.parseInt(priceString);
            } catch (NumberFormatException e) {
                errors.add("金額の形式が正しくありません。");
            }
        } else {
            errors.add("金額を入力してください。");
        }

        // 商品名のバリデーション
        String item = request.getParameter("item");
        if (item == null || item.trim().isEmpty()) {
            errors.add("商品名を入力してください。");
        }

        // purchaseパラメータのバリデーション
        int purchase = 0;
        String purBefore = request.getParameter("purchase");
        if (purBefore != null && !purBefore.trim().isEmpty()) {
            try {
                purchase = Integer.parseInt(purBefore);
            } catch (NumberFormatException e) {
                errors.add("参加形式が正しくありません。");
            }
        } else {
            purchase = 0; // purchaseがnullまたは空の場合、0に設定
        }

        // memoのnullチェック（memoはString型なので空文字やnullを許容）
        String memo = request.getParameter("memo");
        if (memo == null) {
            memo = ""; // nullの場合は空文字にする
        }

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

        // エラーがある場合は元のページに戻る
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods_add.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // その他のパラメータを取得
        int osiId = 0;
        String osiIdString = request.getParameter("osi_id");
        if (osiIdString != null && !osiIdString.trim().isEmpty()) {
            try {
                osiId = Integer.parseInt(osiIdString);
            } catch (NumberFormatException e) {
                errors.add("OSI IDの形式が正しくありません。");
            }
        }


        String formType = request.getParameter("formType");

// formTypeがnullでないか確認
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

                // エラーがある場合は元のページに戻る
                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods_add.jsp");
                    dispatcher.forward(request, response);
                    return;
                }

                // データベースに登録
                goodsDAO dao = new goodsDAO();
                dao.insertGoods(day, price, item, purchase, osiId, goodsicon, memo, itemType);

                // 処理後のリダイレクト
                response.sendRedirect("fave");

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

                // エラーがある場合は元のページに戻る
                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/EventFile/event_add.jsp");
                    dispatcher.forward(request, response);
                    return;
                }

                // データベースに登録
                goodsDAO dao = new goodsDAO();
                dao.insertGoods(day, price, item, purchase, osiId, eventicon, memo, itemType);


                // 全部のservletに貼るコード

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

                // 処理後のリダイレクト
                response.sendRedirect("fave");
            }
        }
    }
}
