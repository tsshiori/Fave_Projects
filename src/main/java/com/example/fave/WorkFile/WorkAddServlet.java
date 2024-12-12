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

@WebServlet("/WorkAddServlet")
public class WorkAddServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_add.jsp").forward(request, response);
        }

        public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/UTF-8");
                HttpSession session = request.getSession();

                int work_id = -1;
                int hourlywage = Integer.parseInt(request.getParameter("hourlywage"));
                String work = request.getParameter("work");
                String mainworkParam = request.getParameter("mainwork");
                int mainwork = (mainworkParam != null) ? 1 : 0;
                userBean user = (userBean) session.getAttribute("user");
                String log_id = user.getLog_id();

                ArrayList<workBean> worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                // work の一致を確認するフラグ
                boolean isDuplicate = false;

                if (worklist == null) {
                        session.setAttribute("errorMessage", "データベースから情報を取得できませんでした。管理者にお問い合わせください。");
                        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
                        return;
                }


                // ループで一致確認
                for (workBean wb : worklist) {
                        if (wb.getWork().equals(work)) { // work が一致しているか確認
                                isDuplicate = true;
                                break; // 一致が見つかった時点で終了
                        }
                }

                if(isDuplicate){
                        request.setAttribute("errorMessage", "既に存在するバイト名です。");
                        request.getRequestDispatcher("/WEB-INF/view/WorkFile/work_add.jsp").forward(request, response);
                }else {
                        utils.DAO.workDAO.insertWork(work_id, hourlywage, work, log_id);
                        worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                        if(mainwork == 1){
                                work_id = utils.DAO.workDAO.selectNameWork(log_id,work);
                                utils.DAO.userDAO.updateMainWork(work_id,log_id);
                                user = utils.DAO.userDAO.selectById(log_id);
                                session.setAttribute("user", user);
                        }
                }



                worklist = utils.DAO.workDAO.selectWorkAll(log_id);
                session.setAttribute("worklist",worklist);

                request.getRequestDispatcher("/WEB-INF/view/WorkFile/work.jsp").forward(request, response);
        }
}



