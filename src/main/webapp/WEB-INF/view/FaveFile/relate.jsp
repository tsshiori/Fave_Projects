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
    <link rel="stylesheet" href="static/css/FaveFile/relate.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>RELATE | Time of Fave.</title>
</head>

<body class="RELATE">
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
            <a href="../../ShiftFile/shift/shift.html">
                <h3>SHIFT</h3>
            </a>
        </div>
        <hr>
        <div class="work">
            <a href="../../WorkFile/work/work.html">
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
        <br>
        <div class="scroll-content">
            <div class="accordion">
                <div class="accordion-item">
                    <div class="container">
                        <button type="button"> <img class="EDIT" src="static/img/EDIT.png"></button>

                        <button class="accordion-button">
                            <div class="container">
                                銀河鉄道の夜
                                <img class="DOWN" src="static/img/DOWN.png">
                            </div>
                        </button>
                        <button class="DELEbtn" type="button"><img class="DELE" src="static/img/DELE.png"></button>
                    </div>
                    <div class="accordion-content">
                        <div class="container Addcon1">
                            <div>
                                <button class="Addcon" type="button">
                                    <img class="ADD" src="static/img/ADD.png">
                                </button>
                            </div>
                            <ul>
                                <li>
                                    <div class="container licon">
                                        <div class="container li">
                                            <div class="vertical-line"></div>2号車組
                                        </div>
                                        <div class="container libtn">
                                            <button type="button"><img class="btnimg EDIT2"
                                                                       src="static/img/EDIT2.png"></button>
                                            <button type="button"><img class="btnimg DELE2"
                                                                       src="static/img/DELE2.png"></button>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="container licon">
                                        <div class="container li">
                                            <div class="vertical-line"></div>先頭車両組
                                        </div>
                                        <div class="container libtn">
                                            <button type="button"><img class="btnimg EDIT2"
                                                                       src="static/img/EDIT2.png"></button>
                                            <button type="button"><img class="btnimg DELE2"
                                                                       src="static/img/DELE2.png"></button>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="container licon">
                                        <div class="container li">
                                            <div class="vertical-line"></div>乗客組
                                        </div>
                                        <div class="container libtn">
                                            <button type="button"><img class="btnimg EDIT2"
                                                                       src="static/img/EDIT2.png"></button>
                                            <button type="button"><img class="btnimg DELE2"
                                                                       src="static/img/DELE2.png"></button>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="container close">
                                        閉じる
                                        <button type="button">
                                            <img class="DOWN" src="static/img/DOWN2.png">
                                        </button>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>


            <button type="button" class="ADD2con">
                <img class="ADD2" src="static/img/ADD.png">
            </button>
        </div>
    </div>

</div>


<!-- モーダルのHTML -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>編集内容を入力してください</h3>
        <input type="text" placeholder="銀河鉄道の夜">

        <div class="modal-body">
            <button id="confirmEdit" type="button" class="btn">完了</button>
            <button id="re_edcon_can" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>

<div id="editModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>曲/チーム/組名等</h4>
        </div>
        <h3>編集内容を入力してください</h3>
        <input type="text" placeholder="2号車組">

        <div class="modal-body">
            <button id="confirmEdit2" type="button" class="btn">完了</button>
            <button id="re_edtab_can" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>

<div id="deleteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>本当に削除しますか？</h3>
        <div class="deleword">
            <div class="line">
                <span class="asterisk">※</span>
                <span class="text">消した後は二度と元に戻せません。</span>
            </div>
            <div class="line">
                <span class="asterisk">※</span>
                <span class="text">対応するチーム/曲/組名等も削除されます。</span>
            </div>
        </div>

        <input type="text" placeholder="銀河鉄道の夜" readonly>

        <div class="modal-body">
            <button id="confirmDELE" type="button" class="btn">削除</button>
            <button id="re_deletab_can" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>

<div id="deleteModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>本当に削除しますか？</h3>
        <div class="deleword">
            <div class="line">
                <span class="asterisk">※</span>
                <span class="text">消した後は二度と元に戻せません。</span>
            </div>
        </div>

        <input type="text" placeholder="銀河鉄道の夜" readonly>

        <div class="modal-body">
            <button id="confirmDELE2" type="button" class="btn">削除</button>
            <button id="re_decon_can" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>

<div id="addModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>曲/チーム/組名等</h4>
        </div>
        <h3>追加内容を入力してください</h3>
        <input type="text" placeholder="曲/チーム/組名等を入力してください。">

        <div class="modal-body">
            <button id="confirmAdd" type="button" class="btn">追加</button>
            <button id="re_tab_can" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>

<div id="addModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>追加内容を入力してください</h3>
        <input type="text" placeholder="所属/関連プロジェクト等を入力してください。">

        <div class="modal-body">
            <button id="confirmAdd2" type="button" class="btn">追加</button>
            <button id="re_con_can" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>



<script src="static/js/FaveFile/relate.js"></script>
<script src="static/js/all.js"></script>
</body>



<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
