package com.example.fave.GoodsFile;

import java.io.*;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.osikatuBean;
import utils.Bean.userBean;
import utils.DAO.goodsDAO;

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
        ArrayList<ArrayList<osikatuBean>> goodsList = new ArrayList<>();

        if (osi_id_list != null && !osi_id_list.isEmpty()) {
            for (int osi_id : osi_id_list) {
                // osi_id を使って osikatuBean を取得
                ArrayList<osikatuBean> bean = goodsDAO.selectOsikatuByOsi_id(osi_id);
                if (bean != null) {
                    goodsList.add(bean); // リストに追加
                }
            }
        } else {
            System.out.println("osi_id_list is empty or null.");
        }

        // goodsList を確認（デバッグ用）
        System.out.println("Retrieved goods: " + goodsList);





        String path = "/WEB-INF/view/GoodsFile/goods.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }
}