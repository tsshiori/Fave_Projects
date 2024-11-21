const buttonOpen = document.getElementById('modalOpen');
const modal = document.getElementById('easyModal');
const buttonCancel = document.getElementById('cancelRe');
const buttonConfirmRe = document.getElementById('confirmRe'); // 修正箇所

// モーダルを開く
buttonOpen.addEventListener('click', modalOpen);
function modalOpen() {
    modal.style.display = 'block';
}

// モーダルを閉じる（キャンセルボタン）
buttonCancel.addEventListener('click', modalClose);
function modalClose() {
    modal.style.display = 'none';
}

// モーダルの「登録」ボタンを押したときの処理
buttonConfirmRe.addEventListener('click', confirmRe); // 修正箇所
function confirmRe() {
    window.location.href = '../login/login.html';
}

// モーダルの外をクリックして閉じる
window.addEventListener('click', outsideClose);
function outsideClose(e) {
    if (e.target == modal) {
        modalClose();
    }
}