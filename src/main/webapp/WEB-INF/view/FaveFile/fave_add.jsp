<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.Map" %>
<%@ page import="utils.Bean.workBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");

    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    int futureWage = (int) session.getAttribute("futureWage");
    int almosthand = (int) session.getAttribute("almosthand");
    int sum = (int) session.getAttribute("sum");
    userBean user = (userBean) session.getAttribute("user");
    workBean mainwork = (workBean) session.getAttribute("mainwork");
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
        <p class="hissu p">※ ＊は必須項目です。</p>
        <div class="scroll-content">
            <form id="fadd_form" action="FaveAdd" method="post" enctype="multipart/form-data">
                <div class="container">
                    <div class="left_t">
                        <div class="left">
                            <div class="f_img">
                                <img src="static/faveImg/def.png" alt="defo" id="preview">
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
                                    <p class="error-message" style="font-size: 15px; color: red">
                                        <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
                                    </p>
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
                                            <select name="cate_id" id="categorySelect"  onchange="fetchTagsByCategory(this.value)">
                                                <option value="1" selected>所属/関連プロジェクトを選択してください。</option>
                                                <% if (categorylist != null) { %>
                                                <% for (categoryBean category : categorylist) { %>
                                                <option value="<%= category.getCate_id() %>"><%= category.getCategory() %></option>
                                                <% } %>
                                                <% } else { %>
                                                <option value="1" disabled>カテゴリ未登録</option>
                                                <% } %>
                                            </select>
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
                                            <option value="1" selected>曲/チーム/組名等を選択してください。</option>
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
                                            <option value="1" selected>曲/チーム/組名等を選択してください。</option>
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
                                            <option value="1" selected>曲/チーム/組名等を選択してください。</option>
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
                                            <option value="1" selected>曲/チーム/組名等を選択してください。</option>
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
                                            <option value="1" selected>曲/チーム/組名等を選択してください。</option>
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
        <form action="TagAddServlet2" method="post" id="tagAdd">
            <input type="text" name="tag" placeholder="曲/チーム/組名等を入力してください。">
            <input type="hidden" class="cate_id" name="cate_id" value="">
            <div class="modal-body">
                <button id="tabAdd" type="submit" class="btn">追加</button>
                <button id="tabcan" type="button" class="btn close">キャンセル</button>
            </div>
        </form>
    </div>
</div>

<div id="addcon" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>追加内容を入力してください</h3>
        <form action="CategoryAddServlet2" method="post" id="cateAdd">
            <input type="text" name="category" placeholder="所属/関連プロジェクト等を入力してください。">

            <div class="modal-body">
                <button id="conAdd2" type="submit" class="btn">追加</button>
                <button id="concan" type="button" class="btn close">キャンセル</button>
            </div>
        </form>
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
                        <td>〇〇〇〇〇〇</td>
                    </tr>
                    <tr>
                        <th>誕生日：</th>
                        <td>不明</td>
                    </tr>
                    <tr>
                        <th>画像：</th>
                        <td>
                            <div class="mo-img"><img src="static/faveImg/def.png" alt="defo"></div>
                            <p>def.png</p>
                        </td>
                    </tr>
                </table>

                <table class="t_ri">
                    <tr>
                        <th>所属 / 関連プロジェクト 等：</th>
                        <td>　</td>
                    </tr>
                    <tr>
                        <th>曲 / チーム / 組名 等：</th>
                        <td>　</td>
                    </tr>
                    <tr>
                        <th>　</th>
                        <td>　</td>
                    </tr>
                    <tr>
                        <th>　</th>
                        <td>　</td>
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
                        <td>　</td>
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
