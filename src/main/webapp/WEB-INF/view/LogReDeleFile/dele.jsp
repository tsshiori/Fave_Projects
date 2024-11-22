<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+JP:wght@200..900&family=Yuji+Syuku&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="static/css/all.css">
    <link rel="stylesheet" href="static/css/LogReDeleFile/login.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>DELETE | Time of Fave.</title>

</head>

<body>
<div class="dele_form">
    <form action="../../index/index.html">

        <div class="logo"><img src="static/img/TimeforFave.png" alt="logo"></div>
        <div class="dele_t">
            <h2>※パスワードを入力してください</h2>
        </div>

        <div class="text">
            <input type="text" name="pass" placeholder="パスワード" class="last-input">
        </div>
        <!-- モーダルを開くためのボタン -->
        <div class="container_btn">
            <button type="button" id="modalOpen" class="btn">削除</button>
            <a class="kyan" href="WEB-INF/view/MypageFile/mypage.html">キャンセル</a>
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

    <script src="dele.js"></script>
</div>
</div>
</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
