// モーダルを開くための関数
function toggleModal(modalId, displayStyle) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = displayStyle; // 指定された表示スタイルを適用
    }
}
// 左側のモーダルを開く関数
function openModal() {
    toggleModal('openModal', 'flex'); // モーダルを表示
}

// 左側のモーダルを閉じる関数
function closeModal() {
    toggleModal('openModal', 'none'); // モーダルを非表示
}

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
