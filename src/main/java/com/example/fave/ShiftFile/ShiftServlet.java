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
import utils.DAO.shiftDAO;

@WebServlet("/ShiftServlet")
public class ShiftServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        if (log_id == null) {
            response.sendRedirect("login"); // ログインしていない場合はログインページへリダイレクト
            return;
        }

        // シフトデータを取得
        ArrayList<shiftBean> shiftList = null;
        try {
            shiftList = shiftDAO.selectShiftAll(log_id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // シフトデータをリクエスト属性にセット
        session.setAttribute("shiftList", shiftList);

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

        // JSP にフォワード
        request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift.jsp").forward(request, response);
    }
}



