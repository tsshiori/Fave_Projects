// モーダルを開くための関数
function toggleModal(modalId, displayStyle) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = displayStyle; // 指定された表示スタイルを適用
    }
}
// 左側のモーダルを開く関数
function openModal(osikatu_id, item, price, osi, day, priority, memo, purchase) {
    const modal = document.getElementById('openModal');
    const modalDetails = document.getElementById('modal-details');
    const priorityImage = document.querySelector('.modal-image');

    // osikatu_idを使用してURLを更新
    const editButton = document.getElementById("editButton");

    if (editButton) {
        editButton.onclick = function () {
            window.location.href = `goods_edit?osikatu_id=${encodeURIComponent(osikatu_id)}`;
        };
    }


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

    if(purchase == 0) {
        priorityImage.src = `static/img/Y_${priority}.png`;
    } else {
        priorityImage.src = `static/img/購入済.png`;
    }

    // 削除ボタンに削除モーダルを開くためのデータを渡す
    const deleteButton = document.getElementById('del');
    deleteButton.onclick = function () {
        openDeleteModal(osikatu_id, item, price, osi, day, priority, memo, purchase);
    };

    modal.style.display = 'block';
}

    // 削除用モーダルを開く関数
function openDeleteModal(osikatu_id, item, price, osi, day, priority, memo, purchase) {
    const deleteModal = document.getElementById('deleteModal');
    const deleteModalTable = document.getElementById('deleteModalTable');

    // priority に応じた画像パスを決定
    let priorityImagePath = purchase == 0
        ? `static/img/Y_${priority}.png`
        : `static/img/購入済.png`;

    // 削除モーダルのテーブル内容を設定（画像を追加）
    deleteModalTable.innerHTML = `
        <tr>
            <th>日付：</th>
            <td class="value">${day}</td>
        </tr>
        <tr>
            <th>グッズ：</th>
            <td class="value">${item}</td>
        </tr>
        <tr>
            <th>金額(円)：</th>
            <td class="value">¥${Number(price).toLocaleString()}</td>
        </tr>
        <tr>
            <th>優先度：</th>
            <td class="value">
                <img src="${priorityImagePath}" alt="優先度画像" class="priority-image">
            </td>
        </tr>
        <tr>
            <th>推し：</th>
            <td class="value">${osi}</td>
        </tr>
        <tr>
            <th>メモ：</th>
            <td class="value">${memo}</td>
        </tr>
    `;

    // hiddenフィールドにgoods_idを設定
    document.querySelector('.del_goods input[name="goods_id"]').value = osikatu_id;

    // 削除モーダルを表示
    deleteModal.style.display = 'block';
}

// 削除ボタンを押したときにフォームを送信
document.getElementById('mDelete').addEventListener('click', function () {
    const deleteForm = document.querySelector('.del_goods');
    const goodsId = deleteForm.querySelector('input[name="goods_id"]').value;

    if (!goodsId) {
        alert('削除対象が見つかりません。');
        return;
    }

    // フォーム送信
    deleteForm.submit();
});


// 閉じるボタンにイベントリスナーを設定
document.getElementById("mClose").addEventListener("click", closeModal);



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

function closeDeleteModal() {
    // 削除モーダルを非表示
    const deleteModal = document.getElementById('deleteModal');
    deleteModal.style.display = 'none';
}