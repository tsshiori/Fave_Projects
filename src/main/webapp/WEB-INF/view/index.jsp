<%@ page import="utils.Bean.userBean" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="static/css/index.css">

    <link rel="shortcut icon" href="../img/Time for Fave.png">
    <title>HOME | Time of Fave.</title>
</head>

<body id="index">
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
        <a href="goods"><img class="add" src="static/img/ADD.png" alt="add"></a>

        <div class="scroll-content ge-list">
            <!-- グッズ詳細表示 -->
            <a class="goods_detail_open" href="#">

                <div class="guzzu">
                    <div class="container">
                        <div class="hi-img">
                            <p>~11/16</p>
                            <img src="static/img/Y_A.png" alt="A">
                        </div>
                        <div class="inf-meter">
                            <div class="container osi-na-pri">
                                <p class="osi">カンパネルラ</p>
                                <p class="name">アクリルスタンド</p>
                                <p class="price">¥1,980</p>
                            </div>
                            <div class="meter-app container">
                                <div class="meter-container in-meter">
                                    <!-- メーター表示 -->
                                    <meter class="background-meter" value="100" min="0" max="100"></meter>
                                    <meter class="foreground-meter" value="100" min="0" max="100"></meter>
                                </div>
                                <p class="app">Complete！</p>
                            </div>
                        </div>
                    </div>
                </div>
            </a>




            <div class="event">
                <div class="container">
                    <div class="hi-img">
                        <p>~11/27</p>
                        <img src="../img/Y_B.png" alt="B">
                    </div>
                    <div class="inf-meter">
                        <div class="container osi-na-pri">
                            <p class="osi">ミューズ</p>
                            <p class="name">STARMINE　ver.4.0 </p>
                            <p class="price">¥12,500</p>
                        </div>
                        <div class="meter-app container">
                            <div class="meter-container in-meter">
                                <!-- 背面のメーター -->
                                <meter class="background-meter" value="100" min="0" max="100"></meter>
                                <!-- 前面のメーター -->
                                <meter class="foreground-meter" value="77.4" min="0" max="100"></meter>
                            </div>
                            <p class="app">Expected…</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="guzzu">
                <div class="container">
                    <div class="hi-img">
                        <p>~12/6</p>
                        <img src="../img/Y_C.png" alt="C">
                    </div>
                    <div class="inf-meter">
                        <div class="container osi-na-pri">
                            <p class="osi">ミューズ</p>
                            <p class="name">ころころぬい ランダム</p>
                            <p class="price">¥1,960</p>
                        </div>
                        <div class="meter-app container">
                            <div class="meter-container in-meter">
                                <!-- 背面のメーター -->
                                <meter class="background-meter" value="100" min="0" max="100"></meter>
                                <!-- 前面のメーター -->
                                <meter class="foreground-meter" value="100" min="0" max="100"></meter>
                            </div>
                            <p class="app">Complete！</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="guzzu">
                <div class="container">
                    <div class="hi-img">
                        <p>~11/16</p>
                        <img src="../img/Y_D.png" alt="D">
                    </div>
                    <div class="inf-meter">
                        <div class="container osi-na-pri">
                            <p class="osi">カンパネルラ</p>
                            <p class="name">銀河鉄道模型　受注生産</p>
                            <p class="price">¥21,300</p>
                        </div>
                        <div class="meter-app container">
                            <div class="meter-container in-meter">
                                <!-- 背面のメーター -->
                                <meter class="background-meter" value="100" min="0" max="100"></meter>
                                <!-- 前面のメーター -->
                                <meter class="foreground-meter" value="45.4" min="0" max="100"></meter>
                            </div>
                            <p class="app">あと<span>３</span>回…</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="event">
                <div class="container">
                    <div class="hi-img">
                        <p>~2/18</p>
                        <img src="../img/Y_E.png" alt="E">
                    </div>
                    <div class="inf-meter">
                        <div class="container osi-na-pri">
                            <p class="osi">ミューズ</p>
                            <p class="name">STARLIVEツアー　コチョク</p>
                            <p class="price">¥62,000</p>
                        </div>
                        <div class="meter-app container">
                            <div class="meter-container in-meter">
                                <!-- 背面のメーター -->
                                <meter class="background-meter" value="34.3" min="0" max="100"></meter>
                                <!-- 前面のメーター -->
                                <meter class="foreground-meter" value="15.6" min="0" max="100"></meter>
                            </div>
                            <p class="app">シフトが<br>足りません…</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- モーダルウィンドウ -->
<div class="detail modal">
    <div class="modal-content">
        <div class="modal-header">
            <div class="mohe container">
                <div class="yusendo">
                    <img src="../img/Y_A.png" alt="Y_A">
                </div>
                <div class="goodsdetail">
                    <div class="container tate">
                        <h2 class="komo">日付：</h2>　<h2 class="de">2024/11/16</h2>
                    </div>
                    <div class="container tate">
                        <h2 class="komo">グッズ名：</h2>　<h2 class="de">アクリルスタンド</h2>
                    </div>
                    <div class="container tate">
                        <h2 class="komo">金額(円)：</h2>　<h2 class="de">¥1,980</h2>
                    </div>
                    <div class="container tate">
                        <h2 class="komo">推し：</h2>　<h2 class="de">カンパネルラ</h2>
                    </div>
                </div>
            </div>
            <div class="memo">
                <h2>メモ：</h2>
                <p>ビジュがよき</p>
            </div>
        </div>
        <div class="modal-body">
            <div class="edde container">
                <a class="edit" href="../GoodsFile/goods_edit/goods_edit.html">
                    <img src="../img/EDIT2.png" alt="edit2">
                </a>
                <button type="button" class="delete"><img src="../img/DELE2.png" alt="dele2"></button>
            </div>
            <div class="clo">
                <button type="button" class="btn close">閉じる</button>
            </div><br>
        </div>
    </div>
</div>

<script src="static/js/index.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>