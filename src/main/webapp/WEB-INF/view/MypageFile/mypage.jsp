<%--
  Created by IntelliJ IDEA.
  User: hrnea
  Date: 2024/11/22
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
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
    <link rel="stylesheet" href="static/css/mypage.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>MYPAGE | Time of Fave.</title>
</head>

<body class="MYPAGE">
<div class="container con">
    <!-- ロゴ -->
    <div class="logo">
        <a href="../../index/index.html"><img src="static/img/TimeforFave.png" alt="logo"></a>
    </div>

    <!-- メーター -->
    <div class="meter">
        <br>
        <h2>≪METER≫</h2>
        <div class="meter-container">
            <!-- 背面のメーター -->
            <meter class="background-meter" value="31.1" min="0" max="100"></meter>
            <!-- 前面のメーター -->
            <meter class="foreground-meter" value="9.7" min="0" max="100"></meter>
        </div>
        <div class="meterimg">
            <div class="temoti"><img src="static/img/temoti.png" alt="temoti"></div>
            <div class="kyuuryoubi"><img src="static/img/kyuuryoubi.png" alt="kyuuryoubi"></div>
        </div>
    </div>
</div>
<br>
<div class="maincontents container">
    <aside class="menu">
        <br>
        <div class="home">
            <a href="../../index/index.html">
                <h3>HOME</h3>
            </a>
        </div>
        <hr>
        <div class="fave">
            <a href="../../FaveFile/fave/fave.html">
                <h3>FAVE</h3>
            </a>
        </div>
        <hr>
        <div class="relate">
            <a href="../../FaveFile/relate/relate.html">
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
            <a href="../../MypageFile/mypage/mypage.html">
                <h3>MYPAGE</h3>
            </a>
        </div>
        <br><br>
    </aside>

    <div class="main scroll-box">
        <div class="top-link">
            <div class="list-link"><a href="../../GoodsFile/goods/goods.html">グッズリスト ＞</a></div>
            <div class="out-link"><a href="LogoutServlet">LOGOUT</a></div>
        </div>
        <br><br>
        <div class="scroll-content mycontents">
            <div class="container">
                <div class="icon">
                    <img src="../../img/I_N.png" alt="Nomal">
                </div>
                <div class="nick">
                    <h1>ルイ・ルロイ</h1>
                </div>
                <div class="edit">
                    <a href="../mypage_edit/mypage_edit.html"><img src="../../img/EDIT.png" alt="mypageedit"></a>
                </div>
            </div>

            <div class="most">
                <div class="container mo1">
                    <div class="favetag">
                        <p>Now</p>
                        <p>　Fave</p>
                    </div>
                    <div class="moimg">
                        <img src="../../img/com.jpg" alt="">
                    </div>
                    <div class="favename">
                        <h2>カンパネルラ</h2>
                    </div>
                </div>

                <div class="cate">
                    <h3><span>/</span>銀河鉄道の夜　2号車組</h3>
                </div>
            </div>

            <div class="container lm">
                <div class="life">
                    <h2>生活費：</h2>
                    <h1><span>¥</span>118,000</h1>
                </div>
                <div class="money">
                    <h2>達成金額：</h2>
                    <h1><span>¥</span>9,680</h1>
                </div>
            </div>

            <a class="akasaku" href="DeleServlet">アカウント削除 ＞</a>
        </div>

    </div>
</div>
</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
