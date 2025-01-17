<%@ page import="utils.Bean.userBean" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="utils.Bean.userBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="utils.Bean.categoryBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ArrayList<faveBean> favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    Map<Integer, Integer> osiPriceMap = (Map<Integer, Integer>) session.getAttribute("osiout");
    ArrayList<categoryBean> categorylist = (ArrayList<categoryBean>) session.getAttribute("categorylist");
    Map<Integer, String> ositaglist = (Map<Integer, String>) session.getAttribute("ositaglist");
%>
<%
        userBean user = (userBean) session.getAttribute("user");
        String log_id = user.getLog_id();

        int living = user.getLiving();
        int amounthand = user.getAmounthand();

        String saiosiName = null;
        String saioshiImg = "static/faveImg/def.png";
        int saiosi = user.getSaiosi();
        int icon = user.getRegimg();
        faveBean saiosifave = null;
    // osi_idに対応するカテゴリとタグを取得
    String category = null;
    String tag = null;

    // セッションからfavelistを取得
    if (session.getAttribute("favelist") != null) {
        favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    }

    for (faveBean fave : favelist) {
        if (fave.getOsi_id() == saiosi) {
            if (categorylist != null) {
                for (categoryBean categoryItem : categorylist) {
                    if (categoryItem.getCate_id() == fave.getCate_id()) {
                        category = categoryItem.getCategory();
                        break;
                    }
                }
            }

            if (ositaglist != null && ositaglist.containsKey(fave.getOsi_id())) {
                tag = ositaglist.get(fave.getOsi_id());
            }

            saiosiName = fave.getName();
            saioshiImg = "static/faveImg/" + fave.getImg(); // 例えばファイル名はfave.getImageFileName()から取得
        }
    }


    // アイコン画像のファイル名を設定
    String iconImg = "static/img/I_N.png"; // デフォルトのアイコン画像
    switch(icon) {
        case 0:
            iconImg = "static/img/I_N.png";
            break;
        case 1:
            iconImg = "static/img/I_B.png"; // Blueアイコン
            break;
        case 2:
            iconImg = "static/img/I_G.png"; // Greenアイコン
            break;
        case 3:
            iconImg = "static/img/I_R.png"; // Redアイコン
            break;
        case 4:
            iconImg = "static/img/I_V.png"; // Violetアイコン
            break;
        case 5:
            iconImg = "static/img/I_Y.png"; // Yellowアイコン
            break;
        default:
            iconImg = "static/img/I_N.png"; // デフォルトのアイコン
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.Bean.faveBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="utils.Bean.categoryBean" %>

<%
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

    <link rel="stylesheet" href="static/css/all.css">
    <link rel="stylesheet" href="static/css/MypageFile/mypage.css">

    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>MYPAGE | Time of Fave.</title>
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
        <div class="top-link">
            <div class="list-link"><a href="goods">グッズリスト ＞</a></div>
            <div class="out-link">
                <form action="LogoutServlet" method="POST">
                    <a href="#" onclick="logout()">LOGOUT</a>
                </form>
            </div>
        </div>
        <br><br>
        <div class="scroll-content mycontents">
            <div class="container">
                <div class="icon">
                    <img src="<%=iconImg%>" alt="Nomal">
                </div>
                <div class="nick">
                    <h1><%=user.getNick()%></h1>
                </div>
                <div class="edit">
                    <a href="my_page_edit"><img src="static/img/EDIT.png" alt="mypage-edit"></a>
                </div>
            </div>

            <div class="most">
                <div class="container mo1">
                    <div class="favetag">
                        <p>Now</p>
                        <p>　Fave</p>
                    </div>
                    <div class="moimg">
                        <img src="<%=saioshiImg%>" alt="">
                    </div>
                    <div class="favename">
                        <h2><%=saiosiName%></h2>
                    </div>
                </div>

                <div class="cate">
                    <h3><span>/</span><%= category != null ? category : "カテゴリ未設定" %>　<%= tag != null ? tag : "タグ未設定" %></h3>
                </div>
            </div>

            <div class="container lm">
                <div class="life">
                    <h2>生活費：</h2>
                    <%
                    if (living == 0){
                    %>
                    <h1><span>¥</span>0</h1>
                    <%
                        }else{

                        DecimalFormat formatter = new DecimalFormat("#,###");
                        String formattedLiving = formatter.format(living);
                    %>
                    <h1><span>¥</span><%=formattedLiving%></h1>
                    <%
                        }
                    %>
                </div>
                <div class="money">
                    <h2>達成金額：</h2>
                    <%
                        if (amounthand == 0){
                    %>
                    <h1><span>¥</span>0</h1>
                    <%
                        }else{
                            DecimalFormat formatter = new DecimalFormat("#,###");
                            String formattedA = formatter.format(amounthand);
                    %>
                    <h1><span>¥</span><%=formattedA%></h1>
                    <%
                        }
                    %>
                </div>
            </div>

            <a class="akasaku" href="dele">アカウント削除 ＞</a>
        </div>

    </div>
</div>
</body>
<script>
    function logout() {
        // POSTリクエストを送信するためのフォームを動的に作成
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = 'LogoutServlet';

        // フォームを送信
        document.body.appendChild(form);
        form.submit();
    }
</script>
<script src="static/js/all.js"></script>
<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>

</html>
