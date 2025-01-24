<%@ page import="java.util.Map" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    Map<Integer, List<String>> categoryTagMap = (Map<Integer, List<String>>) session.getAttribute("categoryTagMap");
%>
<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
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
    <link rel="stylesheet" href="static/css/FaveFile/relate.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>RELATE | Time of Fave.</title>
</head>

<body class="RELATE">
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
        <br>
        <div class="scroll-content">
            <div class="accordion">
                <%
                    if (categorylist != null) {
                        for (categoryBean category : categorylist) {
                            int cate_id = category.getCate_id();
                            List<String> tags = categoryTagMap.get(cate_id);
                %>
                <div class="accordion-item">
                    <div class="container">
                        <button type="button"> <img class="EDIT" src="static/img/EDIT.png"></button>
                        <button class="accordion-button" data-cate-id="<%= cate_id %>" data-category="<%= category.getCategory() %>">
                            <div class="container">
                                <%= category.getCategory() %>
                                <img class="DOWN" src="static/img/DOWN.png">
                            </div>
                        </button>


                        <button class="DELEbtn" type="button"><img class="DELE" src="static/img/DELE.png"></button>
                    </div>
                    <div class="accordion-content">
                        <div class="container Addcon1">
                            <div>
                                <button class="Addcon" type="button">
                                    <img class="ADD" src="static/img/ADD.png">
                                </button>
                            </div>
                        <ul>
                            <% if (tags != null && !tags.isEmpty()) { %>
                            <% for (String tag : tags) { %>
                            <li>
                                <div class="container licon">
                                    <div class="container li">
                                        <div class="vertical-line"></div><%= tag %>
                                    </div>
                                    <div class="container libtn">
                                        <button type="button"><img class="btnimg EDIT2" src="static/img/EDIT2.png"></button>
                                        <button type="button"><img class="btnimg DELE2" src="static/img/DELE2.png"></button>
                                    </div>
                                </div>
                            </li>
                            <% } %>
                            <% } else { %>
                            <li >
                                <div class="container licon">
                                    <div class="container li" style="margin: 5.6px;">
                                        <div class="vertical-line"></div>登録されているチーム/曲/組名はありません。
                                    </div>
                                    <div class="container libtn">
                                    </div>
                                </div>
                            </li>
                            <% } %>
                            <li>
                                <div class="container close">
                                    閉じる
                                    <button type="button">
                                        <img class="DOWN" src="static/img/DOWN2.png">
                                    </button>
                                </div>
                            </li>
                        </ul>
                        </div>
                    </div>
                </div>
                <%
                    } // for終了
                } else {
                %>
                <p>カテゴリリストが空です。</p>
                <%
                    } // if終了
                %>
            </div>
        </div>



            <button type="button" class="ADD2con">
                <img class="ADD2" src="static/img/ADD.png">
            </button>

        </div>
    </div>
</div>



<%
    String categoryName = "カテゴリ名サンプル"; // 正しい値が設定されているか確認
    String tagName = "タグ名サンプル"; // 必要に応じて値を設定

%>

<!-- 編集モーダル -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>編集内容を入力してください</h3>

        <form method="post" action="CategoryEditServlet" id="cate_edit_form">
            <input type="text" id="editInput1" value="<%= categoryName %>" placeholder="カテゴリ名を入力してください" name="category">
            <!-- 隠しフィールドを追加 -->
            <input type="hidden" id="categoryIdInput" name="cate_id" value="">
            <div class="modal-body">
                <button id="confirmEdit" type="button" class="btn">完了</button>
                <button id="re_edcon_can" type="button" class="btn close">キャンセル</button>
            </div>
        </form>
    </div>
</div>

<!-- 編集モーダル 2 -->
<div id="editModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>曲/チーム/組名等</h4>
        </div>
        <h3>編集内容を入力してください</h3>
        <form method="post" action="TagEditServlet" id="tag_edit_form">
            <input type="text" id="editInput2" placeholder="<%= tagName %>" name="tag"> <!-- タグ名をプレースホルダに設定 -->
            <input type="hidden" id="cateIdInput" name="cate_id">
            <input type="hidden" value="<%= tagName %>" name="tag_before"> <!-- tag_before にタグ名を設定 -->

            <div class="modal-body">
                <button id="confirmEdit2" type="button" class="btn">完了</button>
                <button id="re_edtab_can" type="button" class="btn close">キャンセル</button>
            </div>
        </form>
    </div>
</div>

<!-- 削除モーダル -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>本当に削除しますか？</h3>
        <div class="deleword">
            <div class="line">
                <span class="asterisk">※</span>
                <span class="text">消した後は二度と元に戻せません。</span>
            </div>
            <div class="line">
                <span class="asterisk">※</span>
                <span class="text">対応するチーム/曲/組名等も削除されます。</span>
            </div>
        </div>

        <form method="post" action="CategoryDeleteServlet" id="cate_delete_form">
            <input type="text" id="deleteInput1" placeholder="" readonly> <!-- カテゴリ名をプレースホルダに設定 -->
            <!-- 隠しフィールドを追加 -->
            <input type="hidden" id="categoryIdInput2" name="cate_id" value="">
            <div class="modal-body">
                <button id="confirmDELE" type="button" class="btn">削除</button>
                <button id="re_deletab_can" type="button" class="btn close">キャンセル</button>
            </div>
        </form>

    </div>
</div>

<!-- 削除モーダル 2 -->
<div id="deleteModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>チーム/曲/組名等</h4>
        </div>
        <h3>本当に削除しますか？</h3>
        <div class="deleword">
            <div class="line">
                <span class="asterisk">※</span>
                <span class="text">消した後は二度と元に戻せません。</span>
            </div>
        </div>

        <form method="post" action="TagDeleteServlet" id="tag_delete_form">
            <input type="text" id="deleteInput2" placeholder="<%= tagName %>" readonly name="tag"> <!-- タグ名をプレースホルダに設定 -->


            <input type="hidden" id="cateIdInput2" name="cate_id"> <!-- cate_idの隠しフィールド -->

            <div class="modal-body">
                <button id="confirmDELE2" type="button" class="btn">削除</button>
                <button id="re_decon_can" type="button" class="btn close">キャンセル</button>
            </div>
        </form>

    </div>
</div>

<div id="addModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>曲/チーム/組名等</h4>
        </div>
        <h3>追加内容を入力してください</h3>
        <form method="post" action="TagAddServlet" id="tag_add_form">
            <input type="text" placeholder="曲/チーム/組名等を入力してください。" name="tag">
            <input type="hidden" id="categoryIdInput3" name="cate_id" value="">
            <div class="modal-body">
                <button id="confirmAdd" type="button" class="btn">追加</button>
                <button id="re_tab_can" type="button" class="btn close">キャンセル</button>
            </div>
        </form>
    </div>
</div>

<div id="addModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>所属/ 関連プロジェクト等</h4>
        </div>
        <h3>追加内容を入力してください</h3>

        <form method="post" action="CategoryAddServlet" id="cate_add_form">
            <input type="text" placeholder="所属/関連プロジェクト等を入力してください。" name="category">

            <div class="modal-body">
                <button id="confirmAdd2" type="button" class="btn">追加</button>
                <button id="re_con_can" type="button" class="btn close">キャンセル</button>
            </div>
        </form>
    </div>
</div>

<script src="static/js/FaveFile/relate.js"></script>
<script src="static/js/all.js"></script>

</body>


<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>
</html>
