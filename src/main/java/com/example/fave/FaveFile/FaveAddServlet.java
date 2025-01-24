package com.example.fave.FaveFile;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.Bean.categoryBean;
import utils.Bean.faveBean;
import utils.Bean.osikatuBean;
import utils.Bean.userBean;
import utils.DAO.faveDAO;
import utils.DAO.goodsDAO;
import utils.DAO.tagDAO;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.ArrayList;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Comparator;

@MultipartConfig
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

        }

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

        Part filePart = request.getPart("img"); // "img" は <input name="img"> に対応
        String fileName = "";
        // システムの環境変数やプロパティファイルを使って絶対パスを指定
        if(filePart == null || filePart.getSize() == 0 || filePart.getSubmittedFileName() == null){
            fileName = "def.png";
        } else {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            long filesize = filePart.getSize();
            byte[] data = new byte[(int) filesize];
            Files.copy(filePart.getInputStream(), new File(getServletContext().getRealPath("/static/faveImg") + File.separator + fileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        String name = request.getParameter("name");

        // birthday が空文字の場合は null を設定
        String birthdayParam = request.getParameter("birthday");
        LocalDate birthday = null;
        if (birthdayParam != null && !birthdayParam.isEmpty()) {
            birthday = LocalDate.parse(birthdayParam);
        }


        String osimemo = request.getParameter("osimemo");
        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        int cate_id = Integer.parseInt(request.getParameter("cate_id"));

        faveBean faveB = new faveBean(osi_id, fileName, name, birthday, osimemo, log_id, cate_id);
        int osi_id2 = faveDAO.addFave(faveB);


        for (int i = 1; i <= 5; i++) {
            int tab = 0;
            if (request.getParameter("tab" + i) == null || request.getParameter("tab" + i).isEmpty()){
                tab = 1;
            }
            if(tab != 1) {
                tagDAO.insertOsiTag(osi_id2, tab);
            }
        }

        // 処理が完了した後、遷移するページ
        response.sendRedirect("Fave");
    }


}