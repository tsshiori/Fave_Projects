
    // モーダルの要素
    const checkbox = document.getElementById('switch');
    const title = document.querySelector('.title');
    const goodsForm = document.getElementById('goods');
    const eventsForm = document.getElementById('events');
    const easyModalGoods = document.getElementById('modalGoods');
    const easyModalEvents = document.getElementById('modalEvents');
    const buttonCancelGoods = document.getElementById('ReGoods');
    const buttonConfirmGoods = document.getElementById('AddGoods');
    const buttonCancelEvents = document.getElementById('ReEvents');
    const buttonConfirmEvents = document.getElementById('AddEvents');

    // 初期状態でイベントフォームを非表示
    eventsForm.style.display = 'none';

    // フォームの表示切替
    checkbox.addEventListener('click', () => {
        if (checkbox.checked) {
            title.textContent = 'イベント';
            goodsForm.style.display = 'none';
            eventsForm.style.display = 'block';
        } else {
            title.textContent = 'グッズ';
            goodsForm.style.display = 'block';
            eventsForm.style.display = 'none';
        }
    });

    // モーダルの表示/非表示(グッズ、イベント)
    document.getElementById('plusButtonGoods').addEventListener('click', () => showModal(easyModalGoods));
    document.getElementById('plusButtonEvents').addEventListener('click', () => showModal(easyModalEvents));

    // キャンセルボタン処理
    buttonCancelGoods.addEventListener('click', () => closeModal(easyModalGoods));
    buttonCancelEvents.addEventListener('click', () => closeModal(easyModalEvents));

    // 完了ボタン処理 (グッズ)
    buttonConfirmGoods.addEventListener('click', () => {
        const inputName = document.querySelector("#plusForm input[name='modalosi']").value;
        console.log("追加する推しの名前:", inputName);
        closeModal(easyModalGoods); // 確認後、グッズモーダルを閉じる
    });

    // 完了ボタン処理 (イベント)
    document.querySelector("#AddEvents").addEventListener('click', () => {
        const inputName = document.querySelector("#plusFormEvents input[name='modalosi']").value.trim();
        if (inputName === "") {
            alert("推しの名前を入力してください。");
            return;
        }
        console.log("追加する推しの名前:", inputName);
        document.getElementById('plusFormEvents').submit();
    });


    // モーダルを非表示にする関数
    // function closeModal(modalElement) {
    //     modalElement.style.display = 'none';
    // }
    //
    // // モーダルを表示する関数
    // function showModal(modalElement) {
    //     modalElement.style.display = 'block';
    // }

    // モーダル外側をクリックした場合にモーダルを閉じる
    window.addEventListener("click", (event) => {
        if (event.target === easyModalGoods) closeModal(easyModalGoods);
        if (event.target === easyModalEvents) closeModal(easyModalEvents);
    });

    // モーダルの「閉じる」ボタンにイベントリスナーを追加
    document.getElementById("closeModalGoods").addEventListener("click", () => closeModal(easyModalGoods));
    document.getElementById("closeModalEvents").addEventListener("click", () => closeModal(easyModalEvents));



document.querySelector('.back-button').addEventListener('click', function () {
    // 保存したURLを取得
    const previousPage = localStorage.getItem('previousPage');

    if (previousPage) {
        // 保存したURLに戻る
        window.location.href = previousPage;
    } else {
        alert('前のページが見つかりません');
    }
});

document.getElementById('confirmReGoods').addEventListener('click', function () {
    // フォームを取得
    const form = document.querySelector('.goods_add_form');

    if (form) {
        // フォーム送信
        form.submit();
    } else {
        console.error('フォームが見つかりません');
    }
});

document.getElementById('confirmReEvents').addEventListener('click', function () {
    // フォームを取得
    const form = document.querySelector('.events_add_form'); // classのフォームを取得

    if (form) {
        // フォーム送信
        form.submit();
    } else {
        console.error('フォームが見つかりません');
    }
});



//グッズモーダル
    document.getElementById('modalOpenGoods').addEventListener('click', function () {

        // モーダルを表示
        document.getElementById('easyModalGoods').style.display = 'block';

        // グッズフォームからデータを取得
        const goodsDate = document.getElementById('goods-date')?.value || '';
        const goodsName = document.querySelector('.goods_name')?.value || '';
        const goodsAmount = document.getElementById('goods-amount')?.value || '';
        const goodsPrioity = document.getElementById('goods-prioity')?.value || '';
        const goodsMemo = document.getElementById('goods-memo')?.value || '';
        const goodsPurchased = document.querySelector('input[name="purchase"]:checked'); // チェックされた購入済みのチェックボックス

        // 推しの選択肢から選ばれたoptionを取得
        const goodsFavoriteSelect = document.querySelector('select[name="osi_id"]');
        if (!goodsFavoriteSelect) {
            console.error("推し選択のセレクトボックスが見つかりません");
            return; // セレクトボックスがない場合、処理を終了
        }

        const goodsFavoriteOption = goodsFavoriteSelect.selectedOptions[0];  // 選ばれたオプション
        const goodsFavoriteName = goodsFavoriteOption ? goodsFavoriteOption.getAttribute('data-name') : '未選択';

        // アイコン画像のURLを生成
        const selectedIconRadio = document.querySelector('input[name="icon"]:checked');
        const selectedIconValue = selectedIconRadio ? selectedIconRadio.value : '2';  // もし何も選ばれていなければ'2'（デフォルト値）
        const iconPath = `static/img/Y_${selectedIconValue}.png`;  // 選ばれたアイコンに対応する画像パス

        const goodsFavoriteIcon = `<img src="${iconPath}" alt="favorite icon">`;

        // モーダルにデータを表示
        document.getElementById('modal-goods-date').textContent = goodsDate;
        document.getElementById('modal-goods-name').textContent = goodsName;
        document.getElementById('modal-goods-amount').textContent = goodsAmount;
        document.getElementById('modal-goods-favorite').textContent = goodsFavoriteName;  // 推しの名前を表示
        document.getElementById('modal-goods-prioity').innerHTML = goodsFavoriteIcon;  // アイコン追加
        document.getElementById('modal-goods-memo').textContent = goodsMemo;

        // 購入済の状態を表示
        const purchasedText = goodsPurchased ?
            '<span style="color: green;">✔ 購入済み</span>' :
            '<span style="color: red;">✘ 購入前</span>';
        document.getElementById('modal-goods-purchased').innerHTML = purchasedText;

        // モーダルを表示
        document.getElementById('easyModalGoods').style.display = 'block';
    });






    // イベントモーダル
    document.getElementById('modalOpenEvents').addEventListener('click', function () {

        // モーダルを表示
        document.getElementById('easyModalEvents').style.display = 'block';

        // イベントフォームからデータを取得
        const eventDate = document.getElementById('event-date')?.value || '';
        const eventName = document.getElementById('event-name')?.value || '';
        const eventAmount = document.getElementById('event-amount')?.value || '';
        const eventMemo = document.getElementById('event-memo')?.value || '';
        const eventPurchased = document.querySelector('#event-check:checked'); // チェックされた購入済みのチェックボックス

        // 推しの選択肢から選ばれたoptionを取得
        const eventFavoriteSelect = document.querySelector('select[name="osi_id"]');
        if (!eventFavoriteSelect) {
            console.error("推し選択のセレクトボックスが見つかりません");
            return; // セレクトボックスがない場合、処理を終了
        }

        const eventFavoriteOption = eventFavoriteSelect.selectedOptions[0];  // 選ばれたオプション
        const eventFavoriteName = eventFavoriteOption ? eventFavoriteOption.getAttribute('data-name') : '未選択';

        // アイコン画像のURLを生成
        const selectedIconRadio = document.querySelector('input[name="icon"]:checked');
        const selectedIconValue = selectedIconRadio ? selectedIconRadio.value : '2';  // もし何も選ばれていなければ'2'（デフォルト値）
        const iconPath = `static/img/Y_${selectedIconValue}.png`;  // 選ばれたアイコンに対応する画像パス

        const eventFavoriteIcon = `<img src="${iconPath}" alt="favorite icon">`;

        // モーダルにデータを表示
        document.getElementById('modal-events-date').textContent = eventDate;
        document.getElementById('modal-events-name').textContent = eventName;
        document.getElementById('modal-events-amount').textContent = eventAmount;
        document.getElementById('modal-events-favorite').textContent = eventFavoriteName;  // 推しの名前を表示
        document.getElementById('modal-events-prioity').innerHTML = eventFavoriteIcon;  // アイコン追加
        document.getElementById('modal-events-memo').textContent = eventMemo;

        // 購入済の状態を表示
        const purchasedText = eventPurchased ?
            '<span style="color: green;">✔ 購入済み</span>' :
            '<span style="color: red;">✘ 購入前</span>';
        document.getElementById('modal-events-purchased').innerHTML = purchasedText;

        // モーダルを表示
        document.getElementById('easyModalEvents').style.display = 'block';
    });


    // デバッグ用: plusButtonGoodsの確認
    const plusButtonGoods = document.getElementById('plusButtonGoods');
    if (!plusButtonGoods) {
        console.error('plusButtonGoodsが見つかりません');
    }

document.getElementById('cancelReGoods').addEventListener('click', function() {
    document.getElementById('easyModalGoods').style.display = 'none';
});

document.getElementById('cancelReEvents').addEventListener('click', function() {
    document.getElementById('easyModalEvents').style.display = 'none';
});
document.getElementById('confirmReGoods').addEventListener('click', function() {
    // フォーム送信
    document.getElementById('goods_add').submit();
    document.getElementById('easyModalGoods').style.display = 'none'; // モーダル閉じる
});

document.getElementById('confirmReEvents').addEventListener('click', function() {
    document.getElementById('events_add').submit(); // フォーム送信
    document.getElementById('easyModalEvents').style.display = 'none'; // モーダル閉じる
});

