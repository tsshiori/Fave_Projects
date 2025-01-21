package com.example.fave.WorkFile;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.shiftBean;
import utils.Bean.userBean;
import utils.Bean.workBean;
import utils.DAO.workDAO;

@WebServlet("/WorkServlet")
public class WorkServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/Utf-8");
                HttpSession session = request.getSession();

                userBean user = (userBean) session.getAttribute("user");
                String log_id = user.getLog_id();
                ArrayList<workBean> worklist = workDAO.selectWorkAll(log_id);
                session.setAttribute("worklist",worklist);

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

                request.getRequestDispatcher("/WEB-INF/view/WorkFile/work.jsp").forward(request, response);
        }
}



