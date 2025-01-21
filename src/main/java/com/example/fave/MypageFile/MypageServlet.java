package com.example.fave.MypageFile;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.categoryBean;
import utils.Bean.faveBean;
import utils.Bean.userBean;
import utils.DAO.faveDAO;
import utils.DAO.userDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/MypageServlet")
public class MypageServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<faveBean> favelist = faveDAO.selectFaveAll(log_id);
        session.setAttribute("favelist",favelist);

        Map<Integer,Integer> osiout = utils.DAO.faveDAO.selectPrice(log_id);
        session.setAttribute("osiout", osiout);

        ArrayList<categoryBean> categorylist = utils.DAO.categoryDAO.selectCategoryAll(log_id);
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

        String path = "/WEB-INF/view/MypageFile/mypage.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }
}
