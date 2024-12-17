// ボタンとモーダルの要素を取得
const buttonOpen = document.getElementById('modalOpen'); // モーダルを開くボタン
const modal = document.getElementById('easyModal'); // モーダル自体
const buttonCancel = document.getElementById('cancelDelete'); // モーダル内のキャンセルボタン
const buttonConfirmDelete = document.getElementById('confirmDelete'); // モーダル内の削除確定ボタン
const errorMessageDiv = document.querySelector('.error-message'); // エラーメッセージを表示するdiv

// モーダルを開くイベントリスナーを追加
buttonOpen.addEventListener('click', function() {
    const password = document.getElementById('password').value.trim();

    // パスワードが未入力の場合、エラーメッセージを表示
    if (password === "") {
        errorMessageDiv.style.display = 'block';
        errorMessageDiv.textContent = "パスワードを入力してください";
    } else {
        // パスワードが入力されている場合、モーダルを開く
        modal.style.display = 'block';
    }
});

// モーダルを閉じるイベントリスナーを追加（キャンセルボタン）
buttonCancel.addEventListener('click', modalClose);
function modalClose() {
    modal.style.display = 'none'; // モーダルを非表示にする
}

// 削除ボタンが押されたら、フォームを送信して削除処理を実行
buttonConfirmDelete.addEventListener('click', function() {
    const password = document.getElementById('password').value.trim();

    // パスワードが未入力の場合、エラーメッセージを表示
    if (password === "") {
        errorMessageDiv.style.display = 'block';
        errorMessageDiv.textContent = "パスワードを入力してください";
    } else {
        // エラーメッセージが表示されている場合は非表示にする
        errorMessageDiv.style.display = 'none';

        // フォームを送信
        document.getElementById('deleteForm').submit();
    }
});

// キャンセルボタンがクリックされた場合の処理（マイページに遷移）
document.getElementById('cancelDeletePage').addEventListener('click', function() {
    window.location.href = 'my_page'; // マイページへの遷移
});

// モーダルの外側をクリックした場合、モーダルを閉じる処理
document.addEventListener('click', function(e) {
    if (e.target === modal) {
        modalClose(); // モーダル外をクリックしたらモーダルを閉じる
    }
});
