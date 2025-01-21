<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");

    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    int futureWage = (int) session.getAttribute("futureWage");
    int almosthand = (int) session.getAttribute("almosthand");
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
    <link rel="stylesheet" href="static/css/FaveFile/fave_detail.css">

    <link rel="shortcut icon" href="static/img/Time for Fave.png">
    <title>FAVE_Detaile | Time of Fave.</title>
</head>

<body class="FAVE">
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
            <meter class="background-meter" value="<%=futureWage%>" min="0" max="10000"></meter>
            <!-- 前面のメーター -->
            <meter class="foreground-meter" value="<%=almosthand%>" min="0" max="10000"></meter>
        </div>
        <div class="meterimg">
            <div class="temoti">
                <img src="static/img/temoti.png" alt="temoti">
                <span class="temoti-value">所持金額: <%=futureWage%></span> <!-- valueを表示する要素 -->
            </div>
            <div class="kyuuryoubi">
                <img src="static/img/kyuuryoubi.png" alt="kyuuryoubi">
                <span class="kyuuryoubi-value">給与予定額: <%=almosthand%></span> <!-- valueを表示する要素 -->
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
            <div class="container">
                <div class="left">
                    <div class="l_img">
                        <div class="f_img">
                            <img src="static/img/com.jpg" alt="カンパネルラ" id="preview">
                        </div>
                    </div>

                    <div class="fd_memo">
                        <h3>メモ</h3>
                        <p>ジョバンニの親友<br>
                            左利き<br>
                            アイスなど冷たいものが好き<br>
                            水星出身</p>
                    </div>
                </div>
                <div class="right">
                    <div class="name container">
                        <h1><span class="na0">名前：</span><span class="na1">カンパネルラ</span></h1>
                        <a href="fave_edit"><img src="static/img/EDIT.png" alt="fave_edit"></a>
                    </div>

                    <table>
                        <tr>
                            <td>
                                <div class="categori0">誕生日：</div>
                            </td>
                            <th>不明</th>
                        </tr>
                        <tr>
                            <td>
                                <div class="categori0 container">
                                    <div class="categori1">
                                        <p>所属 /<br>
                                            関連プロジェクト 等</p>
                                    </div>
                                    <div class="categori2">：</div>
                                </div>
                            </td>
                            <th>銀河鉄道の夜</th>
                        </tr>
                        <tr>
                            <td>
                                <div class="categori0 container">
                                    <div class="categori1">
                                        <p>曲 / チーム / 組名 等</p>
                                    </div>
                                    <div class="categori2">：</div>
                                </div>
                            </td>
                            <th>２号車組</th>
                        </tr>
                        <tr>
                            <td>　</td>
                            <th>乗客組</th>
                        </tr>
                        <tr>
                            <td>　</td>
                            <th>　</th>
                        </tr>
                        <tr>
                            <td>　</td>
                            <th>　</th>
                        </tr>
                        <tr>
                            <td>　</td>
                            <th>　</th>
                        </tr>
                    </table>

                    <div class="fd_money">
                        <h1>奉納額：<span>¥21,600</span></h1>
                        <button id="detail_button">金額の詳細 ＞</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<div id="money_de" class="modal">
    <div class="modal-content">

        <div class="modal-body">
            <div class="ikkatu">
                <div class="container goods_money">
                    <h4>アクリルパネル</h4>
                    <h3>¥2,600</h3>
                </div>

                <div class="container event_money">
                    <h4>アクリルパネル</h4>
                    <h3>¥2,600</h3>
                </div>

                <div class="container event_money">
                    <h4>アクリルパネル</h4>
                    <h3>¥2,600</h3>
                </div>

                <div class="container goods_money">
                    <h4>アクリルパネル</h4>
                    <h3>¥2,600</h3>
                </div>

                <div class="container goods_money">
                    <h4>アクリルパネル</h4>
                    <h3>¥2,600</h3>
                </div>

                <div class="container event_money">
                    <h4>アクリルパネル</h4>
                    <h3>¥2,600</h3>
                </div>

                <div class="container event_money">
                    <h4>アクリルパネル</h4>
                    <h3>¥2,600</h3>
                </div>


            </div>


            <button id="mo_de_close" type="button" class="btn">閉じる</button>
        </div>
    </div>
</div>

<script src="static/js/FaveFile/fave_detail.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
