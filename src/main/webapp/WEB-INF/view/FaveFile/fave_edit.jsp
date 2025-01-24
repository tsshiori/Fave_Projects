<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.*" %>
<%
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    faveBean fave = (faveBean) session.getAttribute("fave");
    categoryBean category = (categoryBean) session.getAttribute("category");
    ArrayList<tagBean> tags = (ArrayList<tagBean>) request.getAttribute("tags");
    Map<Integer,Integer> osiprice = (Map<Integer, Integer>) session.getAttribute("osiprice");
    ArrayList<osikatuBean> goodslist = (ArrayList<osikatuBean>) session.getAttribute("goodslist");
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    int futureWage = (int) session.getAttribute("futureWage");
    int almosthand = (int) session.getAttribute("almosthand");
    int sum = (int) session.getAttribute("sum");
    userBean user = (userBean) session.getAttribute("user");
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
    <link rel="stylesheet" href="static/css/FaveFile/fave_edit.css">

    <link rel="shortcut icon" href="static/img/Time for Fave.png">
    <title>FAVE_Edit | Time of Fave.</title>
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
            <form id="fedit_form" action="FaveEdit" method="post" enctype="multipart/form-data">
                    <div class="container">
                        <div class="left_t">
                            <div class="left">
                                <div class="f_img">
                                    <img src="static/faveImg/<%= fave.getImg() %>" alt="<%= fave.getImg() %>" id="preview">
                                </div>
                            </div>

                            <div class="container">
                                <div class="aaa container">
                                    <label class="custom-file-select" for="fileInput" id="fileLabel">
                                        　<%= fave.getImg() %>
                                    </label>
                                </div>
                                <!-- 非表示のファイル選択フィールド -->
                                <input type="file" name="img" id="fileInput" onchange="updateFileName()" accept="image/*">
                                <input type="hidden" id="currentImageUrl" value="static/faveImg/<%= fave.getImg() %>">
                                <input name="null_ver_img" type="hidden" id="currentImageName" value="<%= fave.getImg() %>">
                            </div>
                        </div>

                        <div class="right">
                            <table>
                                <tr>
                                    <th><span class="hissu">＊</span>名前：</th>
                                    <td><input type="text" name="name" placeholder="名前を入力してください。" value="<%= fave.getName() %>"><br>
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
                                                   onfocus="hidePlaceholder(this)" onblur="showPlaceholder(this)" value="<%= fave.getBirthday() %>">
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
                                                <option value="<%= category.getCate_id() %>" selected><%= category.getCategory() %></option>
                                                    <% if (categorylist != null) { %>
                                                    <% for (categoryBean catego : categorylist) { %>
                                                    <% if (catego.getCate_id() != category.getCate_id()) { %>
                                                <option value="<%= catego.getCate_id() %>"><%= catego.getCategory() %></option>
                                                    <% } %>
                                                    <% } %>
                                                <option value="1">はずす</option>
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
                                            <select class="tab" name="tab1">
                                                    <% if(tags != null && tags.size() > 0){ %>
                                                <option value="<%= tags.get(0).getTag_id() %>" selected><%= tags.get(0).getTag() %></option>
                                                    <% }else{ %>
                                                <option value="1" selected>曲/チーム/組名等を選択してください。</option>
                                                    <% } %>
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

                                <% for (int i = 1; i < 5; i++) {%>
                                <tr>
                                    <th>
                                        <div class="categori0 container">
                                            <div class="categori1">
                                                <% if(i == 2){ %>
                                                <p>
                                                    ※ 最大５個まで<br>
                                                    選択できます。
                                                </p>
                                                <% }else{ %>
                                                <p>　</p>
                                                <% } %>
                                            </div>
                                            <div class="categori2">　</div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="cc">
                                            <select class="tab" name="tab<%= i + 1 %>">
                                                    <% if(tags != null && tags.size() > i){ %>
                                                <option value="<%= tags.get(i).getTag_id() %>" selected><%= tags.get(i).getTag() %></option>
                                                    <% }else{ %>
                                                <option value="1" selected>曲/チーム/組名等を選択してください。</option>
                                                    <% } %>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </table>
                        </div>
                    </div>

                    <div class="form-group ca">
                        <label class="memo-label">メモ：</label>
                        <textarea class="memo" name="memo" placeholder="メモを入力してください。" >
                            <%if(fave.getOsimemo() == null || fave.getOsimemo().isEmpty()){} else {fave.getOsimemo();}%>
                        </textarea>
                    </div>

                    <div class="form-group">
                        <div class="btn">
                            <button id="fed_open" type="button" class="in">完了</button>
                            <a class="kyan" href="fave_detail">キャンセル</a>
                        </div>
                        <div class="f_dele">
                            <button id="fe_dele"><img src="static/img/DELE.png" alt=""></button>
                        </div>
                    </div>
                    <input name="osi_id" type="hidden" value="<%= fave.getOsi_id() %>">
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
            <button id="edcon_can" type="button" class="btn close">キャンセル</button>
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
            <button id="edcon_can2" type="button" class="btn close">キャンセル</button>
        </div>
    </div>
</div>


<div id="fave_edit_modal" class="modal">
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
                    <button id="fed" type="button" class="btn2">完了</button>
                    <button id="fed_can" type="button" class="btn2">キャンセル</button>
                </div>
            </div>
        </div>
    </div>

    <div id="favedeleModal" class="modal4">
        <div class="modal-content4">
            <form id="fave_delete" action="FaveDeleServlet" method="POST">
                <div class="modal-header4">
                    <h1>本当に削除しますか？</h1>
                    <div class="modal-h4">
                        <h3 class="f_name_modal">名前：<span></span></h3>
                        <h4>※ 推しのグッズ・イベント情報も
                            全て削除されます。</h4>
                        <input name="osi_id" type="hidden" value="<%= fave.getOsi_id() %>">
                    </div>
                </div>
                <div class="modal-body">
                    <!-- モーダル内の削除を確定するボタン -->
                    <button id="fe_Delete" type="submit" class="btn">削除</button>
                    <button id="fe_can_Delete" type="button" class="btn">キャンセル</button>
                </div>
            </form>
        </div>
    </div>

    <script src="static/js/FaveFile/fave_edit.js"></script>
    <script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>