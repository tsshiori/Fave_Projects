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

document.getElementById('confirmRe').addEventListener('click', function () {
    // フォームを送信
    var form = document.getElementById('registerForm');
    form.submit();
});

// モーダルの外をクリックして閉じる
window.addEventListener('click', outsideClose);
function outsideClose(e) {
    if (e.target == modal) {
        modalClose();
    }
}

