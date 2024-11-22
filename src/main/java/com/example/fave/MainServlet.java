package com.example.fave;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.DAO.GenerateHash;
import utils.Bean.userBean;

import java.io.IOException;

public class MainServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

                HttpSession session = request.getSession();
                request.setCharacterEncoding("utf-8");
                int log_id = Integer.parseInt(request.getParameter("log_id"));
                String password = request.getParameter("password");
                utils.Bean.userBean user = utils.DAO.userDAO.selectById(log_id);

                if ( GenerateHash.checkPassword(password, user.getPassword()) ) {
                        session.setAttribute("log_id",user.getLog_id());
                        session.setAttribute("password", user.getPassword());

                        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);

                } else {
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);

                }

        }
}

