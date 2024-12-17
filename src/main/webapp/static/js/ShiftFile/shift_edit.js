const buttonOpen = document.getElementById('modalOpen');
const buttonOpenzikyu = document.getElementById('modalOpenzikyu');
const modal = document.getElementById('easyModal');
const modal2 = document.getElementById('easyModal2');
const buttonCancel = document.getElementById('cancelRe');
const buttonCancel2 = document.getElementById('cancelRe2'); // 修正
const buttonConfirmRe = document.getElementById('confirmRe');
const buttonConfirmRe2 = document.getElementById('confirmRe2'); // 修正

// モーダルを開く（登録）
buttonOpen.addEventListener('click', modalOpen);
function modalOpen() {
    modal.style.display = 'block';
}

// モーダルを開く（時給変更）
buttonOpenzikyu.addEventListener('click', modalOpenzikyu);
function modalOpenzikyu() {
    modal2.style.display = 'block'; // モーダル2を開く
}

// モーダルを閉じる（キャンセルボタン）
buttonCancel.addEventListener('click', modalClose);
buttonCancel2.addEventListener('click', modalClose); // 修正
function modalClose() {
    modal.style.display = 'none'; // モーダル1を閉じる
    modal2.style.display = 'none'; // モーダル2を閉じる
}

// モーダルの「登録」ボタンを押したときの処理
buttonConfirmRe.addEventListener('click', confirmRe);
document.getElementById('confirmRe').addEventListener('click', function () {
    document.getElementById('shift_edit_form').submit();
});

buttonConfirmRe2.addEventListener('click', confirmRe2); // 修正
function confirmRe2() {
    window.location.href = 'shift_edit'; // 遷移先
}


// モーダルの外をクリックして閉じる
window.addEventListener('click', outsideClose);
function outsideClose(e) {
    if (e.target === modal) {
        modalClose();
    } else if (e.target === modal2) {
        modalClose(); // モーダル2を閉じる
    }
}

// プレースホルダーを非表示にする関数
function hidePlaceholder(input) {
    const placeholder = input.nextElementSibling;
    if (placeholder) placeholder.style.display = 'none';
}

// プレースホルダーを表示する関数
function showPlaceholder(input) {
    if (!input.value) {
        const placeholder = input.nextElementSibling;
        if (placeholder) placeholder.style.display = 'block';
    }
}

// 初期状態でプレースホルダーを表示
window.onload = () => {
    const inputs = document.querySelectorAll('.pl-input');
    inputs.forEach(input => {
        const placeholder = input.nextElementSibling;
        if (!input.value) {
            placeholder.style.display = 'block';
        }
    });
};



function hidePlaceholder(input) {
    const placeholder = input.nextElementSibling;
    if (placeholder) placeholder.style.display = 'none';
}

function showPlaceholder(input) {
    if (!input.value) {
        const placeholder = input.nextElementSibling;
        if (placeholder) placeholder.style.display = 'block';
    }
}




document.addEventListener('DOMContentLoaded', () => {
    // すべてのカスタムプレースホルダーを処理
    document.querySelectorAll('.input-container').forEach(container => {
        const input = container.querySelector('.pl-input');
        const placeholder = container.querySelector('.pl-placeholder');

        // プレースホルダーをクリックすると、inputにフォーカスして開く
        placeholder.addEventListener('click', () => {
            input.focus();  // inputにフォーカス
            input.click();  // 日付ピッカーを開くためにクリックを追加
        });
    });
});