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
        <div class="head_btn">
            <a href="../shift_add/shift_add.html" class="a"><img class="add" src="static/img/ADD.png" alt="add"></a>

            <!-- モーダルを開くためのボタン -->
            <div class="container_btn">
                <button type="button" id="modalOpen" class="btn">一括追加はこちら</button>
            </div>

        </div>



        <div class="scroll-content">
            <div class="shift_roop">
                <div class="container">
                    <div class="vertical-line"></div>
                    <span class="date">9/18(水)</span>
                    <span class="work_name">まいにちマート</span>
                    <div class="time-container">
                        <span class="time">9:00</span>
                        <span class="time">15:00</span>
                    </div>
                    <div class="img_icon"><a href="../shift_edit/shift_edit.html"><img
                            src="static/img/EDIT2.png"></a></div>
                    <div class="img_icon" id="deleteButton"><a href="#"><img src="static/img/DELE2.png"></a></div>
                </div>
            </div>

            <br>

            <div class="shift_roop">
                <div class="container">
                    <div class="vertical-line"></div>
                    <span class="date">9/19(木)</span>
                    <span class="work_name">まいにちマート</span>
                    <div class="time-container">
                        <span class="time">12:00</span>
                        <span class="time">18:00</span>
                    </div>
                    <div class="img_icon"><a href="#"><img src="../../img/EDIT2.png"></a></div>
                    <div class="img_icon"><a href="#"><img src="../../img/DELE2.png"></a></div>
                </div>
            </div>

            <br>

            <div class="shift_roop">
                <div class="container">
                    <div class="vertical-line"></div>
                    <span class="date">9/22(日)</span>
                    <span class="work_name">まいにちマート</span>
                    <div class="time-container">
                        <span class="time">10:00</span>
                        <span class="time">18:00</span>
                    </div>
                    <div class="img_icon"><a href="#"><img src="../../img/EDIT2.png"></a></div>
                    <div class="img_icon"><a href="#"><img src="../../img/DELE2.png"></a></div>
                </div>
            </div>

            <br>

            <div class="shift_roop">
                <div class="container">
                    <div class="vertical-line"></div>
                    <span class="date">9/24(火)</span>
                    <span class="work_name">まいにちマート</span>
                    <div class="time-container">
                        <span class="time">9:00</span>
                        <span class="time">15:00</span>
                    </div>
                    <div class="img_icon"><a href="#"><img src="../../img/EDIT2.png"></a></div>
                    <div class="img_icon"><a href="#"><img src="../../img/DELE2.png"></a></div>
                </div>
            </div>
        </div>



    </div>
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

<div id="easyModal3" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>以下の内容で追加しますか？</h3>
        </div>

        <div class="modal-body">
            <div class="ikkatu">
                <p>2024/9/25 (水) 9:00,2024/9/25 (水) 14:00,0</p>
                <p>2024/9/27 (金) 9:00,2024/9/27 (金) 15:00,45</p>
                <p>2024/9/30 (月) 12:00,2024/9/25 (月) 18:00,45</p>
                <p>2024/10/1 (火) 9:00,2024/10/1 (火) 14:00,0</p>
                <p>2024/10/2 (水) 9:00,2024/10/2 (水) 14:00,0</p>
                <p>2024/10/5 (土) 17:00,2024/10/5 (土) 22:00,0</p>
                <p>2024/10/7 (月) 22:00,2024/10/8 (火) 5:00,45</p>
                <p>2024/10/9 (水) 17:00,2024/10/9 (水) 22:00,0</p>
                <p>2024/10/10 (木) 9:00,2024/10/10 (火) 14:00,0</p>
            </div>
            <!-- モーダル内の削除を確定するボタン -->
            <button id="confirmDelete3" type="button" class="btn">登録</button>
            <button id="cancelDelete3" type="button" class="btn">キャンセル</button>
        </div>
    </div>
</div>





<!-- モーダルウィンドウ -->
<div id="easyModal2" class="modal">
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
            <!-- モーダル内の削除を確定するボタン -->
            <button id="confirmDelete2" type="button" class="btn">削除</button>
            <button id="cancelDelete2" type="button" class="btn">キャンセル</button>
        </div>
    </div>
</div>

<script src="static/js/ShiftFile/shift.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
