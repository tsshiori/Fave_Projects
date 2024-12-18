<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="utils.Bean.shiftBean" %>
<%
    // シフトデータをセッションから取得
    ArrayList<shiftBean> shiftList = (ArrayList<shiftBean>) session.getAttribute("shiftList");

    // 現在の日付と時刻を取得
    LocalDate now = LocalDate.now();
    LocalDateTime startOfDay = now.atStartOfDay();  // 日付から00:00:00のLocalDateTimeを取得

    // すべてのシフトを昇順でソート
    List<shiftBean> allShifts = shiftList.stream()
            .sorted((a, b) -> a.getStartdatetime().compareTo(b.getStartdatetime()))  // 昇順にソート
            .collect(Collectors.toList());


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
    <link rel="stylesheet" href="static/css/ShiftFile/shift.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>SHIFT | Time of Fave.</title>
</head>

<body class="SHIFT">
<div class="container con up">
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

        <div class="main scroll-box" id="shiftContainer">
            <div class="head_btn">
                <a href="shift_add" class="a"><img class="add" src="static/img/ADD.png" alt="add"></a>

<%--                <!-- モーダルを開くためのボタン -->--%>
<%--                <div class="container_btn">--%>
<%--                    <button type="button" id="modalOpen" class="btn">一括追加はこちら</button>--%>
<%--                </div>--%>

            </div>
            <div class="scroll-content">
                <%
                    // ソートされたシフトリストを表示
                    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd (E)");
                    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

                    for (shiftBean shift : allShifts) {
                        String startDate = shift.getStartdatetime().format(dateFormatter);
                        String startTime = shift.getStartdatetime().format(timeFormatter);
                        String endTime = shift.getEnddatetime().format(timeFormatter);
                %>
                <!-- 削除モーダル -->
                <div id="easyModal_<%= shift.getShift_id() %>" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3>本当に削除しますか？</h3>
                            <div class="modal-h4">
                                <h4>※消した後は二度と元に戻せません。</h4>
                            </div>
                        </div>

                        <div class="modal-body">
                            <table>
                                <tr>
                                    <td>バイト先 : </td>
                                    <td class="value"><%= shift.getWork_name() %></td>
                                </tr>
                                <tr>
                                    <td>開始 : </td>
                                    <td class="value"><%= shift.getStartdatetime().format(dateFormatter) %> <%= shift.getStartdatetime().format(timeFormatter) %></td>
                                </tr>
                                <tr>
                                    <td>終了 : </td>
                                    <td class="value"><%= shift.getEnddatetime().format(dateFormatter) %> <%= shift.getEnddatetime().format(timeFormatter) %></td>                                </tr>
                                <tr>
                                    <td>休憩時間 : </td>
                                    <td class="value"><%= shift.getBreaktime() %></td>
                                </tr>
                                <tr>
                                    <td>時給 : </td>
                                    <td class="value"><%= shift.getWage()%></td>
                                </tr>

                            </table>
                            <form id="deleteForm" action="ShiftDeleteServlet" method="POST" style="display:none;">
                                <input type="hidden" id="shiftIdInput" name="shift_id">
                            </form>

                            <button class="confirmDeleteButton" data-shift-id="<%= shift.getShift_id() %>">削除</button>
                            <button class="cancelDeleteButton" data-shift-id="<%= shift.getShift_id() %>">キャンセル</button>
                        </div>
                    </div>
                </div>
                <!-- シフト表示 -->
                <div class="shift_roop">
                    <div class="container">
                        <div class="vertical-line"></div>
                        <span class="date"><%= startDate %></span>
                        <span class="work_name"><%= shift.getWork_name() %></span>
                        <div class="time-container">
                            <span class="time"><%= startTime %></span><span class="time"><%= endTime %></span>
                        </div>
                        <div class="img_icons container">
                            <div class="img_icon">
                                <a href="shift_edit?shift_id=<%= shift.getShift_id() %>">
                                    <img src="static/img/EDIT2.png">
                                </a>
                            </div>
                            <div class="img_icon">
                                <a href="#" class="deleteButton" data-shift-id="<%= shift.getShift_id() %>">
                                    <img src="static/img/DELE2.png">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>







<!-- モーダルウィンドウ -->
<div id="easyModal" class="modal">
    <div class="modal-content1">
        <div class="modal-header">
            <h3>シフトの一括追加</h3>
            <div class="modal-h4">
                <h4>※CSVによる一括追加のみ対応しています。</h4>
            </div>
        </div>

        <form id="myForm" action="#" method="get">
            <label for="menu" class="modal_title">バイト先 :</label>
            <select id="menu" name="menu">
                <option value="" disabled selected hidden>バイト先を選択してください</option>
                <option value="option1">まいにちマート</option>
                <option value="option2">茎わかめファクトリー</option>
            </select>
            <br>
            <!-- カスタムファイル選択ボタン -->
            <div class="container">
                <div class="aaa container">
                    <div class="modal_title">ファイル : </div>
                    <label class="custom-file-select" for="fileInput" id="fileLabel">
                        ファイルを選択してください <!-- プレースホルダー -->
                    </label>
                </div>
                <!-- 非表示のファイル選択フィールド -->
                <input type="file" id="fileInput" onchange="updateFileName()">

            </div>

        </form>

        <div class="modal-body">
            <!-- モーダル内の削除を確定するボタン -->
            <button id="confirmDelete" type="button" class="btn">登録</button>
            <button id="cancelDelete" type="button" class="btn">キャンセル</button>
        </div>
    </div>
</div>

<%--<div id="easyModal3" class="modal">--%>
<%--    <div class="modal-content">--%>
<%--        <div class="modal-header">--%>
<%--            <h3>以下の内容で追加しますか？</h3>--%>
<%--        </div>--%>

<%--        <div class="modal-body">--%>
<%--            <div class="ikkatu">--%>
<%--                <p>2024/9/25 (水) 9:00,2024/9/25 (水) 14:00,0</p>--%>
<%--                <p>2024/9/27 (金) 9:00,2024/9/27 (金) 15:00,45</p>--%>
<%--                <p>2024/9/30 (月) 12:00,2024/9/25 (月) 18:00,45</p>--%>
<%--                <p>2024/10/1 (火) 9:00,2024/10/1 (火) 14:00,0</p>--%>
<%--                <p>2024/10/2 (水) 9:00,2024/10/2 (水) 14:00,0</p>--%>
<%--                <p>2024/10/5 (土) 17:00,2024/10/5 (土) 22:00,0</p>--%>
<%--                <p>2024/10/7 (月) 22:00,2024/10/8 (火) 5:00,45</p>--%>
<%--                <p>2024/10/9 (水) 17:00,2024/10/9 (水) 22:00,0</p>--%>
<%--                <p>2024/10/10 (木) 9:00,2024/10/10 (火) 14:00,0</p>--%>
<%--            </div>--%>
<%--            <!-- モーダル内の削除を確定するボタン -->--%>
<%--            <button id="confirmDelete3" type="button" class="btn">登録</button>--%>
<%--            <button id="cancelDelete3" type="button" class="btn">キャンセル</button>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>







<script src="static/js/ShiftFile/shift.js"></script>
<script src="static/js/all.js"></script>

</div>
</div> <!-- ここで閉じる -->
</div> <!-- main scroll-boxを閉じる -->

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
