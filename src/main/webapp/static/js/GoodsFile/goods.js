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


// アイコンを押すと左から右に移動
function moveToPurchased(event, itemId) {
    event.stopPropagation();

    const targetElement = event.target.closest('.guzzu');
    if (!targetElement) {
        console.error("移動対象の要素が見つかりません");
        return;
    }

    const rightSide = document.querySelector('.right-side');
    if (!rightSide) {
        console.error("右側のコンテナが見つかりません");
        return;
    }

    // 元の位置を保存
    const leftSide = document.querySelector('.left-side');
    const index = Array.from(leftSide.children).indexOf(targetElement);
    targetElement.dataset.index = index; // インデックスを保存

    // ステータスリセット
    const app = targetElement.querySelector('.app');
    if (app) {
        app.textContent = '';
    }

    // アイコン変更
    const imgElement = targetElement.querySelector('img');
    if (imgElement) {
        imgElement.src = 'static/img/購入済.png';
        imgElement.onclick = (e) => moveToLeft(e, itemId); // 左に戻すイベントを設定
    }

    // レイアウト変更
    targetElement.classList.add('purchased-item');
    rightSide.appendChild(targetElement);
}




// 左から右に移動する関数
function moveToLeft(event, itemId) {
    event.stopPropagation();

    const targetElement = event.target.closest('.purchased-item');
    if (!targetElement) {
        console.error("移動対象の要素が見つかりません");
        return;
    }

    const leftSide = document.querySelector('.left-side');
    if (!leftSide) {
        console.error("左側のコンテナが見つかりません");
        return;
    }

    // 保存されたインデックスを取得
    const index = parseInt(targetElement.dataset.index, 10);

    // アイコン変更
    const imgElement = targetElement.querySelector('img');
    if (imgElement) {
        imgElement.src = 'static/img/Y_A.png';
        imgElement.onclick = (e) => moveToPurchased(e, itemId); // 右に移動するイベントを設定
    }

    // クラス変更
    targetElement.classList.remove('purchased-item');

    // 指定した位置に挿入
    if (index >= 0 && index < leftSide.children.length) {
        leftSide.insertBefore(targetElement, leftSide.children[index]);
    } else {
        leftSide.appendChild(targetElement); // 最後に追加
    }
}

document.getElementById('plus-link').addEventListener('click', function(event) {
    // 現在のページのURLをlocalStorageに保存
    const currentUrl = window.location.href;
    localStorage.setItem('previousPage', currentUrl);
    // 通常のリンク遷移を許可する
});


// アイコン画像をクリックして左側に移動させる関数
function moveToLeftSide(event, itemId) {
    event.stopPropagation(); // 親要素のクリックイベントをキャンセル

    // クリックされた要素の親コンテナを取得
    const targetElement = event.target.closest('.guzzu-right');
    if (!targetElement) return; // 親要素が見つからない場合は終了

    // 左側のコンテナを取得
    const leftSide = document.querySelector('.left-side');
    if (!leftSide) {
        console.error("左側のコンテナが見つかりません。");
        return;
    }

    // 元のアイテムを複製
    const itemClone = targetElement.cloneNode(true);

    // ステータスや値段をリセット
    const app = itemClone.querySelector('.app');
    if (app) {
        app.textContent = ''; // ステータスをリセット
    }

    // アイコンの画像を変更する
    const imgElement = itemClone.querySelector('img');
    if (imgElement) {
        imgElement.src = 'static/img/Y_A.png'; // 左側用の画像に変更
        imgElement.onclick = (e) => moveToRightSide(e, itemId); // 右に戻すイベントを設定
    } else {
        console.error("画像が見つかりませんでした。");
    }

    // 左側のレイアウトに合わせるためのクラスを追加
    itemClone.classList.add('purchased-left-item');

    // 左側に追加
    leftSide.appendChild(itemClone);

    // 元のアイテムを削除
    targetElement.remove();
}



// アイコン画像をクリックして右側に戻す関数
function moveToRightSide(event, itemId) {
    event.stopPropagation(); // 親要素のクリックイベントをキャンセル

    // クリックされた要素の親コンテナを取得
    const targetElement = event.target.closest('.purchased-left-item');
    if (!targetElement) return; // 親要素が見つからない場合は終了

    // 右側のコンテナを取得
    const rightSideOne = document.querySelector('.right-side-one');
    if (!rightSideOne) {
        console.error("右側のコンテナが見つかりません。");
        return;
    }

    // 元のアイテムを複製
    const itemClone = targetElement.cloneNode(true);

    // ステータスを更新
    const app = itemClone.querySelector('.app');
    if (app) {
        app.textContent = 'Complete！'; // ステータスを表示
    }

    // アイコンの画像を変更する
    const imgElement = itemClone.querySelector('img');
    if (imgElement) {
        imgElement.src = 'static/img/購入済.png'; // 右側用の画像に変更
        imgElement.onclick = (e) => moveToLeftSide(e, itemId); // 左に移動するイベントを設定
    } else {
        console.error("画像が見つかりませんでした。");
    }

    // 右側のレイアウトに合わせるためのクラスを追加
    itemClone.classList.add('purchased-right-item');

    // 右側のコンテナに追加
    rightSideOne.prepend(itemClone); // 一番上に追加

    // 元のアイテムを削除
    targetElement.remove();
}


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
