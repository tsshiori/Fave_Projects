
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <link rel="stylesheet" href="../../all.css">
    <link rel="stylesheet" href="goods_edit.css">

    <link rel="shortcut icon" href="../../img/Time for Fave.png">
    <title>Goods_Edit | Time of Fave.</title>
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
            <a href="../../index/index.html">
                <h3>HOME</h3>
            </a>
        </div>
        <hr>
        <div class="fave">
            <a href="../../FaveFile/fave/fave.html">
                <h3>FAVE</h3>
            </a>
        </div>
        <hr>
        <div class="relate">
            <a href="../../FaveFile/relate/relate.html">
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
            <a href="../../MypageFile/mypage/mypage.html">
                <h3>MYPAGE</h3>
            </a>
        </div>
        <br><br>
    </aside>

    <div class="main scroll-box">
        <div class="toggle-container">
            <label for="switch" class="switch_label">
                <div class="switch">
                    <input type="checkbox" id="switch" />
                    <div class="base">
                        <div class="circle"></div>
                    </div>
                </div>
                <span class="title">グッズ</span>
            </label>
            <p class="note">※ ＊は必須項目です。</p>
        </div>
        <br><br>
        <div id="goods" class="scroll-content group content-item active">
            <form action="../goods/goods.html">
                <div class="form-group input-container">
                    <label><span class="req">＊</span> 日付：</label>
                    <input type="date" id="date" class="pl" onfocus="hidePlaceholder(this)"
                           onblur="showPlaceholder(this)">
                    <span class="date-text">日付を入力してください。</span>
                </div>

                <div class="form-group">
                    <label ><span class="req">＊</span> グッズ名：</label>
                    <input type="text" class="goods_name" name="goods_name" placeholder="グッズの名前を入力してください。" required>
                </div>

                <div class="form-group">
                    <label><span class="req">＊</span> 金額(円)：</label>
                    <input type="text" class="amount" name="amount" placeholder="グッズの金額を入力してください。" required>
                </div>

                <div class="form-group">
                    <label class="favo"><span class="req">＊</span> 推し：</label>
                    <select id="menu" name="menu">
                        <option value="" disabled selected hidden>推しを選択してください。</option>
                        <option value="option1">カンパネルラ</option>
                        <option value="option2">ミューズ</option>
                    </select>
                    <!-- グッズ用プラスボタン -->
                    <div id="plusButtonGoods" class="btn-plus">
                        <button class="plus" type="button">
                            <img src="../../img/plus.png" alt="plus">
                        </button>
                    </div>
                </div>

                <div class="form-group">
                    <div class="icon container">
                        <label>
                            <input type="radio" name="icon" value="0" checked>
                            <img src="../../img/Y_A.png" alt="a">
                        </label>
                        <label>
                            <input type="radio" name="icon" value="1">
                            <img src="../../img/Y_B.png" alt="b">
                        </label>
                        <label>
                            <input type="radio" name="icon" value="2">
                            <img src="../../img/Y_C.png" alt="c">
                        </label>
                        <label>
                            <input type="radio" name="icon" value="3">
                            <img src="../../img/Y_D.png" alt="d">
                        </label>
                        <label>
                            <input type="radio" name="icon" value="4">
                            <img src="../../img/Y_E.png" alt="e">
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="memo-label">メモ：</label>
                    <textarea class="memo" name="memo" placeholder="メモを入力してください。"></textarea>
                </div>
                <br>
                <div class="form-group">
                    <label >購入済：</label>
                    <input type="checkbox" class="purchased" name="purchased"><span
                        class="small-text">※購入済みの場合はチェックを入れてください。</span>
                </div>

                <div class="form-group">
                    <div class="btn">
                        <button id="modalOpenGoods" type="button" class="in">追加</button>
                        <a class="kyan" href="../../index/index.html">キャンセル</a>
                    </div>
                </div>
            </form>
        </div>
        <div id="events" class="group content-item">
            <form action="../goods/goods.html">
                <div class="form-group input-container">
                    <label><span class="req">＊</span> 日付：</label>
                    <input type="date" id="event-date" class="pl" onfocus="hidePlaceholder(this)"
                           onblur="showPlaceholder(this)">
                    <span class="date-text">日付を入力してください。</span>
                </div>

                <div class="form-group">
                    <label><span class="req">＊</span> イベント名：</label>
                    <input type="text" class="goods_name" name="goods_name" placeholder="イベントの名前を入力してください。"
                           required>
                </div>

                <div class="form-group">
                    <label><span class="req">＊</span> 金額(円)：</label>
                    <input type="text" class="amount" name="amount" placeholder="イベントの金額を入力してください。" required>
                </div>

                <div class="form-group">
                    <label class="favo" ><span class="req">＊</span> 推し：</label>
                    <select id="menu" name="menu">
                        <option value="" disabled selected hidden>推しを選択してください。</option>
                        <option value="option1">カンパネルラ</option>
                        <option value="option2">ミューズ</option>
                    </select>
                    <!-- イベント用プラスボタン -->
                    <div id="plusButtonEvents" class="btn-plus">
                        <button class="plus" type="button">
                            <img src="../../img/plus.png" alt="plus">
                        </button>
                    </div>

                </div>

                <div class="form-group">
                    <div class="icon container">
                        <label>
                            <input type="radio" name="icon" value="0" checked>
                            <img src="../../img/Y_A.png" alt="a">
                        </label>
                        <label>
                            <input type="radio" name="icon" value="1">
                            <img src="../../img/Y_B.png" alt="b">
                        </label>
                        <label>
                            <input type="radio" name="icon" value="2">
                            <img src="../../img/Y_C.png" alt="c">
                        </label>
                        <label>
                            <input type="radio" name="icon" value="3">
                            <img src="../../img/Y_D.png" alt="d">
                        </label>
                        <label>
                            <input type="radio" name="icon" value="4">
                            <img src="../../img/Y_E.png" alt="e">
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="memo-label">メモ：</label>
                    <textarea class="memo" name="memo" placeholder="メモを入力してください。"></textarea>
                </div>
                <br>
                <div class="form-group">
                    <label>購入済：</label>
                    <input type="checkbox" class="purchased" name="purchased"><span
                        class="small-text">※参加済みの場合はチェックを入れてください。</span>
                </div>

                <div class="form-group">
                    <div class="btn">
                        <button id="modalOpenEvents" type="button" class="in">追加</button>
                        <a class="kyan" href="../../index/index.html">キャンセル</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div id="easyModalGoods" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h1>以下の内容でよろしいですか？</h1>
        </div>
        <div class="modal-body">
            <table>
                <tr>
                    <th>日付：</th>
                    <td>2025/1/11</td>
                </tr>
                <tr>
                    <th>グッズ名：</th>
                    <td>銀河鉄道の夜　28巻</td>
                </tr>
                <tr>
                    <th>金額(円)：</th>
                    <td>￥865</td>
                </tr>
                <tr>
                    <th>推し：</th>
                    <td>カンパネルラ</td>
                </tr>
                <tr>
                    <th>優先度：</th>
                    <td><img src="../../img/Y_B.png" alt="b"></td>
                </tr>
                <tr>
                    <th>メモ：</th>
                    <td>カンパネルラが表紙！！！！！！</td>
                </tr>
                <tr>
                    <th>購入済：</th>
                    <td><input type="checkbox" class="text">
                        <span class="text">※購入済みの場合はチェックを入れてください。</span>
                    </td>
                </tr>

            </table>
            <button id="confirmReGoods" type="button" class="btn2">追加</button>
            <button id="cancelReGoods" type="button" class="btn2">キャンセル</button>
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
                    <td>2026/1/1</td>
                </tr>
                <tr>
                    <th>イベント名：</th>
                    <td>Meteor</td>
                </tr>
                <tr>
                    <th>金額(円)：</th>
                    <td>￥10,200</td>
                </tr>
                <tr>
                    <th>推し：</th>
                    <td>ミューズ</td>
                </tr>
                <tr>
                    <th>優先度：</th>
                    <td><img src="../../img/Y_B.png" alt="b"></td>
                </tr>
                <tr>
                    <th>メモ：</th>
                    <td>11:45分から！！！</td>
                </tr>
                <tr>
                    <th>参加済：</th>
                    <td><input type="checkbox" class="text">
                        <span class="text">※参加済みの場合はチェックを入れてください。</span>
                    </td>
                </tr>

            </table>
            <button id="confirmReEvents" type="button" class="btn2">追加</button>
            <button id="cancelReEvents" type="button" class="btn2">キャンセル</button>
        </div>
    </div>
</div>


<!-- プラスボタンのモーダル -->
<div id="modal" class="modalbody">
    <span class="close" id="closeModal">&times;</span>
    <div class="modal-content2">
        <div class="modal-header">
            <h1>推しの追加</h1>
        </div>
        <form id="plusForm">
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
        <form id="plusFormEvents">
            <div class="modal-group">
                <label class="osi">推しの名前：</label>
                <input type="text" class="modalosi" name="modalosi" placeholder="推しを入力してください。">
            </div>
            <div class="modealbtn">
                <button id="AddEvents" type="button" class="btn3">追加</button>
                <button id="ReEvents" type="button" class="btn3">キャンセル</button>
            </div>
        </form>
    </div>
</div>


<script src="static/js/goods_edit.js"></script>
<script src="static/js/all.js"></script>
</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
