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

// 削除確定イベントリスナー
buttonConfirmDelete.addEventListener('click', confirmDelete);
function confirmDelete() {
    // ページ遷移する
    window.location.href = '../login/login.html';
}

// キャンセルボタンをクリックしたらマイページに遷移する処理
document.getElementById('cancelDeletePage').addEventListener('click', function() {
    window.location.href = 'http://127.0.0.1:5500/Time%20of%20Fave/Time of Fave/MypageFile/mypage/mypage.html';
});

// モーダル外をクリックしたときにモーダルを閉じる
document.addEventListener('click', function(e) {
    if (e.target === modal) {
        modalClose();
    }
});