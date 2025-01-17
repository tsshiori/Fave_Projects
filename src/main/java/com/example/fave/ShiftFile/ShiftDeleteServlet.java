package com.example.fave.ShiftFile;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.shiftBean;
import utils.Bean.userBean;

@WebServlet("/ShiftDeleteServlet")
public class ShiftDeleteServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift_edit.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        int shift_id = Integer.parseInt(request.getParameter("shift_id"));
        shiftBean shift = null;


        try {
            shift = utils.DAO.shiftDAO.selectShiftShiftId(shift_id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        LocalDateTime startdatetime = shift.getStartdatetime();
        LocalDateTime enddatetime = shift.getEnddatetime();
        int work_id = shift.getWork_id();
        int breaktime = shift.getBreaktime();
        int wage = shift.getWage();

        int amounthand = user.getAmounthand();
        utils.DAO.amounthandDAO.deleteADayWage(startdatetime, enddatetime, work_id, breaktime, wage, log_id, amounthand);
        user = utils.DAO.userDAO.selectById(log_id);
        session.setAttribute("user",user);

        utils.DAO.shiftDAO.deleteShift(shift_id);


        ArrayList<shiftBean> shiftFuture = null;
        int futureWage = 0;

        try {
            shiftFuture = utils.DAO.shiftDAO.selectShiftAllFuture(log_id);


            for (shiftBean shift2 : shiftFuture) {
                LocalDateTime startdatetime2 = shift2.getStartdatetime();
                LocalDateTime enddatetime2 = shift2.getEnddatetime();
                int work_id2 = shift2.getWork_id();
                int breaktime2 = shift2.getBreaktime();
                int wage2 = shift2.getWage();

                int addWage = utils.DAO.amounthandDAO.futureWage(startdatetime2,enddatetime2,work_id2,breaktime2,wage2,log_id);
                futureWage += addWage;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        session.setAttribute("futureWage",futureWage);



        response.sendRedirect("ShiftServlet");

    }
}



