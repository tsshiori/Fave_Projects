<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Bean.workBean" %>
<%@ page import="utils.Bean.userBean" %>
<!-- workBean クラスのパッケージに合わせて変更 -->
<%
    // worklistをJSPに渡す
    ArrayList<workBean> worklist = (ArrayList<workBean>) session.getAttribute("worklist");
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
    <link rel="stylesheet" href="static/css/WorkFile/work.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>WORK | Time of Fave.</title>
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
        <a href="work_add"><img class="add" src="static/img/ADD.png" alt="add"></a>

        <div class="scroll-content">
            <%
                // worklistが空でない場合のみ処理を実行
                if (worklist != null && !worklist.isEmpty()) {
                    // mainwork のアイテムを先に描画
                    for (workBean work : worklist) {
                        if (work.getWork_id() == mainwork) {
            %>
            <div class="shift_roop mainwork">
                <div class="container mainwork">
                    <div class="vertical-line"></div>
                    <span class="work_name"><%= work.getWork() %></span> <!-- workの名前 -->
                    <div class="timemoney">¥ <%= work.getHourlywage() %></div> <!-- 時給 -->
                    <div class="img_icons container">
                        <div class="img_icon">
                            <a href="work_edit?work_id=<%= work.getWork_id() %>">
                                <img src="static/img/EDIT2.png">
                            </a>
                        </div> <!-- 編集ボタン -->
                        <div class="img_icon">
                            <a href="#" class="deleteButton"
                               data-work-id="<%= work.getWork_id() %>"
                               data-mainwork="true"
                               data-work-name="<%= work.getWork() %>"
                               data-hourlywage="<%= work.getHourlywage() %>">
                                <img src="static/img/DELE2.png">
                            </a>
                        </div>
                        <!-- 削除ボタン -->
                    </div>
                </div>
            </div>
            <br>
            <%
                    }
                }

                // 残りのアイテムを描画
                for (workBean work : worklist) {
                    if (work.getWork_id() != mainwork) {
            %>
            <div class="shift_roop">
                <div class="container">
                    <div class="vertical-line"></div>
                    <span class="work_name"><%= work.getWork() %></span> <!-- workの名前 -->
                    <div class="timemoney">¥ <%= work.getHourlywage() %></div> <!-- 時給 -->
                    <div class="img_icons container">
                        <div class="img_icon">
                            <a href="work_edit?work_id=<%= work.getWork_id() %>">
                                <img src="static/img/EDIT2.png">
                            </a>
                        </div> <!-- 編集ボタン -->
                        <div class="img_icon">
                            <a href="#" class="deleteButton"
                               data-work-id="<%= work.getWork_id() %>"
                               data-mainwork="false"
                               data-work-name="<%= work.getWork() %>"
                               data-hourlywage="<%= work.getHourlywage() %>">
                                <img src="static/img/DELE2.png">
                            </a>
                        </div>
                        <!-- 削除ボタン -->
                    </div>
                </div>
            </div>
            <br>
            <%
                        }
                    }
                }
            %>
        </div>

    </div>
</div>

<!-- モーダルウィンドウ -->
<div id="modal1" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>削除できません。</h3>
            <h4 class="modal-h4">※ このバイト先はメイン設定されています。</h4>
        </div>
        <div class="modal-body">
            <button id="cancelDelete1" type="button" class="btn close">閉じる</button>
        </div>
    </div>
</div>

<div id="modal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>本当に削除しますか？</h3>
            <h4 class="modal-h4">※消した後は二度と元に戻せません。</h4>
            <div>
                <div class="container kome">
                    <h4 class="ko">バイト先名：</h4>
                    <h4 class="me"></h4> <!-- 動的に挿入されるバイト先名 -->
                </div>
                <div class="container kome">
                    <h4 class="ko">時給(円)：</h4>
                    <h4 class="me"></h4> <!-- 動的に挿入される時給 -->
                </div>
            </div>
        </div>
        <div class="modal-body">
            <form id="deleteForm" action="WorkDeleteServlet" method="POST" style="display:none;">
                <input type="hidden" id="workIdInput" name="work_id">
            </form>

            <button id="confirmDelete1" type="button" class="btn">削除</button>
            <button id="cancelDelete2" type="button" class="btn">キャンセル</button>
        </div>
    </div>
</div>


<script src="static/js/WorkFile/work.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>