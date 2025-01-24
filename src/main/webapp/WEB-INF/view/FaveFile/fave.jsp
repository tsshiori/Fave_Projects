<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.Bean.workBean" %>

<%
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
    userBean user = (userBean) session.getAttribute("user");
    int futureWage = (int) request.getAttribute("futureWage");
    int almosthand = (int) request.getAttribute("almosthand");
    int sum = (int) session.getAttribute("sum");
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
    <link rel="stylesheet" href="static/css/FaveFile/fave.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>FAVE | Time of Fave.</title>
</head>

<body class="FAVE">
<div class="container con">
    <!-- ロゴ -->
    <div class="logo">
        <a href="/fave"><img src="static/img/TimeforFave.png" alt="logo"></a>
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

            <div class="toggle-container">
                <label for="switch" class="switch_label">
                    <div class="switch">
                        <input type="checkbox" id="switch" />
                        <div class="base">
                            <div class="circle container">
                                <div class="gallery"><img src="static/img/table-cells-solid.png" alt="gallery"></div>
                                <div class="list"><img src="static/img/list-ul-solid.png" alt="list"></div>
                            </div>
                        </div>
                    </div>
                </label>
            </div>

            <div id="gallery">
                <div class="container">
                    <a class="a00" href="fave_add">
                        <div class="add0">
                            <img src="static/img/ADD.png" alt="FaveAdd">
                        </div>
                    </a>

                    <%
                        // favelistが空でない場合、ループして表示
                        if (favelist != null && !favelist.isEmpty()) {
                            for (faveBean fave : favelist) {
                                if(fave.getOsi_id() == user.getSaiosi()){
                                    if(fave.getImg().equals("def.png")){
                                        String getImg = "def2.png";
                    %>

                    <a href="fave_detail?osi_id=<%= fave.getOsi_id() %>">
                        <div class="card__item saiosi">
                            <div class="card_img">
                                <img src="static/faveImg/<%= getImg %>" alt="<%=fave.getName() %>">
                            </div>
                            <p><%=fave.getName() %></p>
                        </div>
                    </a>
                    <%
                    }else{
                    %>
                    <a href="fave_detail?osi_id=<%= fave.getOsi_id() %>">
                        <div class="card__item saiosi">
                            <div class="card_img">
                                <img src="static/faveImg/<%= fave.getImg() %>" alt="<%=fave.getName() %>">
                            </div>
                            <p><%=fave.getName() %></p>
                        </div>
                    </a>
                    <%
                                }
                            }
                        }
                        for (faveBean fave : favelist) {
                            if(fave.getOsi_id() != user.getSaiosi()){
                    %>
                    <a href="fave_detail?osi_id=<%= fave.getOsi_id() %>">
                            <div class="card__item">
                                <div class="card_img">
                                    <img src="static/faveImg/<%= fave.getImg() %>" alt="<%=fave.getName() %>">
                                </div>
                                <p><%=fave.getName() %></p>
                            </div>
                        </a>
                            <%
                                }
                            }
                        }
                    %>
                </div>
            </div>

            <div id="list">
                <div class="add1">
                    <a href="fave_add"><img src="static/img/ADD.png" alt="Add"></a>
                </div>

                <%
                    // favelistが空でない場合、ループして表示
                    if (favelist != null && !favelist.isEmpty()) {
                        for (faveBean fave : favelist) {
                            int osiId = fave.getOsi_id(); // 現在のfaveのosi_id
                            int totalPrice = osiPriceMap != null && osiPriceMap.containsKey(osiId)
                                    ? osiPriceMap.get(osiId) : 0; // 合計価格（データがなければ0）
                            // osi_idに対応するカテゴリとタグを取得
                            String category = null;
                            String tag = null;
                            if (categorylist != null) {
                                for (categoryBean categoryItem : categorylist) {
                                    if (categoryItem.getCate_id() == fave.getCate_id()) {
                                        category = categoryItem.getCategory();
                                        break;
                                    }
                                }
                            }
                            if (ositaglist != null && ositaglist.containsKey(osiId)) {
                                tag = ositaglist.get(osiId);
                            }
                            if(fave.getOsi_id() == user.getSaiosi()){
                                if(fave.getImg().equals("def.png")){
                                    String getImg = "def2.png";
                %>

                <a href="fave_detail?osi_id=<%= fave.getOsi_id() %>">
                    <div class="list_card container saiosi">
                        <div class="card_img">
                            <img src="static/faveImg/<%= getImg %>" alt="<%= fave.getName() %>">
                        </div>
                        <h3 class="name"><%= fave.getName() %></h3>
                        <h4 class="rela">/ <%= category != null ? category : "カテゴリ未設定" %>　<%= tag != null ? tag : "タグ未設定" %></h4>
                        <%
                            DecimalFormat formatter = new DecimalFormat("#,###");
                            String formattedPrice = formatter.format(totalPrice);
                        %>
                        <h2 class="price">¥<%= formattedPrice %></h2>
                    </div>
                </a>
                <%
                }else{
                %>
                <a href="fave_detail?osi_id=<%= fave.getOsi_id() %>">
                    <div class="list_card container saiosi">
                        <div class="card_img">
                            <img src="static/faveImg/<%= fave.getImg() %>" alt="<%= fave.getName() %>">
                        </div>
                        <h3 class="name"><%= fave.getName() %></h3>
                        <h4 class="rela">/ <%= category != null ? category : "カテゴリ未設定" %>　<%= tag != null ? tag : "タグ未設定" %></h4>
                        <%
                            DecimalFormat formatter = new DecimalFormat("#,###");
                            String formattedPrice = formatter.format(totalPrice);
                        %>
                        <h2 class="price">¥<%= formattedPrice %></h2>
                    </div>
                </a>
                <%
                            }
                        }
                    }
                    for (faveBean fave : favelist) {
                        int osiId = fave.getOsi_id(); // 現在のfaveのosi_id
                        int totalPrice = osiPriceMap != null && osiPriceMap.containsKey(osiId)
                                ? osiPriceMap.get(osiId) : 0; // 合計価格（データがなければ0）
                        // osi_idに対応するカテゴリとタグを取得
                        String category = null;
                        String tag = null;
                        if (categorylist != null) {
                            for (categoryBean categoryItem : categorylist) {
                                if (categoryItem.getCate_id() == fave.getCate_id()) {
                                    category = categoryItem.getCategory();
                                    break;
                                }
                            }
                        }
                        if (ositaglist != null && ositaglist.containsKey(osiId)) {
                            tag = ositaglist.get(osiId);
                        }
                        if(fave.getOsi_id() != user.getSaiosi()){
                %>
                <a href="fave_detail?osi_id=<%= fave.getOsi_id() %>">
                        <div class="list_card container">
                            <div class="card_img">
                                <img src="static/faveImg/<%= fave.getImg() %>" alt="<%= fave.getName() %>">
                            </div>
                            <h3 class="name"><%= fave.getName() %></h3>
                            <h4 class="rela">/ <%= category != null ? category : "カテゴリ未設定" %>　<%= tag != null ? tag : "タグ未設定" %></h4>
                            <%
                                DecimalFormat formatter = new DecimalFormat("#,###");
                                String formattedPrice = formatter.format(totalPrice);
                            %>
                            <h2 class="price">¥<%= formattedPrice %></h2>
                        </div>
                    </a>

                        <%
                            }
                        }
                    }
                %>
            </div>


        </div>
    </div>

</div>
<script src="static/js/FaveFile/fave.js"></script>
<script src="static/js/all.js"></script>
</body>

<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>