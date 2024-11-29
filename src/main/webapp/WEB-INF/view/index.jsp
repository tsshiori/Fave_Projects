<%@ page import="utils.Bean.userBean" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<%
    // セッションからuserBeanオブジェクトを取得
    userBean user = (userBean) session.getAttribute("user");

    String nick = "ゲスト"; // デフォルトのnickを設定
    String errorMessage = ""; // エラーメッセージ用の変数

    if (user != null) {
        // userがnullでない場合、nickを取得
        nick = user.getNick();
    } else {
        // userがnullの場合はエラーメッセージをセット
        errorMessage = "ユーザー情報がセッションに存在しません。再度ログインしてください。";
    }
%>

<%-- エラーメッセージが存在すれば表示 --%>
<% if (!errorMessage.isEmpty()) { %>
<p style="color: red;"><%= errorMessage %></p>
<% } %>

<h1>やあ！<%= nick %></h1>
<h2>今日も元気に課金しようね！！</h2>
</body>
</html>
