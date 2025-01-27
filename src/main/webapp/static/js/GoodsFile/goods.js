// モーダルを開くための関数
function toggleModal(modalId, displayStyle) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = displayStyle; // 指定された表示スタイルを適用
    }
}
// 左側のモーダルを開く関数
function openModal(item, price, osi, day, priority,memo,purchase) {
    // モーダル内の要素を取得
    const modal = document.getElementById('openModal');
    const modalContentText = document.getElementById('modal-content-text');
    const modalDetails = document.getElementById('modal-details');
    const priorityImage = document.querySelector('.modal-image');  // 優先度画像の要素を取得

    // データをモーダル内に設定
    modalDetails.querySelector('table').innerHTML = `
        <tr>
            <td>グッズ：</td>
            <td class="value">${item}</td>
        </tr>
        <tr>
            <td>金額(円)：</td>
            <td class="value">¥${Number(price).toLocaleString()}</td>
        </tr>
        <tr>
            <td>推し：</td>
            <td class="value">${osi}</td>
        </tr>
        <tr>
            <td>日付：</td>
            <td class="value">${day}</td>
        </tr>
        <tr>
             <td class="memo-label">メモ：</td>
             <td class="value memo-value">${memo}</td>
        </tr>

    `;

    // 優先度の画像を更新
    if(purchase == 0) {
        priorityImage.src = `static/img/Y_${priority}.png`;  // 優先度に応じた画像を設定
    }else{
        priorityImage.src = `static/img/購入済.png`;  // 優先度に応じた画像を設定
    }

    // モーダルを表示
    modal.style.display = 'block';
}


// モーダルを閉じる
function closeButton() {
    const modal = document.getElementById('openModal');
    modal.style.display = 'none';
}

// モーダル外をクリックした場合に閉じる
window.onclick = function(event) {
    const modal = document.getElementById('openModal');
    if (event.target == modal) {
        modal.style.display = 'none';
    }
};


// 削除用モーダルを開く関数
function openDeleteModal() {
    toggleModal('deleteModal', 'flex'); // 削除モーダルを表示
}

// 削除用モーダルを閉じる関数
function closeDeleteModal() {
    toggleModal('deleteModal', 'none'); // 削除モーダルを非表示
}

// 削除ボタンを押すときに使うやつ
// function confirmDelete() {
//     // ここに削除処理を追加する場合は記述
//     // 例: アイテムの削除処理を行う
//
//     window.location.href = 'fave.jsp';
// }

// 閉じるボタンにイベントリスナーを設定
document.getElementById("mClose").addEventListener("click", closeModal);















function submitFormBought(osikatuId) {
    // 対応するフォームを取得
    const form = document.getElementById(`bought_form_${osikatuId}`);
    if (form) {
        form.submit(); // フォームを送信
    } else {
        console.error(`Form with ID bought_form_${osikatuId} not found.`);
    }
}

function submitFormBuy(osikatuId) {
    console.log("Form submission triggered for osikatuId:", osikatuId); // デバッグ用ログ
    const form = document.getElementById(`buy_form_${osikatuId}`);
    if (form) {
        form.submit();
    } else {
        console.error(`Form with ID buy_form_${osikatuId} not found.`);
    }
}
