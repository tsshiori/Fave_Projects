package com.example.fave.FaveFile;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.*;
import utils.DAO.faveDAO;
import utils.DAO.categoryDAO;
import utils.DAO.tagDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Map;

@WebServlet("/FaveDetail")
public class FaveDetailServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        String idParam = request.getParameter("osi_id");
        int osi_id = Integer.parseInt(idParam);

        faveBean fave = faveDAO.getFaveByOsi_id(osi_id);
        session.setAttribute("fave", fave);

        int cate_id = fave.getCate_id();
        categoryBean category = categoryDAO.selectCategory(cate_id);
        session.setAttribute("category", category);

        ArrayList<tagBean> tags = tagDAO.selectTags(osi_id);
        if (tags != null && !tags.isEmpty()) {
            tags.sort(Comparator.comparing(tagBean::getTag)); // タグを昇順にソート
            request.setAttribute("tags", tags); // JSP に渡す
        }
//        session.setAttribute("tags",tags);

        Map<Integer,Integer> osiprice = utils.DAO.faveDAO.selectPriceByosi_id(osi_id);
        session.setAttribute("osiprice", osiprice);

        ArrayList<osikatuBean> goodslist = utils.DAO.goodsDAO.selectOsikatuByOsi_id(osi_id);
        session.setAttribute("goodslist",goodslist);

        String path = "/WEB-INF/view/FaveFile/fave_detail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }
}