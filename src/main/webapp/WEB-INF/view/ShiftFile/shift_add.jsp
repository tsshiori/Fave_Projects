<%@ page import="utils.Bean.workBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Bean.userBean" %><%--
  Created by IntelliJ IDEA.
  User: hrnea
  Date: 2024/11/22
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    userBean user = (userBean) session.getAttribute("user");
    String log_id = user.getLog_id();
    ArrayList<workBean> worklist = (ArrayList<workBean>) session.getAttribute("worklist");
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
    <link rel="stylesheet" href="static/css/ShiftFile/shift_add.css">
    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>SHIFT_Add | Time of Fave.</title>
</head>

<body class="SHIFT">
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
            <form action="ShiftAddServlet" method="post" id="shift_add_form">
                <table>
                    <tr>
                        <th><span>＊</span> バイト先 :</th>
                        <td>
                            <select id="menu" name="work_id">
                                <option value="" disabled selected hidden>バイト先を選択してください</option>
                                <%
                                    if (worklist != null && !worklist.isEmpty()) {
                                        for (workBean work : worklist) {
                                %>
                                <option value="<%= work.getWork_id() %>" data-wage="<%= work.getHourlywage() %>">
                                    <%= work.getWork() %>
                                </option>
                                <%
                                    }
                                } else {
                                %>
                                <option value="-1" disabled>バイト先が未登録</option>
                                <%
                                    }
                                %>
                            </select>



                        </td>
                        <td class="img">
                            <a href="work_add">
                                <img class="plus" src="static/img/plus.png">
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th><span>＊</span> 開始 :</th>
                        <td class="input-container">
                            <input type="datetime-local" id="start-time" class="pl-input" onfocus="hidePlaceholder(this)" onblur="showPlaceholder(this)" name="startdatetime" required>
                            <span class="pl-placeholder">開始時間を入力してください</span>
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
                        <th><span>＊</span> 終了 :</th>
                        <td class="input-container">
                            <input type="datetime-local" id="end-time" class="pl-input" onfocus="hidePlaceholder(this)" onblur="showPlaceholder(this)" name="enddatetime" required>
                            <span class="pl-placeholder">終了時間を入力してください</span>
                        </td>
                    </tr>

                    <tr>
                        <th><span>＊</span> 休憩 :</th>
                        <td>
                            <input type="number" min="0" required placeholder="休憩時間(分)を入力してください。" name="breaktime">
                        </td>
                    </tr>
                    <tr>
                    <tr>
                        <th><span>＊</span> 時給(円) :</th>
                        <td>
                            <input type="text" id="wage" name="wage" placeholder="バイト先項目でバイト先を選択してください。" readonly>
                        </td>
                        <td>
                            <button id="modalOpenzikyu" type="button" class="zikyu">時給を変更</button>
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="zikyu-change" value="-1">
                <div class="btn">
                    <button id="modalOpen" type="button" class="in">追加</button>
                    <a class="kyan" href="shift">キャンセル</a>
                </div>
            </form>

        </div>
    </div>
</div>

<div id="easyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h1>以下の内容で追加しますか？</h1>
        </div>
        <div class="modal-body">
            <table>
                <tr>
                    <td>バイト先 : </td>
                    <td class="value">未選択</td>
                </tr>
                <tr>
                    <td>開始 : </td>
                    <td class="value">未入力</td>
                </tr>
                <tr>
                    <td>終了 : </td>
                    <td class="value">未入力</td>
                </tr>
                <tr>
                    <td>休憩 : </td>
                    <td class="value">未入力</td>
                </tr>
                <tr>
                    <td>時給(円) : </td>
                    <td class="value">未入力</td>
                </tr>
            </table>
            <button id="confirmRe" type="button" class="btn2">追加</button>
            <button id="cancelRe" type="button" class="btn2">キャンセル</button>
        </div>
    </div>
</div>


<div id="easyModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <form action="ZikyuEditServlet" method="post" id="zikyu-edit">
                <h1>時給の変更</h1>
                <br>
                <!-- 時給を変更可能にする -->
                <input type="number" class="modal-input" name="newWage" value="900" required><span>円</span><br>

                <!-- ラジオボタン -->
                <div class="radio">
                    <div class="radio-con">
                        <input type="radio" id="zikyu-change-1" name="zikyu-change" value="1" required>
                        <label for="zikyu-change-1">今回のシフトだけ変更</label>
                    </div>
                    <div class="radio-con">
                        <input type="radio" id="zikyu-change-2" name="zikyu-change" value="2">
                        <label for="zikyu-change-2">今回以降の日付のシフトと、<br>バイト先情報の時給も変更</label>
                    </div>
                </div>
            </form>
        </div>
        <div class="modal-body">
            <button id="confirmRe2" type="button" class="btn2">完了</button>
            <button id="cancelRe2" type="button" class="btn2">キャンセル</button>
        </div>
    </div>
</div>




<script src="static/js/ShiftFile/shift_add.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>