package com.example.fave.GoodsFile;

import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.faveBean;
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
                errors.add("購入金額の形式が正しくありません。");
            }
        } else {
            purchase = 0; // purchaseがnullまたは空の場合、0に設定
        }

        // memoのnullチェック（memoはString型なので空文字やnullを許容）
        String memo = request.getParameter("memo");
        if (memo == null) {
            memo = ""; // nullの場合は空文字にする
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

        int priority = 0;
        String priorityString = request.getParameter("priority");
        if (priorityString != null && !priorityString.trim().isEmpty()) {
            try {
                priority = Integer.parseInt(priorityString);
            } catch (NumberFormatException e) {
                errors.add("優先度の形式が正しくありません。");
            }
        }

        // itemtype（0:グッズ, 1:イベント）を取得
        int itemType = request.getParameter("itemtype") != null ? 1 : 0;

        // エラーがある場合は元のページに戻る
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/GoodsFile/goods_add.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // データベースに登録
        goodsDAO dao = new goodsDAO();
        dao.insertGoods(day, price, item, purchase, osiId, priority, memo, itemType);

        // 処理後のリダイレクト
        response.sendRedirect("fave");
    }
}
