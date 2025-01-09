package com.example.fave.MypageFile;

import java.io.*;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.faveBean;
import utils.Bean.userBean;
import utils.DAO.faveDAO;

@WebServlet("/MypageEditServlet")
public class MypageEditServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<faveBean> favelist = faveDAO.selectFaveAll(log_id);
        session.setAttribute("favelist",favelist);


        String path = "/WEB-INF/view/MypageFile/mypage_edit.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

// パラメータ取得
        String nick = request.getParameter("nick") != null ? request.getParameter("nick") : user.getNick();

        String saiosiParam = request.getParameter("saiosi");
        int saiosi = (saiosiParam != null && !saiosiParam.isEmpty()) ? Integer.parseInt(saiosiParam) : user.getSaiosi();

        String regimgParam = request.getParameter("regimg");
        int regimg = (regimgParam != null && !regimgParam.isEmpty()) ? Integer.parseInt(regimgParam) : user.getRegimg();

        String amounthandParam = request.getParameter("amount");
        int amounthand = (amounthandParam != null && !amounthandParam.isEmpty()) ? Integer.parseInt(amounthandParam) : user.getAmounthand();

        String livingParam = request.getParameter("living");
        int living = (livingParam != null && !livingParam.isEmpty()) ? Integer.parseInt(livingParam) : user.getLiving();

// デバッグログ（必要に応じて確認用）
        System.out.println("Updated nick: " + nick);
        System.out.println("Updated saiosi: " + saiosi);
        System.out.println("Updated regimg: " + regimg);
        System.out.println("Updated amounthand: " + amounthand);
        System.out.println("Updated living: " + living);

// 更新処理
        utils.DAO.userDAO.updateAll(log_id, nick, saiosi, regimg, amounthand, living);

// セッションの更新
        user.setNick(nick);
        user.setSaiosi(saiosi);
        user.setRegimg(regimg);
        user.setAmounthand(amounthand);
        user.setLiving(living);
        session.setAttribute("user", user);

// リダイレクト
        response.sendRedirect("MypageServlet");

    }
}



