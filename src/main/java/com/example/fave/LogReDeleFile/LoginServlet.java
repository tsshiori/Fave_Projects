package com.example.fave.LogReDeleFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.*;
import utils.DAO.GenerateHash;
import utils.DAO.goodsDAO;
import utils.DAO.workDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;

public class LoginServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                HttpSession session = request.getSession();
                request.setCharacterEncoding("utf-8");
                response.setContentType("text/UTF-8");

                // フォームデータの取得
                String log_id = request.getParameter("log_id");
                userBean user = utils.DAO.userDAO.selectById(log_id);

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
                session.setAttribute("futureWage",futureWage);

                request.setAttribute("errorMessage", "ログインIDまたはパスワードが入力されていません。");
                request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                HttpSession session = request.getSession();
                request.setCharacterEncoding("utf-8");
                response.setContentType("text/UTF-8");

                // フォームデータの取得
                String log_id = request.getParameter("log_id");
                String password = request.getParameter("password");

                System.out.println("Received log_id: " + log_id);
                System.out.println("Received password: " + password);

                // 入力値の検証
                if (log_id == null || log_id.isEmpty() || password == null || password.isEmpty()) {
                        System.out.println("Error: ログインIDまたはパスワードが未入力");
                        request.setAttribute("errorMessage", "ログインIDまたはパスワードが入力されていません。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                        return;
                }

                // ユーザー情報の取得
                utils.Bean.userBean user = utils.DAO.userDAO.selectById(log_id);
                System.out.println("User retrieved: " + user);

                if (user == null) {
                        System.out.println("Error: 該当するユーザーが見つかりません -> log_id: " + log_id);
                        request.setAttribute("errorMessage", "該当するユーザーが見つかりません。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                        return;
                }

                System.out.println("Checking password for user: " + user.getLog_id());

                // ユーザー情報を取得した後
                if (GenerateHash.checkPassword(password, user.getPassword())) {
                        System.out.println("Login successful for user: " + user.getLog_id());
                        session.setAttribute("user", user);


                        if (user != null) {
                                // ユーザーのlog_idを取得
                                log_id = user.getLog_id();

                                ArrayList<faveBean> favelist = utils.DAO.faveDAO.selectFaveAll(log_id);
                                session.setAttribute("favelist", favelist);

                                ArrayList<Integer> osi_id = goodsDAO.selectOsikatu_id(log_id);
                                // 商品情報を取得
                                ArrayList<osikatuBean> goodsList = new ArrayList<>();
                                for (int osi : osi_id) {
                                        ArrayList<osikatuBean> goods = goodsDAO.selectGoods(osi);
                                        goodsList.addAll(goods);
                                }

                                if (goodsList != null) {
                                        goodsList.sort(Comparator.comparing(osikatuBean::getPriority));
                                }
                                // 取得した商品情報をリクエストスコープにセット
                                session.setAttribute("goodsList", goodsList);
                                int sum = 0;

                                for (osikatuBean good : goodsList) {
                                        if (good.getPurchase() != 1) {
                                                sum = sum + good.getPrice();
                                        }
                                }

                                session.setAttribute("sum", sum);

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

                                                int addWage = utils.DAO.amounthandDAO.futureWage(startdatetime, enddatetime, work_id, breaktime, wage, log_id);
                                                futureWage += addWage;
                                        }

                                } catch (SQLException e) {
                                        throw new RuntimeException(e);
                                }


                                int almosthand = user.getAmounthand();
                                int totalhand = almosthand + futureWage;
                                session.setAttribute("futureWage", totalhand);
                                session.setAttribute("almosthand", almosthand);

                                workBean mainwork = workDAO.selectWork(user.getMainwork());
                                if (mainwork == null) {
                                        // デフォルトの workBean を作成
                                        mainwork = new workBean(-1, 1, "null", log_id);

                                }
                                session.setAttribute("mainwork", mainwork);
                        }

                        // ログイン後のページへリダイレクト
                        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
                } else {
                        System.out.println("Error: パスワードが間違っています -> log_id: " + log_id);
                        request.setAttribute("errorMessage", "パスワードが間違っています。");
                        request.getRequestDispatcher("/WEB-INF/view/LogReDeleFile/login.jsp").forward(request, response);
                }
        }
}
