function toggleForm() {
    if (checkbox.checked) {
        title.textContent = 'イベント';
        goodsForm.style.display = 'none';
        eventsForm.style.display = 'block';
    } else {
        title.textContent = 'グッズ';
        goodsForm.style.display = 'block';
        eventsForm.style.display = 'none';
    }
}


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
const itemType = document.getElementById("switch");
// 初期状態でイベントフォームを非表示
eventsForm.style.display = 'none';
goodsForm.style.display = 'none'; // 最初はどちらも非表示にする

// 初期状態でフォームを表示
if (itemType.checked) {
    eventsForm.style.display = 'block';
    title.textContent = 'イベント';
} else {
    goodsForm.style.display = 'block';
    title.textContent = 'グッズ';
}

// トグルクリック時にフォームを切り替え
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

// トグルボタンのクリックイベントリスナー
checkbox.addEventListener('click', toggleForm);

// 初期状態でフォームを切り替える（ページ読み込み時に反映）
toggleForm();


        // モーダルの表示/非表示(グッズ、イベント)
document.getElementById('plusButtonGoods').addEventListener('click', () => showModal(easyModalGoods));
document.getElementById('plusButtonEvents').addEventListener('click', () => showModal(easyModalEvents));
// キャンセルボタン処理
buttonCancelGoods.addEventListener('click', () => closeModal(easyModalGoods));
buttonCancelEvents.addEventListener('click', () => closeModal(easyModalEvents));
// 完了ボタン処理 (グッズ)
buttonConfirmGoods.addEventListener('click', () => {
    const inputName = document.querySelector("#plusForm input[name='modalosi']").value;
    if (inputName === "") {
        alert("推しの名前を入力してください。");
        return;
    }
    console.log("追加する推しの名前:", inputName);
    document.getElementById('plusForm').submit();
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
function closeModal(modalElement) {
    modalElement.style.display = 'none';
}

// モーダルを表示する関数
function showModal(modalElement) {
    modalElement.style.display = 'block';
}

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

window.addEventListener('DOMContentLoaded', function() {
    document.getElementById('confirmReGoods').addEventListener('click', function() {
        const form = document.querySelector('.goods_edit_form');
        if (form) {
            form.submit(); // フォーム送信
            document.getElementById('easyModalGoods').style.display = 'none'; // モーダル閉じる
        } else {
            console.error('goods_editフォームが見つかりません');
        }
    });

    document.getElementById('confirmReEvents').addEventListener('click', function() {
        const form = document.querySelector('.events_edit_form');
        if (form) {
            form.submit(); // フォーム送信
            document.getElementById('easyModalEvents').style.display = 'none'; // モーダル閉じる
        } else {
            console.error('events_editフォームが見つかりません');
        }
    });
});

// グッズモーダル
document.getElementById('modalOpenGoods').addEventListener('click', function () {
    document.getElementById('easyModalGoods').style.display = 'block';

    const goodsDate = document.getElementById('goods-date')?.value || '';
    const goodsName = document.querySelector('.goods_name')?.value || '';
    const goodsAmount = document.getElementById('goods-amount')?.value || '';
    const goodsMemo = document.getElementById('goods-memo')?.value || '';
    const goodsPurchased = document.querySelector('input[name="purchase"]:checked');

    const goodsFavoriteSelect = document.querySelector('select[name="osi_id"]');
    const goodsFavoriteOption = goodsFavoriteSelect?.selectedOptions[0];
    const goodsFavoriteName = goodsFavoriteOption ? goodsFavoriteOption.getAttribute('data-name') : '未選択';

    const goodsIconRadio = document.querySelector('input[name="goodsicon"]:checked');
    const goodsIconValue = goodsIconRadio ? goodsIconRadio.value : '2';
    const goodsIconPath = `static/img/Y_${goodsIconValue}.png`;
    const goodsFavoriteIcon = `<img src="${goodsIconPath}" alt="favorite icon">`;

    document.getElementById('modal-goods-date').textContent = goodsDate;
    document.getElementById('modal-goods-name').textContent = goodsName;
    document.getElementById('modal-goods-amount').textContent = goodsAmount;
    document.getElementById('modal-goods-favorite').textContent = goodsFavoriteName;
    document.getElementById('modal-goods-prioity').innerHTML = goodsFavoriteIcon;
    document.getElementById('modal-goods-memo').textContent = goodsMemo;

    const purchasedText = goodsPurchased ? '<span style="color: green;">✔ 購入済み</span>' : '<span style="color: red;">✘ 購入前</span>';
    document.getElementById('modal-goods-purchased').innerHTML = purchasedText;

    const goodsForm = document.getElementById('goodsForm');
    goodsForm.querySelector('input[name="formType"]').value = 'goods';
    // モーダルを表示
    document.getElementById('easyModalGoods').style.display = 'block';
});

// イベントモーダル
document.getElementById('modalOpenEvents').addEventListener('click', function () {
    document.getElementById('easyModalEvents').style.display = 'block';

    const eventDate = document.getElementById('event-date')?.value || '';
    const eventName = document.getElementById('event-name')?.value || '';
    const eventAmount = document.getElementById('event-amount')?.value || '';
    const eventMemo = document.getElementById('event-memo')?.value || '';
    const eventPurchased = document.querySelector('#event-check:checked');

    const eventFavoriteSelect = document.querySelector('select[name="osi_id"]');
    const eventFavoriteOption = eventFavoriteSelect?.selectedOptions[0];
    const eventFavoriteName = eventFavoriteOption ? eventFavoriteOption.getAttribute('data-name') : '未選択';

    const eventIconRadio = document.querySelector('input[name="eventicon"]:checked');
    const eventIconValue = eventIconRadio ? eventIconRadio.value : '2';
    const eventIconPath = `static/img/Y_${eventIconValue}.png`;
    const eventFavoriteIcon = `<img src="${eventIconPath}" alt="favorite icon">`;

    document.getElementById('modal-events-date').textContent = eventDate;
    document.getElementById('modal-events-name').textContent = eventName;
    document.getElementById('modal-events-amount').textContent = eventAmount;
    document.getElementById('modal-events-favorite').textContent = eventFavoriteName;
    document.getElementById('modal-events-prioity').innerHTML = eventFavoriteIcon;
    document.getElementById('modal-events-memo').textContent = eventMemo;

    const purchasedText = eventPurchased ? '<span style="color: green;">✔ 購入済み</span>' : '<span style="color: red;">✘ 購入前</span>';
    document.getElementById('modal-events-purchased').innerHTML = purchasedText;

    const eventForm = document.getElementById('eventForm');
    eventForm.querySelector('input[name="formType"]').value = 'event';
    // モーダルを表示
    document.getElementById('easyModalEvents').style.display = 'block';
});

// キャンセルボタン
document.getElementById('cancelReGoods').addEventListener('click', function() {
    document.getElementById('easyModalGoods').style.display = 'none';
});
document.getElementById('cancelReEvents').addEventListener('click', function() {
    document.getElementById('easyModalEvents').style.display = 'none';
});