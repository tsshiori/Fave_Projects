<%--
  Created by IntelliJ IDEA.
  User: wrwr0
  Date: 2024/11/27
  Time: 9:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMessage = "";
    if (errorMessage != null){
        
    }
%>
<html>
<head>
    <title>エラー</title>
</head>
<body>
DAOエラー確認用
<% if (!errorMessage.isEmpty()) { %>
<p style="color: red;"><%= errorMessage %></p>
<% } %>
</body>
</html>
