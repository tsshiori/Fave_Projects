package com.example.fave.WorkFile;

import java.io.*;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.userBean;
import utils.Bean.workBean;
import utils.DAO.workDAO;

@WebServlet("/WorkDeleteServlet")
public class WorkDeleteServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/view/WorkFile/work.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/UTF-8");
        HttpSession session = request.getSession();

        int work_id = Integer.parseInt(request.getParameter("work_id"));
        utils.DAO.workDAO.deleteWork(work_id);

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<workBean> worklist = workDAO.selectWorkAll(log_id);
        session.setAttribute("worklist",worklist);

        response.sendRedirect("WorkServlet");
    }
}



