package com.example.fave.MypageFile;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.faveBean;
import utils.Bean.shiftBean;
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


// 更新処理
        utils.DAO.userDAO.updateAll(log_id, nick, saiosi, regimg, amounthand, living);

        user = utils.DAO.userDAO.selectById(log_id);
        session.setAttribute("user", user);
        int almosthand = user.getAmounthand();
        session.setAttribute("almosthand",almosthand);


// リダイレクト
        response.sendRedirect("MypageServlet");

    }
}



