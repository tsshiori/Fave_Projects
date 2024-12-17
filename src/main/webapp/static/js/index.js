const open = document.getElementsByClassName('goods_detail_open');
const modal = document.getElementsByClassName('detail')[0];
const close = document.getElementsByClassName('close')[0];

// グッズ詳細モーダルを開く
for (var i = 0; i < open.length; i++) {
    open[i].onclick = function(event) {
        event.preventDefault();  // デフォルトのリンク動作を防ぐ
        modal.style.display = "block";
    }
}

// モーダルを閉じる
close.onclick = function() {
    modal.style.display = "none";
}

// モーダルの外側をクリックした場合に閉じる
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

document.getElementById('plus-link').addEventListener('click', function(event) {
    // 現在のページのURLをlocalStorageに保存
    const currentUrl = window.location.href;
    localStorage.setItem('previousPage', currentUrl);

    // 通常のリンク遷移を許可する
});