<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <a href="/index/index.jsp"><img src="static/img/TimeforFave.png" alt="logo"></a>
    </div>

    <!-- メーター -->
    <div class="meter">
        <br>
        <h2>≪METER≫</h2>
        <div class="meter-container">
            <meter class="background-meter" value="75" min="0" max="100"></meter>
            <meter class="foreground-meter" value="60" min="0" max="100"></meter>
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
            <a href="/view/index.jsp">
                <h3>HOME</h3>
            </a>
        </div>
        <hr>
        <div class="fave">
            <a href="/FaveFile/fave.jsp">
                <h3>FAVE</h3>
            </a>
        </div>
        <hr>
        <div class="relate">
            <a href="/FaveFile/relate.jsp">
                <h3>RELATE</h3>
            </a>
        </div>
        <hr>
        <div class="shift">
            <a href="/ShiftFile/shift.jsp">
                <h3>SHIFT</h3>
            </a>
        </div>
        <hr>
        <div class="work">
            <a href="/WorkFile/work.jsp">
                <h3>WORK</h3>
            </a>
        </div>
        <hr>
        <div class="mypage">
            <a href="/MypageFile/mypage.jsp">
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
                        <a href="/GoodsFile/goods_add.jsp">
                            <img src="static/img/ADD.png" alt="ADD" class="add-icon">
                        </a>
                    </div>


                    <!-- カンパネルラ アクリルスタンドの商品ボックス -->
                    <div class="guzzu" style="margin-top: 20px;">
                        <div class="container" id="item1" onclick="openModal('item1', 'グッズ：　アクリルスタンド<br> 金額(円)：　￥1,980<br> 推し：　カンパネルラ<br> 日付：　2024/11/16<br>'); event.stopPropagation();">
                            <div class="hi-img">
                                <p>~11/16</p>
                                <img src="static/img/Y_A.png" alt="A" onclick="moveToPurchased(event, 'item1')">
                            </div>
                            <div class="inf-meter">
                                <div class="name-container">
                                    <div class="name-divider">
                                        <p class="osi">カンパネルラ</p>
                                        <hr class="divider">
                                        <p class="name">アクリルスタンド</p>
                                    </div>
                                </div>
                                <p class="price">¥1,980</p>
                            </div>
                            <div class="meter-app container">
                                <p class="app">Complete！</p>
                            </div>
                        </div>
                    </div>



                    <div class="event">
                        <div class="container">
                            <div class="hi-img">
                                <img src="static/img/Y_B.png" alt="B">
                            </div>
                            <div class="inf-meter">
                                <div class="name-container">
                                    <div class="name-divider">
                                        <p class="osi">ミューズ</p>
                                        <hr class="divider">
                                        <p class="name">STARMINE ver.4.0</p>
                                    </div>
                                </div>
                                <p class="price">¥12,500</p>
                                <div class="meter-app container">
                                    <p class="app">Expected…</p>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="guzzu">
                        <div class="container">
                            <div class="hi-img">
                                <p>~11/16</p>
                                <img src="static/img/Y_C.png" alt="C">
                            </div>
                            <div class="inf-meter">
                                <div class="name-container">
                                    <div class="name-divider">
                                        <p class="osi">カンパネルラ</p>
                                        <hr class="divider">
                                        <p class="name">ころころぬい ランダム</p>
                                    </div>
                                </div>
                                <p class="price">¥1,960</p>
                            </div>
                            <div class="meter-app container">
                                <p class="app">Complete！</p>
                            </div>
                        </div>
                    </div>

                    <div class="guzzu">
                        <div class="container">
                            <div class="hi-img">
                                <p>~11/16</p>
                                <img src="static/img/Y_D.png" alt="D">
                            </div>
                            <div class="inf-meter">
                                <div class="name-container">
                                    <div class="name-divider">
                                        <p class="osi">カンパネルラ</p>
                                        <hr class="divider">
                                        <p class="name">銀河鉄道模型</p>
                                    </div>
                                </div>
                                <p class="price">¥21,300</p>
                            </div>
                            <div class="meter-app container">
                                <p class="app">Complete！</p>
                            </div>
                        </div>
                    </div>

                    <div class="event">
                        <div class="container">
                            <div class="hi-img">
                                <p>~2/18</p>
                                <img src="static/img/Y_E.png" alt="E">
                            </div>
                            <div class="inf-meter">
                                <div class="name-container">
                                    <div class="name-divider">
                                        <p class="osi">ミューズ</p>
                                        <hr class="divider">
                                        <p class="name">STARLIVEツアー…</p>
                                    </div>
                                </div>
                                <p class="price">¥62,000</p>
                                <div class="meter-app container">
                                    <p class="app">Expected…</p>
                                </div>
                            </div>
                        </div>
                    </div>
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
                    <div class="right-side-one">
                        <div class="guzzu-right">
                            <div class="container">
                                <div class="hi-img-right">
                                    <p>~11/16</p>
                                    <img src="static/img/購入済.png" alt="J" class="purchase-icon"
                                         onclick="moveToLeftSide(event, 'item1')">
                                </div>
                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">カンパネルラ</p>
                                            <hr class="divider">
                                            <p class="name">アクリルパネル</p>
                                        </div>
                                    </div>
                                    <p class="price">¥2,600</p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>

                        <div class="guzzu-right" id="item2">
                            <div class="container">
                                <div class="hi-img-right">
                                    <!-- アイコンをクリックして左側に移動する -->
                                    <img src="static/img/購入済.png" alt="I">
                                </div>
                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">ミューズ</p>
                                            <hr class="divider">
                                            <p class="name">ネップリ　第2弾</p>
                                        </div>
                                    </div>
                                    <p class="price">¥4,000</p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>

                        <div class="guzzu-right">
                            <div class="container">
                                <div class="hi-img-right">
                                    <p>~11/16</p>
                                    <img src="static/img/購入済.png" alt="J">
                                </div>
                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">カンパネルラ</p>
                                            <hr class="divider">
                                            <p class="name">もちころりん　先…</p>
                                        </div>
                                    </div>
                                    <p class="price">¥2,500</p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>

                        <div class="guzzu-right">
                            <div class="container">
                                <div class="hi-img-right">
                                    <p>~11/16</p>
                                    <img src="static/img/購入済.png" alt="K">
                                </div>
                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">カンパネルラ</p>
                                            <hr class="divider">
                                            <p class="name">劇場版　始まりの…</p>
                                        </div>
                                    </div>
                                    <p class="price">¥11,300</p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>

                        <div class="event-right">
                            <div class="container">
                                <div class="hi-img-right">
                                    <p>~11/16</p>
                                    <img src="static/img/購入済.png" alt="L">
                                </div>
                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">ミューズ</p>
                                            <hr class="divider">
                                            <p class="name">STARMINE ver.1.0</p>
                                        </div>
                                    </div>
                                    <p class="price">¥9,500</p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>

                        <div class="guzzu-right">
                            <div class="container">
                                <div class="hi-img-right">
                                    <p>~11/16</p>
                                    <img src="static/img/購入済.png" alt="M">
                                </div>
                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">カンパネルラ</p>
                                            <hr class="divider">
                                            <p class="name">夏の日の思い出 ド…</p>
                                        </div>
                                    </div>
                                    <p class="price">¥3,200</p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>

                        <div class="event-right">
                            <div class="container">
                                <div class="hi-img-right">
                                    <p>~11/16</p>
                                    <img src="static/img/購入済.png" alt="N">
                                </div>
                                <div class="inf-meter">
                                    <div class="name-container">
                                        <div class="name-divider">
                                            <p class="osi">カンパネルラ</p>
                                            <hr class="divider">
                                            <p class="name">劇場版　始まりの…</p>
                                        </div>
                                    </div>
                                    <p class="price">¥2,000</p>
                                </div>
                                <div class="meter-app container">
                                    <p class="app">Complete！</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- モーダルウィンドウ -->
<!-- 共通のモーダル -->
<div id="openModal" class="modal">
    <div class="modal-content">
        <img src="static/img/Y_A.png" alt="Y_A" class="modal-image">
        <p id="modal-content-text"></p>
        <div id="modal-details">
            <table>
                <tr>
                    <td>グッズ：</td>
                    <td class="value">アクリルスタンド</td>
                </tr>
                <tr>
                    <td>金額(円)：</td>
                    <td class="value">￥1,980</td>
                </tr>
                <tr>
                    <td>推し：</td>
                    <td class="value">カンパネルラ</td>
                </tr>
                <tr>
                    <td>日付：</td>
                    <td class="value">2024/11/16</td>
                </tr>
                <tr>
                    <td class="memo-label">メモ：</td>
                    <td class="value memo-value">ビジュがよき</td>
                </tr>
            </table>
            <div class="container btn">
                <div class="img_icon">
                    <a href="static/goods_edit/goods_edit.jsp"><img src="static/img/EDIT2.png"></a>
                </div>
                <div class="img_icon">
                    <a href="#" onclick="openDeleteModal()"><img src="static/img/DELE2.png"></a>
                </div>
            </div>
        </div>
        <button id="mClose" type="button" class="btn" onclick="closeButton()">閉じる</button>
    </div>
</div>

<!-- 削除用モーダル -->
<div id="deleteModal" class="modal">
    <div class="modal-content-center">
        <h3>本当に削除しますか？</h3>
        <div class="delete-h4">
            <h6>※消した後は二度と元に戻れません。</h6>
        </div>

        <div class="delete-details">
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
                    <td><img src="static/img/Y_A.png" alt="Y_A" class="priority-image"></td>
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
                    <td><input type="checkbox" class="text">
                        <span class="text">※購入済みの場合はチェックを入れてください。</span>
                    </td>
                </tr>
            </table>
        </div>


        <button id="mDelete" type="button" class="btn delete-btn" onclick="confirmDelete()">削除</button>
        <button id="mCancel" type="button" class="btn cancel-btn" onclick="closeDeleteModal()">キャンセル</button>
    </div>
</div>


<script src="static/js/GoodsFile/goods.js"></script>


<footer class="footer">
    <p>©️ 2024 Time for Fave. All rights reserved.</p>
</footer>
</body>

</html>
