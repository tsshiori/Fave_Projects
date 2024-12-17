package com.example.fave.FaveFile;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.Bean.categoryBean;
import utils.Bean.faveBean;
import utils.Bean.userBean;
import utils.Bean.workBean;
import utils.DAO.faveDAO;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

@WebServlet("/FaveAdd")
public class FaveAddServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<categoryBean> categorylist = utils.DAO.categoryDAO.selectCategoryAll(log_id);
        session.setAttribute("categorylist",categorylist);
        

        String path = "/WEB-INF/view/FaveFile/fave_add.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // パラメータ受け取り
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        int osi_id = 0;
        String img = request.getParameter("img");  // 画像名だけ取得
        String name = request.getParameter("name");
        LocalDate birthday = null;

        // birthday が空文字の場合は null を設定
        if (request.getParameter("birthday") != null && !request.getParameter("birthday").isEmpty()) {
            birthday = LocalDate.parse(request.getParameter("birthday"));
        }

        String osimemo = request.getParameter("osimemo");
        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        int cate_id = Integer.parseInt(request.getParameter("cate_id"));

        // 名前の重複チェック
        ArrayList<String> result = faveDAO.selectByLog_id(log_id);
        for (int i = 0; i < result.size(); i++) {
            String result_name = result.get(i);
            if (name != null && name.equals(result_name)) {
                // name と result_name が同じならエラー処理
                System.out.println("エラー: 名前が重複しています！");
                // 必要に応じて例外をスローすることもできます
                throw new RuntimeException("名前が重複しています");
            } else {
                // 重複しない場合、データを登録
                faveBean faveB = new faveBean(osi_id, img, name, birthday, osimemo, log_id, cate_id);

                // 登録処理
                faveDAO.addFave(faveB);
            }
        }

        // 処理が完了した後、遷移するページ
        String path = "/WEB-INF/view/FaveFile/fave.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    // 数値をパースする際に null または空文字を処理するヘルパーメソッド
    private int parseInteger(String parameter) {
        if (parameter == null || parameter.isEmpty()) {
            return 0; // デフォルト値として 0 を設定
        }
        try {
            return Integer.parseInt(parameter);
        } catch (NumberFormatException e) {
            return 0; // 数値として不正な場合も 0 を返す
        }
    }
}
