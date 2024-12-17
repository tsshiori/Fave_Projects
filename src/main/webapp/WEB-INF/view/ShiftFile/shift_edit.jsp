<%--
  Created by IntelliJ IDEA.
  User: hrnea
  Date: 2024/11/22
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+JP:wght@200..900&family=Yuji+Syuku&display=swap" rel="stylesheet">
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

    <div class="main scroll-box">
        <div class="scroll-content">
            <p class="hissu p">※ ＊は必須項目です。</p>
            <form action="ShiftEditServlet" method="post" id="shift_edit_form">
                <table>
                    <tr>
                        <th><span>＊</span> バイト先 :</th>
                        <td><select id="menu" name="menu">
                            <option value="" disabled selected hidden>バイト先を選択してください</option>
                            <option value="option1">まいにちマート</option>
                            <option value="option2">茎わかめファクトリー</option>
                        </select>
                        </td>
                        <td class="img">
                            <a href="../../WorkFile/work_add/work_add.html">
                                <img class="plus" src="static/img/plus.png">
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th><span>＊</span> 開始 :</th>
                        <td class="input-container">
                            <input type="datetime-local" id="start-time" class="pl-input" onfocus="hidePlaceholder(this)" onblur="showPlaceholder(this)">
                            <span class="pl-placeholder">開始時間を入力してください</span>
                        </td>
                    </tr>


                    <tr>
                        <th><span>＊</span> 終了 :</th>
                        <td class="input-container">
                            <input type="datetime-local" id="end-time" class="pl-input" onfocus="hidePlaceholder(this)" onblur="showPlaceholder(this)">
                            <span class="pl-placeholder">終了時間を入力してください</span>
                        </td>
                    </tr>

                    <tr>
                        <th><span>＊</span> 休憩 :</th>
                        <td>
                            <input type="number" min="0" placeholder="休憩時間(分)を入力してください。">
                        </td>
                    </tr>
                    <tr>
                        <th class="zikyu-color"> 時給(円) :</th>
                        <td>
                            <input type="text" min="0" placeholder="バイト先項目でバイト先を選択してください。" readonly>
                        </td>
                        <td>
                            <button id="modalOpenzikyu" type="button" class="zikyu">時給を変更</button>
                        </td>
                    </tr>
                </table>
                <div class="btn">
                    <button id="modalOpen" type="button" class="in">完了</button>
                    <a class="kyan" href="shift">キャンセル</a>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="easyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h1>以下の内容で編集しますか？</h1>
        </div>
        <div class="modal-body">
            <table>
                <tr>
                    <td>バイト先 : </td>
                    <td class="value">まいにちマート</td>
                </tr>
                <tr>
                    <td>開始 : </td>
                    <td class="value">2024/9/25 (水) 9:00</td>
                </tr>
                <tr>
                    <td>終了 : </td>
                    <td class="value">2024/9/25 (水) 14:00</td>
                </tr>
                <tr>
                    <td>休憩 : </td>
                    <td class="value">なし</td>
                </tr>
                <tr>
                    <td>時給(円) : </td>
                    <td class="value">￥900</td>
                </tr>
            </table>
            <button id="confirmRe" type="button" class="btn2">完了</button>
            <button id="cancelRe" type="button" class="btn2">キャンセル</button>
        </div>
    </div>
</div>

<div id="easyModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h1>時給の変更</h1>
            <h4>バイト先 : まいにちマート</h4>
            <input type="number" class="modal-input" value="900" readonly><span>円</span><br>

            <div class="radio">
                <div class="radio-con">
                    <input type="radio" id="zikyu-change-1" name="zikyu-change" value="1">
                    <label for="zikyu-change-1">今回のシフトだけ変更</label>
                </div>
                <div class="radio-con">
                    <input type="radio" id="zikyu-change-2" name="zikyu-change" value="2">
                    <label for="zikyu-change-2">今日以降の日付のシフトと、<br>バイト先情報の時給も変更</label>
                </div>
            </div>

        </div>
        <div class="modal-body">
            <button id="confirmRe2" type="button" class="btn2">完了</button>
            <button id="cancelRe2" type="button" class="btn2">キャンセル</button>
        </div>
    </div>
</div>

<script src="static/js/ShiftFile/shift_edit.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
