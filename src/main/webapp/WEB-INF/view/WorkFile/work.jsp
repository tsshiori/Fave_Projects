<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Bean.workBean" %> <!-- workBean クラスのパッケージに合わせて変更 -->
<%
    // worklistをJSPに渡す
    ArrayList<workBean> worklist = (ArrayList<workBean>) session.getAttribute("worklist");
%>
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
    <link rel="stylesheet" href="static/css/WorkFile/work.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>WORK | Time of Fave.</title>
</head>

<body class="WORK">
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
        <a href="work_add"><img class="add" src="static/img/ADD.png" alt="add"></a>

        <div class="scroll-content">
            <%
                // worklistが空でない場合、ループして表示
                if (worklist != null && !worklist.isEmpty()) {
                    for (workBean work : worklist) {
            %>
            <div class="shift_roop">
                <div class="container">
                    <div class="vertical-line"></div>
                    <span class="work_name"><%= work.getWork() %></span> <!-- workの名前 -->
                    <div class="timemoney">¥ <%= work.getHourlywage() %></div> <!-- 時給 -->
                    <div class="img_icon">
                        <a href="work_edit?work_id=<%= work.getWork_id() %>">
                            <img src="static/img/EDIT2.png">
                        </a>
                    </div> <!-- 編集ボタン -->
                    <div class="img_icon">
                        <a href="#" id="showModal1" data-work-id="<%= work.getWork_id() %>">
                            <img src="static/img/DELE2.png">
                        </a>
                    </div> <!-- 削除ボタン -->
                </div>
            </div>
            <br>
            <%
                    }
                }
            %>

            <br>
        </div>
    </div>
</div>

<!-- モーダルウィンドウ -->
<div id="modal1" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>削除できません。</h3>
            <h4 class="modal-h4">※ このバイト先はメイン設定されています。</h4>
        </div>
        <div class="modal-body">
            <button id="cancelDelete1" type="button" class="btn close">閉じる</button>
        </div>
    </div>
</div>

<div id="modal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>本当に削除しますか？</h3>
            <h4 class="modal-h4">※消した後は二度と元に戻れません。</h4>
            <div>
                <div class="container kome">
                    <h4 class="ko">バイト先名：</h4>
                    <h4 class="me">茎わかめファクトリー</h4>
                </div>
                <div class="container kome">
                    <h4 class="ko">時給(円)：</h4>
                    <h4 class="me">¥ 930</h4>
                </div>
            </div>
        </div>
        <div class="modal-body">
            <button id="confirmDelete1" type="button" class="btn">削除</button>
            <button id="cancelDelete2" type="button" class="btn">キャンセル</button>
        </div>
    </div>
</div>

<script src="static/js/WorkFile/work.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>