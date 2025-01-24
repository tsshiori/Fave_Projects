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

document.getElementById('plus-link').addEventListener('click', function(event) {
    // 現在のページのURLをlocalStorageに保存
    const currentUrl = window.location.href;
    localStorage.setItem('previousPage', currentUrl);
    // 通常のリンク遷移を許可する
});

// 右側のモーダルを開くための関数
function toggleRightModal(modalId, displayStyle) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = displayStyle; // 指定された表示スタイルを適用
    }
}

// 右側のモーダルを開く関数
function openRightModal(itemId) {
    const modal = document.getElementById('modalOpenMain');  // 右側モーダル要素
    const content = document.getElementById('modal-content-right');  // モーダル内のコンテンツ部分

    // アイテム情報を取得してモーダルに設定
    const itemElement = document.getElementById(itemId);
    const itemName = itemElement.querySelector('.name').textContent;
    const itemPrice = itemElement.querySelector('.price').textContent;
    const itemOshi = itemElement.querySelector('.osi').textContent;

    // モーダルに情報をセット
    document.getElementById('item-name').textContent = itemName;
    document.getElementById('item-price').textContent = itemPrice;
    document.getElementById('item-oshi').textContent = itemOshi;
    document.getElementById('item-date').textContent = '2024/11/16';

    // 右側モーダルを表示
    toggleRightModal('modalOpenMain', 'flex');
}

// 右側のモーダルを閉じる関数
function closeRightModal() {
    toggleRightModal('modalOpenMain', 'none'); // 右側モーダルを非表示にする
}

// 削除モーダルを開く
function openRightDeleteModal(itemId) {
    const deleteButton = document.getElementById('confirmDeleteButton');
    if (deleteButton) {
        deleteButton.setAttribute('data-item-id', itemId); // 削除対象のアイテムIDを設定
    }
    toggleRightModal('modalOpenDelete', 'flex'); // 削除モーダルを表示
}

// 削除モーダルを閉じる
function closeRightDeleteModal() {
    toggleRightModal('modalOpenDelete', 'none'); // モーダルを非表示
}

// 削除処理
function confirmDelete() {
    const deleteButton = document.getElementById('mDelete');
    if (deleteButton) {
        const itemId = deleteButton.getAttribute('data-item-id'); // アイテムIDを取得
        const itemElement = document.getElementById(itemId); // 対象要素を取得

        if (itemElement) {
            itemElement.remove(); // アイテムを削除
        } else {
            console.error("削除対象のアイテムが見つかりません");
        }
    }
    document.getElementById("goods_del_modal").submit();
}

// 各アイテムの削除ボタンを設定
function setupDeleteButtons() {
    const deleteButtons = document.querySelectorAll('.delete-btn');
    deleteButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const itemId = button.closest('.purchased-right-item').id; // アイテムIDを取得
            openRightDeleteModal(itemId); // 削除モーダルを開く
            event.stopPropagation(); // 他のクリックイベントを防止
        });
    });
}

// ページ読み込み時に削除ボタンのイベントを設定
document.addEventListener('DOMContentLoaded', () => {
    setupDeleteButtons();
    document.getElementById('mDelete').addEventListener('click', confirmDelete);
});



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
