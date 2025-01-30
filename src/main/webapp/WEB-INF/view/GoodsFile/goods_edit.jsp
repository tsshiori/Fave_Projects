<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.Bean.goodsBean" %>
<%@ page import="java.util.Objects" %>

<%
    // セッションからgoodsBeanのリストを取得
    ArrayList<goodsBean> goodsList = session.getAttribute("goodsList") != null
            ? (ArrayList<goodsBean>) session.getAttribute("goodsList")
            : new ArrayList<>();

    goodsBean goods = (goodsBean) session.getAttribute("goods");

// セッションから itemType を取得
    int itemType = 0; // デフォルトはグッズ (0)
    if (session.getAttribute("itemType") != null) {
        itemType = (int) session.getAttribute("itemType");
    }


    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
//    faveBean fave = (faveBean) session.getAttribute("fave");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    int futureWage = (int) session.getAttribute("futureWage");
    int almosthand = (int) session.getAttribute("almosthand");
    int sum = (int) session.getAttribute("sum");
    userBean user = (userBean) session.getAttribute("user");
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
    <link rel="stylesheet" href="static/css/GoodsFile/goods_edit.css">
    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>FAVE_Add | Time of Fave.</title>
</head>
<body class="MYPAGE">
<div class="container con">
    <!-- ロゴ -->
    <div class="logo">
        <a href="fave"><img src="static/img/TimeforFave.png" alt="logo"></a>
    </div>
    <!-- メーター -->
    <div class="meter">
        <br>
        <h2>≪METER≫</h2>
        <% if (sum != 0){%>
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
        <% }else{  %>
        <h1 style="margin-left: 120px">未購入のグッズが登録されていません。</h1>
        <% } %>
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
            <a href="fave">
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
        <div class="toggle-container">
            <label for="switch" class="switch_label">
                <div class="switch">
                    <input type="checkbox" id="switch" <% if (itemType == 1) { %> checked <% } %> onchange="this.form.submit();" />
                    <div class="base">
                        <div class="circle"></div>
                    </div>
                </div>
                <span class="title"><%= itemType == 0 ? "グッズ" : "イベント" %></span>
            </label>
            <p class="note">※ ＊は必須項目です。</p>
        </div>
        <br><br>
        <div id="goods" class="scroll-content group content-item active" ><%--<% if (itemType != 1) { %> hidden <% } %>"--%>
            <form id="goods_edit" action="goods_edit" method="post" class="goods_edit_form">
                <input type="hidden" name="itemtype" value="0">
                <input type="hidden" name="osikatu_id" value="<%=goods.getOsikatu_id()%>">
                <div class="form-group input-container">
                    <label><span class="req">＊</span> 日付：</label>
                    <input name="day" type="date" id="goods-date" class="pl" value="<%= goods.getDay() %>" required> <%--onfocus="hidePlaceholder(this)" onblur="showPlaceholder(this)" --%>

                </div>
                <div class="form-group">
                    <label><span class="req">＊</span> グッズ名：</label>
                    <input name="item" type="text" class="goods_name" placeholder="グッズの名前を入力してください。" value="<%= goods.getItem() %>" required>
                </div>
                <div class="form-group">
                    <label><span class="req">＊</span> 金額(円)：</label>
                    <input name="price" type="text" id="goods-amount" class="amount_cost" placeholder="グッズの金額を入力してください。" value="<%= goods.getPrice() %>" required>
                </div>
                <div class="form-group">
                    <label class="favo"><span class="req">＊</span> 推し：</label>
                    <select id="goods-menu" name="osi_id" onchange="fetchTagsByCategory(this.value)">
                        <% if (favelist != null && !favelist.isEmpty()) { %>
                        <% for (faveBean fav : favelist) { %>
                        <%
                            // サーバーサイドから渡された選択されたOSi_idの値を取得する
                            String selectedOsiId = request.getAttribute("selectedOsiId") != null ? request.getAttribute("selectedOsiId").toString() : "";
                            boolean isSelected = fav != null && Objects.equals(fav.getOsi_id(), selectedOsiId); // selectedOsiIdと比較
                        %>
                        <option value="<%= fav.getOsi_id() %>" data-name="<%= fav.getName() %>">
                            <%= fav.getName() %>
                        </option>
                        <% } %>
                        <% } else { %>
                        <option value="-1" disabled>推しが未登録</option>
                        <% } %>
                    </select>
                    <div id="plusButtonGoods" class="btn-plus">
                        <button class="plus" type="button">
                            <img src="static/img/plus.png" alt="plus">
                        </button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="icon container">
                        <label>
                            <input type="radio" id="icon-0" name="goodsicon" value="0" <%= goods.getPriority() == 0 ? "checked" : "" %>>
                            <img src="static/img/Y_0.png" alt="a">
                        </label>
                        <label>
                            <input type="radio" id="icon-1" name="goodsicon" value="1" <%= goods.getPriority() == 1 ? "checked" : "" %>>
                            <img src="static/img/Y_1.png" alt="b">
                        </label>
                        <label>
                            <input type="radio" id="icon-2" name="goodsicon" value="2" <%= goods.getPriority() == 2 ? "checked" : "" %>>
                            <img src="static/img/Y_2.png" alt="c">
                        </label>
                        <label>
                            <input type="radio" id="icon-3" name="goodsicon" value="3" <%= goods.getPriority() == 3 ? "checked" :"" %>>
                            <img src="static/img/Y_3.png" alt="d">
                        </label>
                        <label>
                            <input type="radio" id="icon-4" name="goodsicon" value="4" <%= goods.getPriority() == 4 ? "checked": "" %>>
                            <img src="static/img/Y_4.png" alt="e">
                        </label>
                    </div>
                </div>
                <input type="hidden" name="formType" value="goods">

                <div class="form-group">
                    <label class="memo-label">メモ：</label>
                    <textarea id="goods-memo" class="memo" name="memo" placeholder="メモを入力してください。"><%= goods.getMemo() %></textarea>
                </div>
                <div class="form-group">
                    <label>購入済：</label>
                    <input type="checkbox" id="goods-check" class="purchased" name="purchase" value="1" <%= goods.getPurchase() == 1 ? "checked" : "" %>>
                    <span class="small-text">※購入済みの場合はチェックを入れてください。</span>
                </div>
                <div class="form-group">
                    <div class="btn">
                        <button id="modalOpenGoods" type="button" class="in">完了</button>
                        <a class="kyan back-button" href="fave">キャンセル</a>
                    </div>
                </div>
            </form>
        </div>

           <div id="events" class="group content-item" ><%-- <% if (itemType != 0) { %> hidden <% } %>"--%>
            <form id="events_edit" action="goods_edit" method="post" class="events_edit_form">
                <input type="hidden" name="itemtype" value="1">
                <input type="hidden" name="osikatu_id" value="<%=goods.getOsikatu_id()%>">
                <div class="form-group input-container">
                    <label><span class="req">＊</span> 日付：</label>
                    <input name="day" type="date" id="event-date" class="pl" value="<%= goods.getDay() %>"> <%--onfocus="hidePlaceholder(this)" onblur="showPlaceholder(this)" --%>
                    <span class="date-text">日付を入力してください。</span>
                </div>
                <div class="form-group">
                    <label><span class="req">＊</span> イベント名：</label>
                    <input name="item" type="text" id="event-name" class="goods_name" placeholder="イベントの名前を入力してください。" value="<%= goods.getItem() %>" required>
                </div>
                <div class="form-group">
                    <label><span class="req">＊</span> 金額(円)：</label>
                    <input name="price" type="text" id="event-amount" class="amount_cost" placeholder="イベントの金額を入力してください。" value="<%= goods.getPrice() %>" required>
                </div>
                <div class="form-group">
                    <label class="favo"><span class="req">＊</span> 推し：</label>
                    <select id="event-menu" name="osi_id" onchange="fetchTagsByCategory(this.value)">
                        <% if (favelist != null && !favelist.isEmpty()) { %>
                        <% for (faveBean fav : favelist) { %>
                        <%
                            String selectedOsiId = request.getAttribute("selectedOsiId") != null ? request.getAttribute("selectedOsiId").toString() : "";
                            boolean isSelected = fav != null && Objects.equals(fav.getOsi_id(), selectedOsiId);
                        %>
                        <option value="<%= fav.getOsi_id() %>" data-name="<%= fav.getName() %>">
                            <%= fav.getName() %>
                        </option>
                        <% } %>
                        <% } else { %>
                        <option value="-1" disabled>推しが未登録</option>
                        <% } %>
                    </select>
                    <div id="plusButtonEvents" class="btn-plus">
                        <button class="plus" type="button">
                            <img src="static/img/plus.png" alt="plus">
                        </button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="icon container">
                        <label>
                            <input type="radio" id="event-icon-0" name="eventicon" value="0" <%= goods.getPriority() == 0 ? "checked" : "" %>>
                            <img src="static/img/Y_0.png" alt="a">
                        </label>
                        <label>
                            <input type="radio" id="event-icon-1" name="eventicon" value="1" <%= goods.getPriority() == 1 ? "checked" : "" %>>
                            <img src="static/img/Y_1.png" alt="b">
                        </label>
                        <label>
                            <input type="radio" id="event-icon-2" name="eventicon" value="2" <%= goods.getPriority() == 2 ? "checked" : "" %>>
                            <img src="static/img/Y_2.png" alt="c">
                        </label>
                        <label>
                            <input type="radio" id="event-icon-3" name="eventicon" value="3" <%= goods.getPriority() == 3 ? "checked" : "" %>>
                            <img src="static/img/Y_3.png" alt="d">
                        </label>
                        <label>
                            <input type="radio" id="event-icon-4" name="eventicon" value="4" <%= goods.getPriority() == 4 ? "checked" : "" %>>
                            <img src="static/img/Y_4.png" alt="e">
                        </label>
                    </div>
                </div>
                <input type="hidden" name="formType" value="event">
                <div class="form-group">
                    <label class="memo-label">メモ：</label>
                    <textarea id="event-memo" class="memo" name="memo" placeholder="メモを入力してください。"><%= goods.getMemo() %></textarea>
                </div>
                <div class="form-group">
                    <label>購入済：</label>
                    <input type="checkbox" id="event-check" class="purchased" name="purchase" value="1" <%= goods.getPurchase() == 1 ? "checked" : "" %>>
                    <span class="small-text">※購入済みの場合はチェックを入れてください。</span>
                </div>
                <div class="form-group">
                    <div class="btn">
                        <button id="modalOpenEvents" type="button" class="in">完了</button>
                        <a class="kyan back-button" href="fave">キャンセル</a>
                    </div>
                </div>
            </form>
        </div>

    </div>

<%--    <% } else { %>--%>
<%--    <p>不正なitemTypeが指定されています。</p>--%>
<%--    <% } %>--%>
    <div id="easyModalGoods" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h1>以下の内容でよろしいですか？</h1>
            </div>
            <div class="modal-body">

                <table>
                    <tr>
                        <th>日付：</th>
                        <td id="modal-goods-date"></td>
                    </tr>
                    <tr>
                        <th>グッズ名：</th>
                        <td id="modal-goods-name"></td>
                    </tr>
                    <tr>
                        <th>金額(円)：</th>
                        <td id="modal-goods-amount"></td>
                    </tr>
                    <tr>
                        <th>推し：</th>
                        <td id="modal-goods-favorite"></td>
                    </tr>
                    <tr>
                        <th>優先度：</th>
                        <td id="modal-goods-prioity"></td>
                    </tr>
                    <tr>
                        <th>メモ：</th>
                        <td id="modal-goods-memo"></td>
                    </tr>
                    <tr>
                        <th>購入済：</th>
                        <td  id="modal-goods-purchased"></td>
                    </tr>
                </table>
                <button id="confirmReGoods" type="button" class="btn2">完了</button>
                <button id="cancelReGoods" type="button" class="btn2">キャンセル</button>
            </div>
        </div>
    </div>
</div>
<div id="easyModalEvents" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h1>以下の内容でよろしいですか？</h1>
        </div>
        <div class="modal-body">
            <table>
                <tr>
                    <th>日付：</th>
                    <td id="modal-events-date"></td>
                </tr>
                <tr>
                    <th>イベント名：</th>
                    <td id="modal-events-name"></td>
                </tr>
                <tr>
                    <th>金額(円)：</th>
                    <td id="modal-events-amount"></td>
                </tr>
                <tr>
                    <th>推し：</th>
                    <td id="modal-events-favorite"></td>
                </tr>
                <tr>
                    <th>優先度：</th>
                    <td id="modal-events-prioity"></td>
                </tr>
                <tr>
                    <th>メモ：</th>
                    <td id="modal-events-memo"></td>
                </tr>
                <tr>
                    <th>購入済：</th>
                    <td  id="modal-events-purchased"></td>
                </tr>
            </table>
            <button id="confirmReEvents" type="button" class="btn2">完了</button>
            <button id="cancelReEvents" type="button" class="btn2 back-button">キャンセル</button>
        </div>
    </div>
</div>

<!-- プラスボタンのモーダル -->
<div id="modalGoods" class="modalbody">
    <span class="close" id="closeModal">&times;</span>
    <span class="close" id="closeModalGoods">&times;</span>
    <div class="modal-content2">
        <div class="modal-header">
            <h1>推しの追加</h1>
        </div>
        <form id="plusForm" action="goods_osi_add" method="post">
            <div class="modal-group">
                <label class="osi">推しの名前：</label>
                <input type="text" class="modalosi" name="modalosi" placeholder="推しを入力してください。">
            </div>
            <div class="modealbtn">
                <button id="AddGoods" type="button" class="btn3">追加</button>
                <button id="ReGoods" type="button" class="btn3">キャンセル</button>
            </div>
        </form>
    </div>
</div>
<!-- イベント用のプラスボタンのモーダル -->
<div id="modalEvents" class="modalbody">
    <span class="close" id="closeModalEvents">&times;</span>
    <div class="modal-content2">
        <div class="modal-header">
            <h1>推しの追加</h1>
        </div>
        <form id="plusFormEvents" action="goods_osi_add" method="post"><!-- enctype="application/x-www-form-urlencoded" -->
            <div class="modal-group">
                <label class="osi">推しの名前：</label>
                <input type="text" class="modalosi" name="modalosi" placeholder="推しを入力してください。" required>
            </div>
            <div class="modealbtn">
                <button id="AddEvents" type="button" class="btn3">追加</button>
                <button id="ReEvents" type="button" class="btn3">キャンセル</button>
            </div>
        </form>

    </div>
</div>
</body>
<script src="static/js/all.js"></script>
<script src="static/js/GoodsFile/goods_edit.js"></script>
<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>
</html>