package com.example.fave.ShiftFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.userBean;
import utils.Bean.workBean;
import utils.DAO.workDAO;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/ShiftAddServlet")
public class ShiftAddServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<workBean> worklist = workDAO.selectAll(log_id);
        session.setAttribute("worklist",worklist);

        request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift_add.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);

    }
}



