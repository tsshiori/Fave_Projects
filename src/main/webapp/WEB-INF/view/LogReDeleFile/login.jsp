<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+JP:wght@200..900&family=Yuji+Syuku&display=swap"
          rel="stylesheet">


    <link rel="stylesheet" href="static/css/all.css">
    <link rel="stylesheet" href="static/css/LogReDeleFile/login.css">


    <link rel="shortcut icon" href="static/img/TimeforFave.png">

    <title>LOGIN | Time of Fave.</title>
</head>

<body>
<div class="login_form">
    <form action="../../index/index.html">

        <div class="logo"><img src="static/img/TimeforFave.png" alt="logo"></div>
        <div class="text">
            <input type="text" name="ID" placeholder="　ID">
            <input type="text" name="pass" placeholder="　パスワード" class="last-input">
            <div class="a">
                <a href="re.jsp">新規登録はこちら ＞</a>
            </div>
        </div>
        <button type="submit" class="btn">ログイン</button>
    </form>
</div>
</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>