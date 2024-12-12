package com.example.fave.WorkFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.userBean;
import utils.Bean.workBean;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/WorkEditServlet")
public class WorkEditServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_edit.jsp").forward(request, response);
        }

        public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/UTF-8");
                HttpSession session = request.getSession();

                userBean user = (userBean) session.getAttribute("user");
                String log_id = user.getLog_id();

                int work_id = Integer.parseInt(request.getParameter("work_id"));
                String work = request.getParameter("work");
                int hourlywage = Integer.parseInt(request.getParameter("hourlywage"));

                boolean mainwork = false;
                String mainworkParam = request.getParameter("main");
                if (mainworkParam != null && mainworkParam.equals("on")) {
                        mainwork = true;
                }

                utils.DAO.workDAO.editWork(work_id,hourlywage,work,mainwork,log_id);
                user = utils.DAO.userDAO.selectById(log_id);
                session.setAttribute("user", user);
                ArrayList<workBean> worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                session.setAttribute("worklist",worklist);


                request.getRequestDispatcher("/WEB-INF/view/WorkFile/work.jsp").forward(request, response);
        }
}



