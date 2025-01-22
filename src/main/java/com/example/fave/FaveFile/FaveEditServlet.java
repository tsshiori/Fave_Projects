package com.example.fave.FaveFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.Bean.categoryBean;
import utils.Bean.faveBean;
import utils.Bean.tagBean;
import utils.Bean.userBean;
import utils.DAO.categoryDAO;
import utils.DAO.faveDAO;
import utils.DAO.tagDAO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Objects;

@MultipartConfig
@WebServlet("/FaveEdit")
public class FaveEditServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String idParam = request.getParameter("osi_id");
        int osi_id = Integer.parseInt(idParam);
        session.setAttribute("osi_id",osi_id);


        faveBean fave = faveDAO.getFaveByOsi_id(osi_id);
        session.setAttribute("fave", fave);

        int cate_id = fave.getCate_id();
        categoryBean category = categoryDAO.selectCategory(cate_id);
        session.setAttribute("category", category);

        ArrayList<tagBean> tags = tagDAO.selectTags(osi_id);
        if (tags != null && !tags.isEmpty()) {
            tags.sort(Comparator.comparing(tagBean::getTag)); // タグを昇順にソート
            request.setAttribute("tags", tags); // JSP に渡す
        }

        request.getRequestDispatcher("/WEB-INF/view/FaveFile/fave_edit.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();


        int osi_id = Integer.parseInt(request.getParameter("osi_id"));

        String fileName = "";
        Part filePart = request.getPart("img"); // "img" は <input name="img"> に対応
        // システムの環境変数やプロパティファイルを使って絶対パスを指定
        if(filePart == null || filePart.getSize() == 0 || filePart.getSubmittedFileName() == null){
            fileName = request.getParameter("null_ver_img");
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


        String osimemo = request.getParameter("memo");
        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
        int cate_id = Integer.parseInt(request.getParameter("cate_id"));

        faveBean faveB = new faveBean(osi_id, fileName, name, birthday, osimemo, log_id, cate_id);
        faveDAO.updateFave(faveB);
        tagDAO.delTag(osi_id);


        for (int i = 1; i <= 5; i++) {
            String tagParam = request.getParameter("tab" + i);
            if (tagParam != null && !tagParam.isEmpty() && !tagParam.equals("1")) {
                int tag = Integer.parseInt(tagParam);
                tagDAO.insertOsiTag(osi_id, tag);
            }
        }

        // 処理が完了した後、遷移するページ
        response.sendRedirect("Fave");

    }
}