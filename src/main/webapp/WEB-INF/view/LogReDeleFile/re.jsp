<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/css/all.css">
    <link rel="stylesheet" href="static/css/LogReDeleFile/re.css">
    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>Register | Time of Fave.</title>
</head>
<body class="scroll-box_re">
<div class="login_form scroll-content_re">
    <form id="registerForm" action="register" method="post">
    <div class="logo"><img src="static/img/TimeforFave.png" alt="logo"></div>
        <p class="hissu p">※ ＊は必須項目です。</p>
        <div class="text">
            <div class="cen"><input type="text" name="log_id" placeholder="　ID" required="未入力です。"></div>
            <div class="cen"><input type="text" name="password" placeholder="　パスワード" required="未入力です。"></div>
            <div class="cen"><input type="text" name="nick" placeholder="　ニックネーム" required="未入力です。"></div>
        </div>
        <div class="icon container">
            <label><input type="radio" name="regimg" value="0" checked><img src="static/img/I_N.png" alt="nomal"></label>
            <label><input type="radio" name="regimg" value="1"><img src="static/img/I_B.png" alt="blue"></label>
            <label><input type="radio" name="regimg" value="2"><img src="static/img/I_G.png" alt="green"></label>
            <label><input type="radio" name="regimg" value="3"><img src="static/img/I_R.png" alt="red"></label>
            <label><input type="radio" name="regimg" value="4"><img src="static/img/I_V.png" alt="violet"></label>
            <label><input type="radio" name="regimg" value="5"><img src="static/img/I_Y.png" alt="yellow"></label>
        </div>
        <br>
        <input type="text" name="amounthand" placeholder="　所持金額(円)"><br>
        <input type="text" name="living" placeholder="　生活費(円)"><br>
        <input type="text" name="name" placeholder="　最推し"><br>
    </form>
</div>
<div class="btn">
    <button id="modalOpen" type="button" class="in">登録</button>
    <a class="kyan" href="fave">キャンセル</a>
</div>
</form>
<br><br>

</div>

<!-- モーダル -->
<div id="easyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h1>以下の内容でよろしいですか？</h1>
        </div>
        <div class="modal-body">
            <table>
                <tr>
                    <th>ID：</th>
                    <td id="modalId">1234ruiruroi</td>
                </tr>
                <tr>
                    <th>パスワード：</th>
                    <td id="modalPassword">************</td>
                </tr>
                <tr>
                    <th>ニックネーム：</th>
                    <td id="modalNick">ルイ・ルロイ</td>
                </tr>
                <tr>
                    <th>アイコン：</th>
                    <td><img src="../../img/I_N.png" alt="Nomal"></td>
                </tr>
                <tr>
                    <th>所持金額(円)：</th>
                    <td id="modalAmount">¥9,680</td>
                </tr>
                <tr>
                    <th>生活費(円)：</th>
                    <td id="modalLiving">¥118,000</td>
                </tr>
                <tr>
                    <th>最推し：</th>
                    <td id="modalSai">カンパネルラ</td>
                </tr>
            </table>
            <button id="confirmRe" type="button" class="btn2">登録</button>
            <button id="cancelRe" type="button" class="btn2">キャンセル</button>
        </div>
    </div>
</div>

<script src="static/js/LogReDeleFile/re.js"></script>
</body>
<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>
</html>
