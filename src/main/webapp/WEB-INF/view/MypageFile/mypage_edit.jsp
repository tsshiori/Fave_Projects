<%@ page import="utils.Bean.faveBean" %>
<%@ page import="utils.Bean.userBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    userBean user = (userBean) session.getAttribute("user");
    String log_id = user.getLog_id();
    String nick = user.getNick();
    int saiosi = user.getSaiosi();
    int icon = user.getRegimg();
    int living = user.getLiving();
    int amounthand = user.getAmounthand();
    ArrayList<faveBean> favelist = null;

    // セッションからfavelistを取得
    if (session.getAttribute("favelist") != null) {
        favelist = (ArrayList<faveBean>) session.getAttribute("favelist");
    }

    // 最推しの画像ファイル名を保持する変数
    String saioshiImg = "static/faveImg/def.png"; // 初期画像（最推し未選択）

    // 最推しが選択されている場合、画像を更新
    String selectedSaioshi = saiosi > 0 ? String.valueOf(saiosi) : null;
    if (selectedSaioshi != null && !selectedSaioshi.equals("0")) {
        // 選ばれた最推しに対応する画像を設定
        for (faveBean fave : favelist) {
            if (String.valueOf(fave.getOsi_id()).equals(selectedSaioshi)) {
                saioshiImg = "static/faveImg/" + fave.getImg(); // 例えばファイル名はfave.getImageFileName()から取得
                break;
            }
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

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/css/all.css">
    <link rel="stylesheet" href="static/css/MypageFile/mypage_edit.css">
    <link rel="shortcut icon" href="static/img/TimeforFave.png">
    <title>MYPAGE_Edit | Time of Fave.</title>
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
            <meter class="background-meter" value="31.1" min="0" max="100"></meter>
            <!-- 前面のメーター -->
            <meter class="foreground-meter" value="9.7" min="0" max="100"></meter>
        </div>
        <div class="meterimg">
            <div class="temoti"><img src="static/img/temoti.png" alt="temoti"></div>
            <div class="kyuuryoubi"><img src="static/img/kyuuryoubi.png" alt="kyuuryoubi"></div>
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
            <form class="myform" action="my_page_edit" method="post" id="my_edit_form">
                <div class="itemcenter container">
                    <p><span class="hissu">＊</span>ニックネーム：</p>
                    <input type="text" name="nick" placeholder="ニックネームを入力してください。" value=<%=nick%>>
                </div>

                <div class="itemcenter container">
                    <p>最推し：</p>
                    <select id="mypage-saiosi" name="saiosi">
                        <option value="0" disabled hidden>最推しを入力してください</option>
                        <%
                            boolean isSaioshiSelected = false; // 最推しが選択されているかのフラグ
                            // favelistがnullでない場合にのみループを実行
                            if (favelist != null && !favelist.isEmpty()) {
                                for (faveBean fave : favelist) {
                                    int osi_id = fave.getOsi_id();
                                    String name = fave.getName();
                                    // 最推しが選択されている場合
                                    if (selectedSaioshi != null && osi_id == saiosi) {
                                        isSaioshiSelected = true;
                        %>
                        <!-- 一致した最推しをデフォルト選択にする -->
                        <option value="<%= osi_id %>" selected><%= name %></option>
                        <%
                        } else {
                        %>
                        <option value="<%= osi_id %>"><%= name %></option>
                        <%
                                }
                            }
                        } else {
                        %>
                        <option value="0" disabled>推しが登録されていません</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="saiosi">
                    <img src="<%= saioshiImg %>" alt="saiosipic">
                </div>

                <div class="icon container">
                    <label>
                        <input type="radio" name="regimg" value="0" <%= (icon == 0) ? "checked" : "" %>>
                        <img src="static/img/I_N.png" alt="normal">
                    </label>
                    <label>
                        <input type="radio" name="regimg" value="1" <%= (icon == 1) ? "checked" : "" %>>
                        <img src="static/img/I_B.png" alt="blue">
                    </label>
                    <label>
                        <input type="radio" name="regimg" value="2" <%= (icon == 2) ? "checked" : "" %>>
                        <img src="static/img/I_G.png" alt="green">
                    </label>
                    <label>
                        <input type="radio" name="regimg" value="3" <%= (icon == 3) ? "checked" : "" %>>
                        <img src="static/img/I_R.png" alt="red">
                    </label>
                    <label>
                        <input type="radio" name="regimg" value="4" <%= (icon == 4) ? "checked" : "" %>>
                        <img src="static/img/I_V.png" alt="violet">
                    </label>
                    <label>
                        <input type="radio" name="regimg" value="5" <%= (icon == 5) ? "checked" : "" %>>
                        <img src="static/img/I_Y.png" alt="yellow">
                    </label>
                </div>


                <div class="ma itemcenter container">
                    <p><span class="hissu">＊</span>達成金額：</p>
                    <div>
                        <div class="itemcenter container">
                            <input id="amo-range" type="text" name="amount" placeholder="達成金額を入力してください。"
                                   value="<%=amounthand%>" oninput="syncRange('amo-range', 'amount-range')">
                            <button class="mai bu" type="button" onclick="adjustAmount(-100, 'amo-range', 'amount-range')">－</button>
                            <button class="pul bu" type="button" onclick="adjustAmount(100, 'amo-range', 'amount-range')">+</button>
                        </div>
                        <input type="range" name="amount" value="<%=amounthand%>" min="0" max="999999" id="amount-range"
                               class="amo" oninput="syncInput('amo-range', 'amount-range')" />
                        <div class="aw container">
                            <p>0</p>
                            <p class="me">　</p>
                            <p>99,999</p>
                        </div>
                    </div>
                </div>

                <div class="itemcenter container">
                    <p><span class="hissu">＊</span>生活費：</p>
                    <div>
                        <div class="itemcenter container">
                            <input id="exp-range" type="text" name="expense" placeholder="生活費を入力してください。"
                                   value="<%=living%>" oninput="syncRange('exp-range', 'expense-range')">
                            <button class="mai bu" type="button" onclick="adjustAmount(-100, 'exp-range', 'expense-range')">－</button>
                            <button class="pul bu" type="button" onclick="adjustAmount(100, 'exp-range', 'expense-range')">+</button>
                        </div>
                        <input type="range" name="living" value="<%=living%>" min="0" max="999999" id="expense-range"
                               class="expe" oninput="syncInput('exp-range', 'expense-range')" />
                        <div class="aw container">
                            <p>0</p>
                            <p class="me">　</p>
                            <p>999,999</p>
                        </div>
                    </div>
                </div>


                <div class="btn">
                    <button type="submit" class="in" id="confirm">完了</button>
                    <a class="kyan" href="my_page">キャンセル</a>
                </div>
            </form>
        </div>

    </div>
</div>
<script src="static/js/MypageFile/mypage_edit.js"></script>
<script src="static/js/all.js"></script>
</body>
<footer>
    <p>© 2024 Time of Fave Inc. All Rights Reserved.</p>
</footer>
</html>
