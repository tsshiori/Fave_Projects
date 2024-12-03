// アイテムを右側に移動させる関数
function moveToPurchased(event, itemId) {
    event.stopImmediatePropagation(); // 親要素のクリックイベントを完全に停止

    const item = document.getElementById(itemId); // 元のアイテムを取得
    if (!item) return; // アイテムが存在しない場合は処理しない

    // ステータスを変更
    const app = item.querySelector('.app');
    if (app) {
        app.innerHTML = 'Complete！'; // ステータスを更新
    }

    // 右側の特定のコンテナにアイテムを追加
    const targetContainer = document.querySelector('.right-side-one');
    if (targetContainer) {
        targetContainer.prepend(item); // アイテムを一番上に追加
    } else {
        console.error("ターゲット要素が見つかりません。");
    }

    // 左側のリストからアイテムを削除
    const leftSide = document.querySelector('.left-side');
    if (leftSide) {
        leftSide.removeChild(item); // 左側からアイテムを削除
    } else {
        console.error("左側のコンテナが見つかりません。");
    }
}


// アイコン画像をクリックして左側に移動させる関数
function moveToLeftSide(event, itemId) {
    event.stopPropagation(); // 親要素のクリックイベントをキャンセル

    const item = document.getElementById(itemId);
    if (!item) return; // アイテムが存在しない場合は処理しない

    const itemClone = item.cloneNode(true); // アイテムを複製

    // 移動元のアイテムの値段をそのまま複製
    const price = item.querySelector('.price'); // 元のアイテムの値段を取得
    if (price) {
        const priceClone = itemClone.querySelector('.price');
        priceClone.textContent = price.textContent; // 複製したアイテムに値段を反映
    }

    const app = itemClone.querySelector('.app');
    if (app) {
        app.innerHTML = ''; // ステータスをリセット
    }

    // 左側のリストにアイテムを追加
    const leftSide = document.querySelector('.left-side');
    if (leftSide) {
        leftSide.appendChild(itemClone);
    } else {
        console.error("左側のコンテナが見つかりません。");
    }

    // 右側からアイテムを削除
    item.remove();
}

// モーダルを開く関数
function toggleModal(modalId, displayStyle) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = displayStyle; // 指定された表示スタイルを適用
    }
}

// モーダルを開く関数
function openModal() {
    toggleModal('openModal', 'flex'); // モーダルを表示
}

// モーダルを閉じる関数
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

function confirmDelete() {
    // ここに削除処理を追加する場合は記述
    // 例: アイテムの削除処理を行う

    //リロード
    window.location.href = 'GoodsServlet';
}

// 閉じるボタンにイベントリスナーを設定
document.getElementById("mClose").addEventListener("click", closeModal);

// モーダルの外側をクリックした場合も閉じる
window.onclick = function(event) {
    const openModal = document.getElementById("openModal");
    const deleteModal = document.getElementById("deleteModal");
    if (event.target === openModal) {
        closeModal();
    } else if (event.target === deleteModal) {
        closeDeleteModal();
    }
};
