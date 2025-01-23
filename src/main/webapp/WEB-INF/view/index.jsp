<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    int futureWage = (int) request.getAttribute("futureWage");
    int almosthand = (int) request.getAttribute("almosthand");
    int sum = (int) session.getAttribute("sum");
    workBean mainwork = (workBean) session.getAttribute("mainwork");
%>

<!DOCTYPE html>
<html lang="ja">
<%
    ArrayList<osikatuBean> goodslist = (ArrayList<osikatuBean>) session.getAttribute("goodsList");
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
            <meter class="background-meter" value="<%=futureWage%>" min="0" max="<%= sum %>"></meter>
            <!-- 前面のメーター -->
            <meter class="foreground-meter" value="<%=almosthand%>" min="0" max="<%= sum %>"></meter>
            <input type="hidden" name="living" value="<%= user.getLiving() %>" id="live_money">
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
            <% if (goodslist != null && !goodslist.isEmpty()) { %>
            <%
                for (osikatuBean goods : goodslist){
            %>
            <% if (goods.getItemtype() == 0 && goods.getPurchase() != 1){%>
            <% String favename = "";
                for (faveBean fave : favelist){
                    if (fave.getOsi_id() == goods.getOsi_id()){
                        favename = fave.getName();
                    }
            }%>
            <a class="goods_detail_open" href="#"
               data-prioriti="<%= goods.getPriority() %>"
               data-day="<%= goods.getDay() %>"
               data-item="<%= goods.getItem() %>"
               data-price="<%= goods.getPrice() %>"
               data-name="<%= favename %>"
               data-memo="<%= goods.getMemo() %>"
            >
                <div class="guzzu">
                    <div class="container">
                        <div class="hi-img">
                            <%
                                if (goods.getDay() != null) {
                                    LocalDate day = (goods.getDay());  // もしLocalDate型であれば
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                            %>
                            <p><%= day.format(formatter) %></p>
                            <% } %>
                            <img src="static/img/Y_<%= goods.getPriority()%>.png" alt="<%= goods.getItem() %>">
                        </div>
                        <div class="inf-meter">
                            <div class="container osi-na-pri">
                                <p class="osi"><%= favename %></p>
                                <p class="name"><%= goods.getItem() %></p>
                                <p class="price">&yen;<%= String.format("%,d", goods.getPrice()) %></p>
                            </div>
                            <div class="meter-app container">
                                <div class="meter-container in-meter">
                                    <!-- メーター表示 -->
                                    <meter class="background-meter" value="<%=futureWage%>" min="0" max="<%= goods.getPrice() %>"></meter>
                                    <meter class="foreground-meter" value="<%= user.getAmounthand() %>" min="0" max="<%= goods.getPrice() %>"></meter>
                                </div>
                                <p class="app">
                                    <% int shifttime = 0;
                                        if (goods.getPrice() <= user.getAmounthand()) { %>
                                    　Complete！
                                    <% } else {
                                            int kari = goods.getPrice() - user.getAmounthand();
                                            shifttime = kari / mainwork.getHourlywage();
                                            if (shifttime < 1){
                                    %>
                                    　あと<span>もう少し</span>…
                                    <% }else{ %>
                                    　あと<span><%= shifttime %></span>時間…
                                    <%
                                            }
                                    }
                                    %>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
            <% }else if(goods.getPurchase() != 1){ %>
            <% String favename = "";
                for (faveBean fave : favelist){
                    if (fave.getOsi_id() == goods.getOsi_id()){
                        favename = fave.getName();
                    }
                }%>
            <a class="goods_detail_open" href="#"
               data-prioriti="<%= goods.getPriority() %>"
               data-day="<%= goods.getDay() %>"
               data-item="<%= goods.getItem() %>"
               data-price="<%= goods.getPrice() %>"
               data-name="<%= favename %>"
               data-memo="<%= goods.getMemo() %>"
               data-type="<%= goods.getItemtype() %>"
            >
                <div class="event">
                    <div class="container">
                        <div class="hi-img">
                            <%
                                if (goods.getDay() != null) {
                                    LocalDate day = (goods.getDay());  // もしLocalDate型であれば
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                            %>
                            <p><%= day.format(formatter) %></p>
                            <% } %>
                            <img src="static/img/Y_<%= goods.getPriority()%>.png" alt="<%= goods.getItem() %>">
                        </div>
                        <div class="inf-meter">
                            <div class="container osi-na-pri">
                                <p class="osi"><%= favename %></p>
                                <p class="name"><%= goods.getItem() %></p>
                                <p class="price">&yen;<%= String.format("%,d", goods.getPrice()) %></p>
                            </div>
                            <div class="meter-app container">
                                <div class="meter-container in-meter">
                                    <!-- メーター表示 -->
                                    <meter class="background-meter" value="<%=futureWage%>" min="0" max="<%= goods.getPrice() %>"></meter>
                                    <meter class="foreground-meter" value="<%= user.getAmounthand() %>" min="0" max="<%= goods.getPrice() %>"></meter>
                                </div>
                                <p class="app">
                                    <% int shifttime = 0;
                                        if (goods.getPrice() <= user.getAmounthand()) { %>
                                    　Complete！
                                    <% } else {
                                        int kari = goods.getPrice() - user.getAmounthand();
                                        shifttime = kari / mainwork.getHourlywage();
                                        if (shifttime < 1){
                                    %>
                                    　あと<span>もう少し</span>…
                                    <% }else{ %>
                                    　あと<span><%= shifttime %></span>時間…
                                    <%
                                            }
                                        }
                                    %>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
            <% } %>
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
                        <h2 class="komo">日付：</h2>　<h2 class="de day">2024/11/16</h2>
                    </div>
                    <div class="container tate">
                        <h2 class="komo type"></h2>　<h2 class="de item">アクリルスタンド</h2>
                    </div>
                    <div class="container tate">
                        <h2 class="komo">金額(円)：</h2>　<h2 class="de price">¥1,980</h2>
                    </div>
                    <div class="container tate">
                        <h2 class="komo">推し：</h2>　<h2 class="de name">カンパネルラ</h2>
                    </div>
                </div>
            </div>
            <div class="memo">
                <h2>メモ：</h2>
                <p class="memo">ビジュがよき</p>
            </div>
        </div>
        <div class="modal-body">
            <div class="edde container">
                <a class="edit" href="goods_edit">
                    <img src="static/img/EDIT2.png" alt="edit2">
                </a>
                <button type="button" class="delete" id="del_in_open"><img src="static/img/DELE2.png" alt="dele2"></button>
            </div>
            <div class="clo">
                <button type="button" class="btn close">閉じる</button>
            </div><br>
        </div>
    </div>
</div>

<div id="delete_index_goods" class="modal">
    <div class="modal-content-center">
        <h3>本当に削除しますか？</h3>
        <div class="delete-h4">
            <h6>※消した後は二度と元に戻れません。</h6>
        </div>

        <div class="delete-details">
            <table>
                <tr>
                    <th>日付：</th>
                    <td>2024/11/16</td>
                </tr>
                <tr>
                    <th>グッズ名：</th>
                    <td>アクリルスタンド</td>
                </tr>
                <tr>
                    <th>金額(円)：</th>
                    <td>¥ 1,980</td>
                </tr>
                <tr>
                    <th>優先度：</th>
                    <td><img src="" alt="" class="priority-image"></td>
                </tr>
                <tr>
                    <th>推し：</th>
                    <td>カンパネルラ</td>
                </tr>
                <tr>
                    <th>メモ：</th>
                    <td>ビジュがよき</td>
                </tr>
                <tr>
                    <th>購入済：</th>
                    <td>
                    </td>
                </tr>
            </table>
        </div>


        <button id="goods_Delete" type="button" class="btn delete-btn" onclick="confirmDelete()">削除</button>
        <button id="mCancel" type="button" class="btn cancel-btn" onclick="closeDeleteModal()">キャンセル</button>
    </div>
</div>

<script src="static/js/index.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>