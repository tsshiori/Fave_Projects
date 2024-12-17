// モーダル要素の取得
const bulkAddModal = document.getElementById('easyModal');
const confirmAddModal = document.getElementById('easyModal3'); // easyModal3を取得

// ボタン要素の取得
const bulkAddButton = document.getElementById('modalOpen'); // 「一括追加」ボタン

// モーダルを開く関数
function openModal(modal) {
    modal.style.display = 'block';
}

// モーダルを閉じる関数
function closeModal(modal) {
    modal.style.display = 'none';
}

// 「一括追加」ボタンをクリックした時の処理
bulkAddButton.addEventListener('click', function() {
    openModal(bulkAddModal);
});

// 「登録」ボタンがクリックされたら「一括追加」モーダルを閉じ、確認モーダル（easyModal3）を開く
document.getElementById('confirmDelete').addEventListener('click', function() {
    closeModal(bulkAddModal);  // 現在のモーダルを閉じる
    openModal(confirmAddModal); // 確認モーダル（easyModal3）を開く
});

// 「キャンセル」ボタンがクリックされたら「一括追加」モーダルを閉じる
document.getElementById('cancelDelete').addEventListener('click', function() {
    closeModal(bulkAddModal);
});

// easyModal3の「キャンセル」ボタンがクリックされたらモーダルを閉じる
document.getElementById('cancelDelete3').addEventListener('click', function() {
    closeModal(confirmAddModal);
});

document.querySelectorAll('.deleteButton').forEach(button => {
    button.addEventListener('click', function() {
        const shiftId = this.dataset.shiftId;
        const modal = document.getElementById(`easyModal_${shiftId}`);

        // モーダルを表示
        modal.style.display = 'block';
    });
});

document.querySelectorAll('.cancelDeleteButton').forEach(button => {
    button.addEventListener('click', function() {
        const shiftId = this.dataset.shiftId;
        const modal = document.getElementById(`easyModal_${shiftId}`);

        // モーダルを非表示にする
        modal.style.display = 'none';
    });
});

