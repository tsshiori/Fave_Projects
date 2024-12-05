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
    <link rel="stylesheet" href="static/css/FaveFile/fave.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>FAVE | Time of Fave.</title>
</head>

<body class="FAVE">
<div class="container con">
    <!-- ロゴ -->
    <div class="logo">
        <a href="/fave"><img src="static/img/TimeforFave.png" alt="logo"></a>
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
        <div class="scroll-content">

            <div class="toggle-container">
                <label for="switch" class="switch_label">
                    <div class="switch">
                        <input type="checkbox" id="switch" />
                        <div class="base">
                            <div class="circle container">
                                <div class="gallery"><img src="static/img/table-cells-solid.png" alt="gallery"></div>
                                <div class="list"><img src="static/img/list-ul-solid.png" alt="list"></div>
                            </div>
                        </div>
                    </div>
                </label>
            </div>

            <div id="gallery">
                <div class="container">
                    <a class="a00" href="fave_add">
                        <div class="add0">
                            <img src="static/img/ADD.png" alt="FaveAdd">
                        </div>
                    </a>

                    <a href="fave_detail">
                        <div class="card__item">
                            <div class="card_img">
                                <img src="static/img/com.jpg" alt="カンパネルラ">
                            </div>
                            <p>カンパネルラ</p>
                        </div>
                    </a>

                    <a href="fave_detail">
                        <div class="card__item">
                            <div class="card_img">
                                <img src="static/img/myu.jpg" alt="ミューズ">
                            </div>
                            <p>ミューズ</p>
                        </div>
                    </a>
                </div>
            </div>

            <div id="list">
                <div class="add1">
                    <a href="fave_add"><img src="static/img/ADD.png" alt="Add"></a>
                </div>

                <a href="fave_detail">
                    <div class="list_card container">
                        <div class="card_img">
                            <img src="static/img/com.jpg" alt="カンパネルラ">
                        </div>
                        <h3 class="name">カンパネルラ</h3>
                        <h4 class="rela">/ 銀河鉄道の夜　2号車組</h4>
                        <h2 class="price">¥21,600</h2>
                    </div>
                </a>

                <a href="fave_detail">
                    <div class="list_card container">
                        <div class="card_img">
                            <img src="static/img/myu.jpg" alt="ミューズ">
                        </div>
                        <h3 class="name">ミューズ</h3>
                        <h4 class="rela">/ STAR★BURST★SHIP　流星のキセキ</h4>
                        <h2 class="price">¥13,500</h2>
                    </div>
                </a>
            </div>

        </div>
    </div>

</div>
<script src="static/js/FaveFile/fave.js"></script>
<script src="static/js/all.js"></script>
</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
