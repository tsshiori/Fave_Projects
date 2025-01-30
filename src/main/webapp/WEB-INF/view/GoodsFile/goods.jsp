<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="utils.Bean.osikatuBean" %>
<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.DAO.goodsDAO" %>
<%@ page import="utils.Bean.goodsBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>

<%

    userBean user = (userBean) session.getAttribute("user");
    String log_id = user.getLog_id();
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    int futureWage = (int) session.getAttribute("futureWage");
    int almosthand = (int) session.getAttribute("almosthand");
    int sum = (int) session.getAttribute("sum");

    ArrayList<osikatuBean> Beforelist = (ArrayList<osikatuBean>) session.getAttribute("0_list");
    ArrayList<osikatuBean> Afterlist = (ArrayList<osikatuBean>) session.getAttribute("1_list");



%>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+JP:wght@200..900&family=Yuji+Syuku&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="static/css/all.css">
    <link rel="stylesheet" href="static/css/GoodsFile/goods.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>Goods | Time of Fave.</title>
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

    <div class="main container">
        <div class="scroll-box">
            <div class="split-container">
                <!-- 左側のカンパネルラ商品リスト -->
                <div class="left-side">
                    <p class="status">PENDING</p>

                    <div class="container">
                        <!-- ステータスコンテナ -->
                        <div class="status-container">
                                <span class="purchase-text">
                                    <span>購入したら</span><br>
                                    <span>クリック</span>
                                    <div class="arrow">▼</div> <!-- 下向き矢印を直接追加 -->
                            </span>
                        </div>
                        <a href="goods_add" id="plus-link">
                            <img src="static/img/ADD.png" alt="ADD" class="add-icon">
                        </a>
                    </div>


                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                        if (Beforelist != null && !Beforelist.isEmpty()) {
                            for (osikatuBean bean : Beforelist) {
                                if (bean.getItemtype() == 0 || bean.getItemtype() == 1) {
                    %>
                    <form action="BuyBoughtServlet" method="post" id="buy_form_<%=bean.getOsikatu_id()%>">
                        <input type="hidden" name="osikatu_id" value="<%=bean.getOsikatu_id()%>">
                        <%
                            if (bean.getDay() != null) {
                                LocalDate day = (bean.getDay());  // もしLocalDate型であれば
                                 }
                        %>

                        <%
                            int priority = bean.getPriority();  // osikatuBean から priority を取得
                        %>
                        <%
                            int osi_id = bean.getOsi_id();
                            faveBean fave = utils.DAO.faveDAO.getFaveByOsi_id(osi_id);
                            String osiName = fave.getName();
                        %>
                        <div class="<%= bean.getItemtype() == 0 ? "guzzu" : "event" %>" style="margin-top: 20px;" onclick="openModal('<%=bean.getOsikatu_id()%>','<%=bean.getItem()%>', '<%=bean.getPrice()%>', '<%=osiName%>', '<%=bean.getDay().format(formatter)%>', '<%=priority%>','<%=bean.getMemo()%>','<%=bean.getPurchase()%>')">
                            <div class="container" id="item1">
                                <!-- "hi-img" クリック時に JavaScript 関数を呼び出す -->
                                <div class="hi-img" onclick="submitFormBuy('<%=bean.getOsikatu_id()%>'), event.stopPropagation();">
                                    <p>~<%=bean.getDay()%></p>


                                    <%-- 条件に基づいて画像を表示 --%>
                                    <% if (priority == 0) { %>
                                    <img src="static/img/Y_0.png" alt="Priority 0">
                                    <% } else if (priority == 1) { %>
                                    <img src="static/img/Y_1.png" alt="Priority 1">
                                    <% } else if (priority == 2) { %>
                                    <img src="static/img/Y_2.png" alt="Priority 2">
                                    <% } else if (priority == 3) { %>
                                    <img src="static/img/Y_3.png" alt="Priority 3">
                                    <% } else if (priority == 4) { %>
                                    <img src="static/img/Y_4.png" alt="Priority 4">
                                    <% } else { %>
                                    <img src="static/img/購入済.png" alt="Default Priority">
                                    <% } %>
                                </div>
                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">

                                                <%=osiName%>
                                            </p>
                                            <hr class="divider">
                                            <p class="name"><%=bean.getItem()%></p>
                                        </div>
                                    </div>
                                    <p class="price">&yen;<%=String.format("%,d",bean.getPrice())%></p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>
                    </form>

                    <%
                            }
                        }
                    } else {
                    %>
                    <h3 style="margin-left: 60px">登録されている購入前のグッズはありません</h3>
                    <%
                        }
                    %>




                </div>
            </div>
        </div>


        <div class="scroll-box">
            <div class="split-container">
                <!-- 右側のカンパネルラ商品リスト -->
                <div class="right-side">
                    <p class="status-right">BOUHT</p>

                    <!-- ステータスコンテナ -->
                    <div class="status-container">
                            <span class="purchase-text-1">
                                <span>未購入なら</span><br>
                                <span>クリック</span>
                                <div class="arrow-right">▼</div> <!-- 下向き矢印を直接追加 -->
                            </span>
                    </div>


                    <!-- guzuu や event を右側に配置 -->
                    <!-- アイテムの右側の内容 -->
                    <div class="right-side-one" style="margin-bottom: 40px">
                        <%
                            if (Afterlist != null && !Afterlist.isEmpty()) {
                                for (osikatuBean bean : Afterlist) {
                        %>
                        <%
                            if (bean.getDay() != null) {
                                LocalDate day = (bean.getDay());  // もしLocalDate型であれば
                            }
                        %>

                        <%
                            int priority = bean.getPriority();  // osikatuBean から priority を取得
                        %>
                        <%
                            int osi_id2 = bean.getOsi_id();
                            faveBean fave = utils.DAO.faveDAO.getFaveByOsi_id(osi_id2);
                            String osiName2 = fave.getName();
                        %>

                        <form action="BuyBoughtServlet" method="post" id="bought_form_<%=bean.getOsikatu_id()%>">
                            <input type="hidden" name="osikatu_id" value="<%=bean.getOsikatu_id()%>">

                            <div class="<%= bean.getItemtype() == 0 ? "guzzu-right" : "event-right" %>" style="margin-top: 20px;" onclick="openModal('<%=bean.getOsikatu_id()%>','<%=bean.getItem()%>', '<%=bean.getPrice()%>', '<%=osiName2%>', '<%=bean.getDay().format(formatter)%>', '<%=priority%>','<%=bean.getMemo()%>','<%=bean.getPurchase()%>')">
                            <div class="container" id="item">
                                <div class="hi-img-right" onclick="submitFormBought('<%=bean.getOsikatu_id()%>'), event.stopPropagation();">
                                    <p>~<%=bean.getDay()%></p>
                                    <img src="static/img/購入済.png" alt="Default Priority" class="purchase-icon">
                                </div>

                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">
                                                <%
                                                    int osi_id = bean.getOsi_id();
                                                    fave = utils.DAO.faveDAO.getFaveByOsi_id(osi_id);
                                                    String osiName = fave.getName();
                                                %>
                                                <%=osiName%>
                                            </p>
                                            <hr class="divider">
                                            <p class="name"><%=bean.getItem()%></p>
                                        </div>
                                    </div>
                                    <p class="price">&yen;<%=String.format("%,d",bean.getPrice())%></p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>
                        </form>

                        <%
                            }
                        } else {
                        %>
                        <h3 style="margin-left: 60px; margin-top: 40px">登録されている購入済みのグッズはありません</h3>
                        <%
                            }
                        %>
                    </div>

                    </div>

            </div>
        </div>
    </div>
</div>

<div id="openModal" class="modal">
    <div class="modal-content">
        <img src="static/img/Y_0.png" alt="Y_0" class="modal-image">
        <p id="modal-content-text"></p>
        <div id="modal-details">
            <table>
                <!-- 動的にデータが追加される -->
            </table>
        </div>
        <div class="container btn">
            <div class="img_icon">
                <button class="edit" id="editButton">
                    <img src="static/img/EDIT2.png">
                </button>
            </div>
            <div class="img_icon">
                <a href="#" onclick="openDeleteModal()"><img src="static/img/DELE2.png"></a>
            </div>
        </div>
        <button id="mClose" type="button" class="btn" onclick="closeButton()">閉じる</button>
    </div>
</div>


<!-- 削除用モーダル 左 -->
<div id="deleteModal" class="modal modal-left">
    <div class="modal-content-center">
        <h3>本当に削除しますか？</h3>
        <div class="delete-h4">
            <h6>※消した後は二度と元に戻れません。</h6>
        </div>

        <div class="delete-details">
            <form id="goods_del_modal" action="GoodsDelServlet" method="post">
            <table>
                <tr>
                    <th>日付：</th>
                    <td>2024/11/16</td>
                </tr>
                <tr>
                    <th>グッズ名：</th>
                    <td>アクリルスタンド</td>
                </tr>
                <tr>
                    <th>金額(円)：</th>
                    <td>¥ 1,980</td>
                </tr>
                <tr>
                    <th>優先度：</th>
                    <td><img src="static/img/Y_0.png" alt="Y_0" class="priority-image"></td>
                </tr>
                <tr>
                    <th>推し：</th>
                    <td>カンパネルラ</td>
                </tr>
                <tr>
                    <th>メモ：</th>
                    <td>ビジュがよき</td>
                </tr>
                <tr>
                    <th>購入済：</th>
                    <td>
                        <input type="checkbox" class="text">
                        <span class="text">※購入済みの場合はチェックを入れてください。</span>
                    </td>
                </tr>
            </table>
                <input name="goods_id" type="hidden" value="">
            </form>
        </div>

        <button id="mDelete" type="button" class="btn delete-btn">削除</button>
        <button id="mCancel" type="button" class="btn cancel-btn" onclick="closeDeleteModal()">キャンセル</button>
    </div>
</div>





<script src="static/js/GoodsFile/goods.js"></script>
<script src="static/js/all.js"></script>


<footer class="footer">
    <p>©️ 2024 Time for Fave. All rights reserved.</p>
</footer>
</div>
</body>

</html>
