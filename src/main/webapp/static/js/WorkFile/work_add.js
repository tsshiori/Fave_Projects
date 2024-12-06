// ボタンとモーダルの取得
const buttonOpen = document.getElementById('modalOpen');
const modal = document.getElementById('easyModal');
const buttonCancel = document.getElementById('cancelDelete');
const buttonConfirmDelete = document.getElementById('confirmDelete');

// モーダルを開くイベントリスナー
buttonOpen.addEventListener('click', modalOpen);
function modalOpen() {
    modal.style.display = 'block';
}

// モーダルを閉じるイベントリスナー
buttonCancel.addEventListener('click', modalClose);
function modalClose() {
    modal.style.display = 'none';
}

// モーダル外をクリックしたときにモーダルを閉じる
document.addEventListener('click', function(e) {
    if (e.target === modal) {
        modalClose();
    }
});

// モーダル内の「追加」ボタンがクリックされたときの処理
buttonConfirmDelete.addEventListener('click', function () {
    document.getElementById('work_add_form').submit();
});
