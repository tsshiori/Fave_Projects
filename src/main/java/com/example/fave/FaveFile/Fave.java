package com.example.fave.FaveFile;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.*;
import utils.DAO.goodsDAO;

@WebServlet("/Fave")
public class Fave extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<faveBean> favelist = utils.DAO.faveDAO.selectFaveAll(log_id);
        session.setAttribute("favelist", favelist);

        Map<Integer,Integer> osiout = utils.DAO.faveDAO.selectPrice(log_id);
        session.setAttribute("osiout", osiout);

        ArrayList<categoryBean> categorylist = utils.DAO.categoryDAO.selectCategoryAll(log_id);
        session.setAttribute("categorylist", categorylist);

        String uploadDirPath = getServletContext().getRealPath("") + File.separator + "faveImg";
        session.setAttribute("Path", uploadDirPath);

        Map<Integer, String> ositaglist = new HashMap<>(); // Mapの初期化


        if (favelist != null) {
            for (faveBean fave : favelist) {
                // faveBeanからosi_idを取得
                int osi_id = fave.getOsi_id(); // 仮メソッド名：getOsi_id()

                // osi_id に対応するタグを取得
                String tag = utils.DAO.tagDAO.selectTag(osi_id); // selectTag(int osi_id) がタグを返すと仮定
                if (tag != null) {
                    // osi_id と対応するタグを Map に追加
                    ositaglist.put(osi_id, tag);
                }
            }
        }
        session.setAttribute("ositaglist", ositaglist);

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

        if (user != null) {
            // ユーザーのlog_idを取得
            log_id = user.getLog_id();

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
        String path = "/WEB-INF/view/FaveFile/fave.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }
}