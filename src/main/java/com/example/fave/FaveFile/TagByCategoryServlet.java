package com.example.fave.FaveFile;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.DAO.tagDAO;

import com.google.gson.Gson;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet("/TagByCategoryServlet")
public class TagByCategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");

        // リクエストパラメータから cate_id を取得
        String cateIdParam = request.getParameter("cate_id");
        Map<Integer, String> tags = new HashMap<>();

        if (cateIdParam != null) {
            try {
                int cate_id = Integer.parseInt(cateIdParam);
                // DAOを呼び出してタグを取得
                tags = tagDAO.selectTagsByCategory(cate_id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // JSON形式で返す
        List<Map.Entry<Integer, String>> tagList = new ArrayList<>(tags.entrySet());
        Gson gson = new Gson();
        String json = gson.toJson(tagList);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}