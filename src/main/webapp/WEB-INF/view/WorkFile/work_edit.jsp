<%@ page import="utils.Bean.workBean" %>
<%@ page import="utils.Bean.userBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<%
    // リクエストパラメータから `work_id` を取得
    int work_id = Integer.parseInt(request.getParameter("work_id"));
    workBean worklist = utils.DAO.workDAO.selectWork(work_id);

    // workBean から値を取得
    String work = worklist != null ? worklist.getWork() : "";
    int hourlywage = worklist != null ? worklist.getHourlywage() : 0;

    userBean user = (userBean) session.getAttribute("user");
    int mainwork = user.getMainwork();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+JP:wght@200..900&family=Yuji+Syuku&display=swap"
          rel="stylesheet">

    <link rel="stylesheet" href="static/css/all.css">
    <link rel="stylesheet" href="static/css/WorkFile/work_edit.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>WORK_Edit | Time of Fave.</title>
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
        <div class="scroll-content">
            <p class="hissu p">※ ＊は必須項目です。</p>
            <form action="WorkEditServlet" method="post" id="work_edit_form">
                <input type="hidden" name="work_id" value="<%= work_id %>"> <!-- work_id を送信 -->
                <table>
                    <tr>
                        <th><span>＊</span> バイト先 :</th>
                        <td>
                            <!-- プレースホルダーを設定 -->
                            <input type="text" name="work" value="" placeholder="<%= work %>" id="work_input">
                        </td>
                    </tr>
                    <tr>
                        <th><span>＊</span> 時給(円) :</th>
                        <td>
                            <!-- プレースホルダーを設定 -->
                            <input type="number" name="hourlywage" value="" placeholder="<%= hourlywage %>" id="hourlywage_input">
                        </td>
                    </tr>
                    <tr>
                        <th>メイン設定 :</th>
                        <td>
                            <input type="checkbox" name="main" <%= (mainwork == work_id) ? "checked" : "" %>>
                            <span class="small-text">※ メインのバイト先にする場合はチェックを入れてください。</span>
                        </td>
                    </tr>
                </table>
                <div class="btn">
                    <button type="submit" class="in">完了</button>
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
            <h3>以下の内容で編集しますか？</h3>
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
            <button id="confirmDelete" type="button" class="btn">完了</button>
            <button id="cancelDelete" type="button" class="btn">キャンセル</button>
        </div>
    </div>
</div>

<script src="static/js/WorkFile/work_edit.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
