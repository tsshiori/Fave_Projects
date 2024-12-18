package com.example.fave.ShiftFile;

import java.io.*;
import java.sql.SQLException;
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

        // JSP にフォワード
        request.getRequestDispatcher("/WEB-INF/view/ShiftFile/shift.jsp").forward(request, response);
    }
}



