<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.Bean.goodsBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.categoryBean" %>

<%
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    int futureWage = (int) session.getAttribute("futureWage");
    int almosthand = (int) session.getAttribute("almosthand");
%>

<!DOCTYPE html>
<html lang="ja">
<%
    ArrayList<goodsBean> goodslist = (ArrayList<goodsBean>) session.getAttribute("goodslist");
    // セッションからユーザー情報を取得
    userBean user = (userBean) session.getAttribute("user");
    // int mainwork = user.getMainwork(); // 必要であればこちらを有効化
%>


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
        <a href="goods_add" id="plus-link">
            <img class="add" src="static/img/ADD.png" alt="add">
        </a>

        <div class="scroll-content ge-list">
            <!-- グッズ詳細表示 -->
            <% if (goodslist != null && !goodslist.isEmpty()) { %>
            <% for (goodsBean goods : goodslist) { %>
            <a class="goods_detail_open" href="#">
                <div class="guzzu">
                    <div class="container">
                        <div class="hi-img">
                            <p>~<%= goods.getDay() %></p>
                            <img src="static/img/<%= goods.getItemtype() %>.png" alt="<%= goods.getItem() %>">
                        </div>
                        <div class="inf-meter">
                            <div class="container osi-na-pri">
                                <p class="osi"><%= goods.getOsi_id() %></p>
                                <p class="name"><%= goods.getItem() %></p>
                                <p class="price">&yen;<%= String.format("%,d", goods.getPrice()) %></p>
                            </div>
                            <div class="meter-app container">
                                <div class="meter-container in-meter">
                                    <!-- メーター表示 -->
                                    <meter class="background-meter" value="100" min="0" max="100"></meter>
                                    <meter class="foreground-meter" value="<%= goods.getPurchase() %>" min="0" max="100"></meter>
                                </div>
                                <p class="app">
                                    <% if (goods.getPurchase() >= 100) { %>
                                    Complete！
                                    <% } else { %>
                                    あと<span><%= goods.getPriority() %></span>回…
                                    <% } %>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
            <% } %>
            <% } else { %>
            <p>登録されたグッズはありません。</p>
            <% } %>
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