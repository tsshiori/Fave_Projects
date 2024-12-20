package com.example.fave.FaveFile;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import utils.Bean.categoryBean;
import utils.Bean.faveBean;
import utils.Bean.userBean;
import utils.DAO.faveDAO;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

@WebServlet("/FaveAdd")
@MultipartConfig  // アップロードファイルの処理を有効化
public class FaveAddServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        ArrayList<categoryBean> categorylist = utils.DAO.categoryDAO.selectCategoryAll(log_id);
        session.setAttribute("categorylist", categorylist);

        String path = "/WEB-INF/view/FaveFile/fave_add.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        String name = request.getParameter("name");
        LocalDate birthday = null;
        if (request.getParameter("birthday") != null && !request.getParameter("birthday").isEmpty()) {
            birthday = LocalDate.parse(request.getParameter("birthday"));
        }
        String osimemo = request.getParameter("osimemo");
        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        int cate_id = Integer.parseInt(request.getParameter("cate_id"));

        Part filePart = request.getPart("img"); // フォームから送られてきたファイルを取得
        String fileName = extractFileName(filePart); // ファイル名を取得

        if (filePart != null && fileName != null) {
            // "static/faveImg" フォルダの絶対パスを取得
            String uploadDir = getServletContext().getRealPath("config/src/main/webapp/static/faveImg");

            // uploadDirにprefixを含んでいる場合、その部分を削除
            String prefix = "C:/Users/tsshi/IdeaProjects/glassfish/glassfish7/glassfish/domains/domain1/generated/jsp/Fave-1.0-SNAPSHOT/";
            String cleanedPath = uploadDir.replace(prefix, "");  // 不要な前半部分を削除

            // cleanedPathがすでに末尾にファイルパスを追加する準備ができているか確認
            if (!cleanedPath.endsWith(File.separator)) {
                cleanedPath += File.separator;  // 末尾にFile.separatorを追加
            }

            File cleanedDir = new File(cleanedPath);
            if (!cleanedDir.exists()) {
                cleanedDir.mkdirs(); // フォルダが存在しない場合は作成
            }

            // 正しいパスの結合を行う
            String filePath = cleanedPath + fileName;

            // ファイルを保存する
            filePart.write(filePath);

            // データベースにファイルのパスを保存する処理
            faveBean faveB = new faveBean(0, fileName, name, birthday, osimemo, log_id, cate_id); // DBに保存するファイル名
            faveDAO.addFave(faveB);
        }

        // 処理が完了した後、遷移するページ
        String path = "/WEB-INF/view/FaveFile/fave.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    // ファイル名を取得するヘルパーメソッド
    private String extractFileName(Part part) {
        String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }
}
