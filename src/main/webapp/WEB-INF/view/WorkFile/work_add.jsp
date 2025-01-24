<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMessage = (String) session.getAttribute("errorMessage");
    if (errorMessage != null) {
        session.removeAttribute("errorMessage"); // 使用後に削除
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="utils.Bean.userBean" %>

<%
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    userBean user = (userBean) session.getAttribute("user");
    int futureWage = (int) session.getAttribute("futureWage");
    int almosthand = (int) session.getAttribute("almosthand");
    int sum = (int) session.getAttribute("sum");
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
    <link rel="stylesheet" href="static/css/WorkFile/work_add.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>WORK_Add | Time of Fave.</title>
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
            <form action="WorkAddServlet" method="post" id="work_add_form">
                <table>
                    <tr>
                        <th><span>＊</span> バイト先 :</th>
                        <td>
                            <input name="work" type="text" min="0" placeholder="バイト先名を入力してください。">
                        </td>
                    </tr>
                    <% if (request.getAttribute("errorMessage") != null) { %>
                    <tr>
                        <th></th>
                        <td style="padding: 0; padding-left: 3rem;">
                            <p class="error-message" style="font-size: 15px; color: red">
                                <%= request.getAttribute("errorMessage") %>
                            </p>
                        </td>
                    </tr>
                    <% } %>

                    <tr>
                        <th><span>＊</span> 時給(円) :</th>
                        <td>
                            <input name="hourlywage" type="number" min="0" placeholder="時給(円)を入力してください。">
                        </td>
                    </tr>
                    <tr>
                        <th>メイン設定 :</th>
                        <td>
                            <input name="mainwork" type="checkbox" value="1">
                            <span class="small-text">※ メインのバイト先にする場合はチェックを入れてください。</span>
                        </td>
                    </tr>
                </table>
                <div class="btn">
                    <button id="modalOpen" type="button" class="in">追加</button>
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
                <td id="modal-work-name" class="modal-a"></td>
            </tr>
            <tr class="container moa">
                <th class="modal_title">時給(円) :</th>
                <td id="modal-hourlywage" class="modal-a"></td>
            </tr>
            <tr class="container moa">
                <th class="modal_title">メイン設定 :</th>
                <td id="modal-mainwork" class="modal-a"></td>
            </tr>
        </table>


        <div class="modal-body">
            <!-- モーダル内の削除を確定するボタン -->
            <button id="confirmDelete" type="button" class="btn">追加</button>
            <button id="cancelDelete" type="button" class="btn">キャンセル</button>
        </div>
    </div>
</div>

<script src="static/js/WorkFile/work_add.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>