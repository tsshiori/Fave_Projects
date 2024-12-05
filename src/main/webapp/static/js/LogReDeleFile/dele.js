// ボタンとモーダルの要素を取得
const buttonOpen = document.getElementById('modalOpen'); // モーダルを開くボタン
const modal = document.getElementById('easyModal'); // モーダル自体
const buttonCancel = document.getElementById('cancelDelete'); // モーダル内のキャンセルボタン
const buttonConfirmDelete = document.getElementById('confirmDelete'); // モーダル内の削除確定ボタン

// モーダルを開くイベントリスナーを追加
buttonOpen.addEventListener('click', modalOpen);
function modalOpen() {
    modal.style.display = 'block'; // モーダルを表示する
}

// モーダルを閉じるイベントリスナーを追加（キャンセルボタン）
buttonCancel.addEventListener('click', modalClose);
function modalClose() {
    modal.style.display = 'none'; // モーダルを非表示にする
}

// 削除ボタンが押されたら、フォームを送信して削除処理を実行
buttonConfirmDelete.addEventListener('click', function() {
    const password = document.getElementById('password').value;
    console.log(password); // パスワードの確認
    if (password.trim() !== "") {
        document.getElementById('deleteForm').submit();
    } else {
        alert("パスワードを入力してください");
    }
});


// キャンセルボタンがクリックされた場合の処理（マイページに遷移）
document.getElementById('cancelDeletePage').addEventListener('click', function() {
    window.location.href = 'dele'; // マイページへの遷移
});

// モーダルの外側をクリックした場合、モーダルを閉じる処理
document.addEventListener('click', function(e) {
    if (e.target === modal) {
        modalClose(); // モーダル外をクリックしたらモーダルを閉じる
    }
});
