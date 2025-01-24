package com.example.fave.GoodsFile;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.userBean;

@WebServlet("/BuyBoughtServlet")
public class BuyBoughtServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
            response.setContentType("text/html; charset=UTF-8");
            request.setCharacterEncoding("UTF-8");
            HttpSession session = request.getSession();

            userBean user = (userBean) session.getAttribute("user");
            String log_id = user.getLog_id();

            int osikatu_id = Integer.parseInt(request.getParameter("osikatu_id"));
            utils.DAO.goodsDAO.changeBuyBought(osikatu_id);

            response.sendRedirect("goods");

    }
}



