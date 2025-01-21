package com.example.fave.FaveFile.CateTag;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.Bean.userBean;

@WebServlet("/TagDeleteServlet")
public class TagDeleteServlet extends HttpServlet {
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
        int cate_id = Integer.parseInt(request.getParameter("cate_id"));

        int tag_id = utils.DAO.tagDAO.selectTagByCategory(cate_id,tag);
        utils.DAO.tagDAO.deleteTag(tag_id);

        response.sendRedirect("relate");
    }
}



