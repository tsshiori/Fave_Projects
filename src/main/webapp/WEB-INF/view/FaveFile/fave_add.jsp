<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");

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
    <link rel="stylesheet" href="static/css/FaveFile/fave_add.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>FAVE_Add | Time of Fave.</title>
</head>

<body class="FAVE">
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
        <p class="hissu p">※ ＊は必須項目です。</p>
        <div class="scroll-content">
            <form id="fadd_form" action="FaveAdd" method="post">
                <div class="container">
                    <div class="left_t">
                        <div class="left">
                            <div class="f_img">
                                <img src="static/img/def.png" alt="defo" id="preview">
                            </div>
                        </div>

                        <div class="container">
                            <div class="aaa container">
                                <label class="custom-file-select" for="fileInput" id="fileLabel">
                                    　画像のアップロード
                                </label>
                            </div>
                            <!-- 非表示のファイル選択フィールド -->
                            <input type="file" name="img" id="fileInput" onchange="updateFileName()" accept="image/*">
                        </div>
                    </div>

                    <div class="right">
                        <table>
                            <tr>
                                <th><span class="hissu">＊</span>名前：</th>
                                <td><input type="text" name="name" placeholder="名前を入力してください。"><br>
                                <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
                                </td>
                            </tr>
                            <tr>
                                <th>誕生日：</th>
                                <td>
                                    <div class="form-group input-container">
                                        <input type="date" id="event-date" class="pl" name="birthday"
                                               onfocus="hidePlaceholder(this)" onblur="showPlaceholder(this)">
                                        <span class="date-text">日付を入力してください。</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <div class="categori0 container">
                                        <div class="categori1">
                                            <p>所属 /<br>
                                                関連プロジェクト 等</p>
                                        </div>
                                        <div class="categori2">：</div>
                                    </div>
                                </th>
                                <td>
                                    <div class="container cc">
                                        <form action="categoryServlet" method="post">
                                            <select name="cate_id" id="categorySelect" onchange="sendCategoryId()">
                                                <option value="" disabled selected>所属/関連プロジェクトを選択してください。</option>
                                                <% if (categorylist != null) { %>
                                                <% for (categoryBean category : categorylist) { %>
                                                <option value="<%= category.getCate_id() %>"><%= category.getCategory() %></option>
                                                <% } %>
                                                <% } else { %>
                                                <option value="-1" disabled>カテゴリ未登録</option>
                                                <% } %>
                                            </select>
                                        </form>
                                        <!-- イベント用プラスボタン -->
                                        <div id="plusButtonCon" class="btn-plus">
                                            <button class="plus2" type="button">
                                                <img src="static/img/plus.png" alt="plus">
                                            </button>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <div class="categori0 container">
                                        <div class="categori1">
                                            <p>曲 /<br>
                                                チーム / 組名 等</p>
                                        </div>
                                        <div class="categori2">：</div>
                                    </div>
                                </th>
                                <td>
                                    <div class="container cc">
                                        <select class="tab" name="tab1" disabled>
                                            <option value="1" disabled selected>曲/チーム/組名等を選択してください。</option>

                                            <option value="3">STAR★BURST★SHIP</option>
                                        </select>
                                        <!-- イベント用プラスボタン -->
                                        <div class="btn-plus plusButtonTab">
                                            <button class="plus3" type="button" disabled>
                                                <img src="static/img/plus.png" alt="plus">
                                            </button>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <div class="categori0 container">
                                        <div class="categori1">
                                            <p>　</p>
                                        </div>
                                        <div class="categori2">　</div>
                                    </div>
                                </th>
                                <td>
                                    <div class="cc">
                                        <select class="tab" name="tab2" disabled>
                                            <option value="1" disabled selected>曲/チーム/組名等を選択してください。</option>
                                            <option value="2">銀河鉄道の夜</option>
                                            <option value="3">STAR★BURST★SHIP</option>
                                        </select>

                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <div class="categori0 container">
                                        <div class="categori1">
                                            <p>
                                                ※ 最大５個まで<br>
                                                選択できます。
                                            </p>
                                        </div>
                                        <div class="categori2">　</div>
                                    </div>
                                </th>
                                <td>
                                    <div class="cc">
                                        <select class="tab" name="tab3" disabled>
                                            <option value="1" disabled selected>曲/チーム/組名等を選択してください。</option>
                                            <option value="2">銀河鉄道の夜</option>
                                            <option value="3">STAR★BURST★SHIP</option>
                                        </select>

                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <div class="categori0 container">
                                        <div class="categori1">
                                            <p>　</p>
                                        </div>
                                        <div class="categori2">　</div>
                                    </div>
                                </th>
                                <td>
                                    <div class="cc">
                                        <select class="tab" name="tab4" disabled>
                                            <option value="1" disabled selected>曲/チーム/組名等を選択してください。</option>
                                            <option value="2">銀河鉄道の夜</option>
                                            <option value="3">STAR★BURST★SHIP</option>
                                        </select>

                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <div class="categori0 container">
                                        <div class="categori1">
                                            <p>　</p>
                                        </div>
                                        <div class="categori2">　</div>
                                    </div>
                                </th>
                                <td>
                                    <div class="cc">
                                        <select class="tab" name="tab5" disabled>
                                            <option value="1" disabled selected>曲/チーム/組名等を選択してください。</option>
                                            <option value="2">銀河鉄道の夜</option>
                                            <option value="3">STAR★BURST★SHIP</option>
                                        </select>

                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="form-group ca">
                    <label class="memo-label">メモ：</label>
                    <textarea class="memo" name="memo" placeholder="メモを入力してください。"></textarea>
                </div>

                <div class="form-group">
                    <div class="btn">
                        <button id="fadd_open" type="button" class="in">追加</button>
                        <a class="kyan" href="fave_list">キャンセル</a>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>


<div id="addtab" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>曲/チーム/組名等</h4>
        </div>
        <h3>追加内容を入力してください</h3>
        <input type="text" placeholder="曲/チーム/組名等を入力してください。">

        <div class="modal-body">
            <button id="tabAdd" type="button" class="btn">追加</button>
            <button id="concan" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>

<div id="addcon" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>追加内容を入力してください</h3>
        <input type="text" placeholder="所属/関連プロジェクト等を入力してください。">

        <div class="modal-body">
            <button id="conAdd2" type="button" class="btn">追加</button>
            <button id="concan2" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>


<div id="fave_add_modal" class="modal">
    <div class="modal-content0">
        <div class="modal-header">
            <h1>以下の内容でよろしいですか？</h1>
        </div>
        <br>
        <div class="modal-body0">
            <div class="container">
                <table class="t_le">
                    <tr>
                        <th>名前：</th>
                        <td>ミューズ</td>
                    </tr>
                    <tr>
                        <th>誕生日：</th>
                        <td>9/22</td>
                    </tr>
                    <tr>
                        <th>画像：</th>
                        <td>
                            <div class="mo-img"><img src="static/img/myu.jpg" alt="ミューズ"></div>
                            <p>myu.jpg</p>
                        </td>
                    </tr>
                </table>

                <table class="t_ri">
                    <tr>
                        <th>所属 / 関連プロジェクト 等：</th>
                        <td>STAR★BURST★SHIP</td>
                    </tr>
                    <tr>
                        <th>曲 / チーム / 組名 等：</th>
                        <td>流星のキセキ</td>
                    </tr>
                    <tr>
                        <th>　</th>
                        <td>宙船 ソラフネ</td>
                    </tr>
                    <tr>
                        <th>　</th>
                        <td>STAR★BURST</td>
                    </tr>
                    <tr>
                        <th>　</th>
                        <td>　</td>
                    </tr>
                    <tr>
                        <th>　</th>
                        <td>　</td>
                    </tr>
                </table>
            </div>
            <br>
            <div>
                <table class="memodiv">
                    <tr>
                        <th>メモ：</th>
                        <td>赤　おとめ座　神奈川出身　身長：163㎝　血液O型</td>
                    </tr>
                </table>
            </div>

            <br>
            <div class="container">
                <button id="fadd" type="button" class="btn2">追加</button>
                <button id="fadd_can" type="button" class="btn2">キャンセル</button>
            </div>
        </div>
    </div>
</div>

<script src="static/js/FaveFile/fave_add.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
