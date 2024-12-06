<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet" href="static/css/WorkFile/work_edit.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>WORK_Edit | Time of Fave.</title>
</head>

<body  class="WORK">
<div class="container con">
    <!-- ロゴ -->
    <div class="logo">
        <a href="fave"><img src="static/img/TimeforFave.png" alt="logo"></a>
    </div>

    <!-- メーター -->
    <div class="meter">
        <br>
        <h2>≪METER≫</h2>
        <div class="meter-container">
            <!-- 背面のメーター -->
            <meter class="background-meter" value="30920" min="0" max="99740"></meter>
            <!-- 前面のメーター -->
            <meter class="foreground-meter" value="9860" min="0" max="99740"></meter>
        </div>
        <div class="meterimg">
            <div class="temoti">
                <img src="static/img/temoti.png" alt="temoti">
                <span class="temoti-value">所持金額: 31.1</span> <!-- valueを表示する要素 -->
            </div>
            <div class="kyuuryoubi">
                <img src="static/img/kyuuryoubi.png" alt="kyuuryoubi">
                <span class="kyuuryoubi-value">給与予定額: 45.4</span> <!-- valueを表示する要素 -->
            </div>
        </div>
    </div>
</div>
<br>
<div class="maincontents container">
    <aside class="menu">
        <br>
        <div class="home">
            <a href="fave">
                <h3>HOME</h3>
            </a>
        </div>
        <hr>
        <div class="fave">
            <a href="fave_list">
                <h3>FAVE</h3>
            </a>
        </div>
        <hr>
        <div class="relate">
            <a href="relate">
                <h3>RELATE</h3>
            </a>
        </div>
        <hr>
        <div class="shift">
            <a href="shift">
                <h3>SHIFT</h3>
            </a>
        </div>
        <hr>
        <div class="work">
            <a href="work">
                <h3>WORK</h3>
            </a>
        </div>
        <hr>
        <div class="mypage">
            <a href="my_page">
                <h3>MYPAGE</h3>
            </a>
        </div>
        <br><br>
    </aside>

    <div class="main scroll-box">
        <div class="scroll-content">
            <p class="hissu p">※ ＊は必須項目です。</p>
            <form action="WorkEditServlet" method="post">
                <table>
                    <tr>
                        <th><span>＊</span> バイト先 :</th>
                        <td>
                            <input type="text" min="0" value="まいにちマート" placeholder="バイト先名を入力してください。">
                        </td>
                    </tr>
                    <tr>
                        <th><span>＊</span> 時給(円) :</th>
                        <td>
                            <input type="number" min="0" value="900" placeholder="時給(円)を入力してください。">
                        </td>
                    </tr>
                    <tr>
                        <th>メイン設定 :</th>
                        <td>
                            <input type="checkbox" min="0" checked>
                            <span class="small-text">※ メインのバイト先にする場合はチェックを入れてください。</span>
                        </td>
                    </tr>
                </table>
                <div class="btn">
                    <button id="modalOpen" type="button" class="in">完了</button>
                    <a class="kyan" href="work">キャンセル</a>
                </div>
            </form>
        </div>
    </div>
</div>





<!-- モーダルウィンドウ -->
<div id="easyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>以下の内容で追加しますか？</h3>
        </div>
        <table class="moA">
            <tr class="container moa">
                <th class="modal_title">バイト先 :</th>
                <td class="modal-a">にゃんカフェ</td>
            </tr>
            <tr class="container moa">
                <th class="modal_title">時給(円) ：</th>
                <td class="modal-a">¥1,050</td>
            </tr>
            <tr class="container moa">
                <th class="modal_title">メイン設定 :</th>
                <td class="modal-a">
                    <input type="checkbox" min="0">
                    <span class="small-text">※ メインのバイト先にする場合はチェックが入ります。</span>
                </td>
            </tr>
        </table>

        <div class="modal-body">
            <!-- モーダル内の削除を確定するボタン -->
            <button id="confirmDelete" type="button" class="btn">完了</button>
            <button id="cancelDelete" type="button" class="btn">キャンセル</button>
        </div>
    </div>
</div>

<script src="static/js/WorkFile/work_edit.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>