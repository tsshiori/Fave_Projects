package com.example.fave.FaveFile;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.categoryBean;
import utils.Bean.faveBean;
import utils.Bean.shiftBean;
import utils.Bean.userBean;

@WebServlet("/Relate")
public class RelateServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        ArrayList<faveBean> favelist = utils.DAO.faveDAO.selectFaveAll(log_id);
        session.setAttribute("favelist", favelist);

        ArrayList<categoryBean> categorylist = utils.DAO.categoryDAO.selectCategory(log_id);
        session.setAttribute("categorylist", categorylist);

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

        Map<Integer, List<String>> categoryTagMap = new HashMap<>(); // カテゴリーIDをキーとするMap

        if (categorylist != null) {
            for (categoryBean category : categorylist) {
                int cate_id = category.getCate_id(); // categoryBeanにgetCate_id()があると仮定

                // カテゴリーIDに関連するタグリストを取得
                List<String> tags = utils.DAO.tagDAO.selectTagsByCategory(cate_id);

                // Mapに追加
                categoryTagMap.put(cate_id, tags);
            }
        }

// Mapをセッションに保存
        session.setAttribute("categoryTagMap", categoryTagMap);

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

        request.getRequestDispatcher("/WEB-INF/view/FaveFile/relate.jsp").forward(request, response);
    }
}