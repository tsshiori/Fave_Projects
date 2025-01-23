const open = document.getElementsByClassName('goods_detail_open');
const modal = document.getElementsByClassName('detail')[0];
const close = document.getElementsByClassName('close')[0];

// グッズ詳細モーダルを開く
for (let i = 0; i < open.length; i++) {
    open[i].onclick = function(event) {
        event.preventDefault(); // デフォルトのリンク動作を防ぐ

        // 現在クリックされたリンク要素を取得
        const link = this;

        // 選択されたリンクのdata-*属性から情報を取得
        const id = link.dataset.prioriti;
        const date = link.dataset.day || "未設定";
        const item = link.dataset.item || "未設定";
        const price = link.dataset.price || "0";
        const fave = link.dataset.name || "未設定";
        const memo = link.dataset.memo || "なし";
        const type = link.dataset.type || "0";

        // モーダル内に情報を挿入
        const image = document.querySelector(".mohe .yusendo");
        image.innerHTML = `<img src="static/img/Y_${id}.png" alt="優先度${id}">`;

        document.querySelector(".mohe .goodsdetail .tate .day").textContent = formatDate(date);
        document.querySelector(".mohe .goodsdetail .tate .item").textContent = item;

        const formattedPrice = `￥${Number(price).toLocaleString()}`;
        document.querySelector(".mohe .goodsdetail .tate .price").textContent = formattedPrice;
        document.querySelector(".mohe .goodsdetail .tate .name").textContent = fave;
        document.querySelector(".modal-header .memo").textContent = memo;

        if(type === "0"){
            document.querySelector(".mohe .goodsdetail .tate .type").textContent = "グッズ名：";
        }else{
            document.querySelector(".mohe .goodsdetail .tate .type").textContent = "イベント名：";
        }

            function formatDate(dateString) {
                if (!dateString) return '';

                const date = new Date(dateString); // 文字列から Date オブジェクトに変換

                if (isNaN(date)) return ''; // 無効な日付の場合は空文字列を返す

                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0'); // 月は 0 から始まるため +1
                const day = String(date.getDate()).padStart(2, '0'); // 日付を 2 桁に

                return `${year}/${month}/${day}`; // スラッシュ区切りにして返す
            }

        // モーダルを表示
        modal.style.display = "block";

    };
}

// モーダルを閉じる
close.onclick = function() {
    modal.style.display = "none";
};

// モーダルの外側をクリックした場合に閉じる
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
};

// 現在のページURLを保存して次のページで使う
document.getElementById('plus-link').addEventListener('click', function(event) {
    const currentUrl = window.location.href;
    localStorage.setItem('previousPage', currentUrl);
});

const delopen = document.getElementById("del_in_open");
const delemodal = document.getElementById("delete_index_goods");
const dele = document.getElementById("goods_Delete");
