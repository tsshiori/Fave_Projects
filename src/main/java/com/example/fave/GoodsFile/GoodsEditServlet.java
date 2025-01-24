package com.example.fave.GoodsFile;

import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.goodsBean;
import utils.Bean.osikatuBean;
import utils.Bean.userBean;
import utils.Bean.workBean;
import utils.DAO.goodsDAO;


public class GoodsEditServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = "/WEB-INF/view/GoodsFile/goods_edit.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
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