<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.*" %>
<%
    userBean user = (userBean) session.getAttribute("user");
    faveBean fave = (faveBean) session.getAttribute("fave");
    categoryBean category = (categoryBean) session.getAttribute("category");
    ArrayList<tagBean> tags = (ArrayList<tagBean>) request.getAttribute("tags");
    Map<Integer,Integer> osiprice = (Map<Integer, Integer>) session.getAttribute("osiprice");
    ArrayList<osikatuBean> goodslist = (ArrayList<osikatuBean>) session.getAttribute("goodslist");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
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
    <link rel="stylesheet" href="static/css/FaveFile/fave_detail.css">

    <link rel="shortcut icon" href="static/img/Time for Fave.png">
    <title>FAVE_Detaile | Time of Fave.</title>
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

        <div class="scroll-content">
            <div class="container">
                <div class="left">
                    <div class="l_img">
                        <div class="f_img">
                            <img src="static/faveImg/<%= fave.getImg() %>" alt="<%= fave.getName() %>>" id="preview">
                        </div>
                    </div>

                    <div class="fd_memo">
                        <h3>メモ</h3>
                        <%
                            if(fave.getOsimemo() == null || fave.getOsimemo().isEmpty()){
                        %>
                        <p>　</p> <!-- 空白を表示 -->
                        <%
                        } else {
                        %>
                        <p><%= fave.getOsimemo() %></p> <!-- メモを表示 -->
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="right">
                    <div class="name container">
                        <h1><span class="na0">名前：</span><span class="na1"><%= fave.getName() %></span></h1>
                        <a href="fave_edit?osi_id=<%= fave.getOsi_id() %>"><img src="static/img/EDIT.png" alt="fave_edit"></a>
                    </div>

                    <table>
                        <tr>
                            <td>
                                <div class="categori0">誕生日：</div>
                            </td>
                            <th>
                                <%
                                    if (fave.getBirthday() != null) {
                                        LocalDate birthday = fave.getBirthday();  // もしLocalDate型であれば
                                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                                %>
                                <%= birthday.format(formatter) %>
                                <%
                                } else {
                                %>
                                不明
                                <%
                                    }
                                %>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <div class="categori0 container">
                                    <div class="categori1">
                                        <p>所属 /<br>
                                            関連プロジェクト 等</p>
                                    </div>
                                    <div class="categori2">：</div>
                                </div>
                            </td>
                            <th><%= category.getCategory() %></th>
                        </tr>
                        <tr>
                            <td>
                                <div class="categori0 container">
                                    <div class="categori1">
                                        <p>曲 / チーム / 組名 等</p>
                                    </div>
                                    <div class="categori2">：</div>
                                </div>
                            </td>
                            <th>
                                <%= tags != null && tags.size() > 0 ? tags.get(0).getTag() : " - " %>
                            </th>
                        </tr>
                        <%
                            for (int i = 1; i < 5; i++) { // 最大5回までループ
                        %>
                        <tr>
                            <td>　</td>
                            <th><%= (tags != null && tags.size() > i) ? tags.get(i).getTag() : "-" %></th>
                        </tr>

                        <%
                            }
                        %>
                    </table>

                    <div class="fd_money">
                        <%
                            int totalPrice = osiprice != null && osiprice.containsKey(fave.getOsi_id())
                                    ? osiprice.get(fave.getOsi_id()) : 0;
                            DecimalFormat formatter = new DecimalFormat("#,###");
                            String formattedPrice = formatter.format(totalPrice);
                        %>
                        <h1>奉納額：<span>¥ <%= formattedPrice %></span></h1>
                        <button id="detail_button">金額の詳細 ＞</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<div id="money_de" class="modal">
    <div class="modal-content">

        <div class="modal-body">
            <div class="ikkatu">
                <%
                    // favelistが空でない場合、ループして表示
                    if (goodslist != null && !goodslist.isEmpty()) {
                        for (osikatuBean goods : goodslist) {
                            int osiId = fave.getOsi_id(); // 現在のfaveのosi_id


                            DecimalFormat format = new DecimalFormat("#,###");
                            String forma = formatter.format(goods.getPrice());


                            if(goods.getItemtype() == 0){
                %>
                <div class="container goods_money">
                    <h4><%= goods.getItem() %></h4>
                    <h3>¥ <%= forma %></h3>
                </div>
                <%
                }else{
                %>
                <div class="container event_money">
                    <h4><%= goods.getItem() %></h4>
                    <h3>¥ <%= forma %></h3>
                </div>
                <%
                            }
                        }
                    }
                %>
            </div>


            <button id="mo_de_close" type="button" class="btn">閉じる</button>
        </div>
    </div>
</div>

<script src="static/js/FaveFile/fave_detail.js"></script>
<script src="static/js/all.js"></script>

</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>