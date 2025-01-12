package com.example.fave.FaveFile.CateTag;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.userBean;

import static utils.DAO.tagDAO.editTag;

@WebServlet("/TagEditServlet")
public class TagEditServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        String tag = request.getParameter("tag");
        String tag_before = request.getParameter("tag_before");
        int cate_id = Integer.parseInt(request.getParameter("cate_id"));

        int tag_id = utils.DAO.tagDAO.selectTagByCategory(cate_id,tag_before);
        editTag(tag_id,tag);

        response.sendRedirect("relate");
    }
}



