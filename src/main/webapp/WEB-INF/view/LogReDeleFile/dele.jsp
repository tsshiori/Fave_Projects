<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/css/all.css">
    <link rel="stylesheet" href="static/css/LogReDeleFile/dele.css">
    <title>DELETE | Time of Fave.</title>
</head>

<body>
<div class="dele_form">
    <form id="deleteForm" action="DeleServlet" method="post">

        <div class="logo"><img src="static/img/TimeforFave.png" alt="logo"></div>
        <div class="dele_t">
            <h2>※パスワードを入力してください</h2>
        </div>

        <div class="text">
            <input type="text" id="password" name="pass" placeholder="パスワード" class="last-input">
        </div>

        <!-- エラーメッセージの表示 -->
        <p class="error-message" style="font-size: 15px; color: red">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </p>

        <!-- モーダルを開くためのボタン -->
        <div class="container_btn">
            <button type="button" id="modalOpen" class="btn">削除</button>
            <a id="cancelDeletePage" class="kyan" href="my_page">キャンセル</a>
        </div>

    </form>

    <!-- モーダルウィンドウ -->
    <div id="easyModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>本当に削除しますか？</h3>
                <div class="modal-h4">
                    <h4>※消した後は二度と元に戻れません。</h4>
                    <h4>※内容はすべて削除されます。</h4>
                </div>
            </div>
            <div class="modal-body">
                <!-- モーダル内の削除を確定するボタン -->
                <button id="confirmDelete" type="button" class="btn">削除</button>
                <button id="cancelDelete" type="button" class="btn">キャンセル</button>
            </div>
        </div>
    </div>
</div>
<script src="static/js/LogReDeleFile/dele.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
