const open = document.getElementsByClassName('goods_detail_open');
const modal = document.getElementsByClassName('detail')[0];
const close = document.getElementsByClassName('close')[0];
const delopen = document.getElementById("del_in_open");
const delemodal = document.getElementById("delete_index_goods");
const delecan = document.getElementById("goods_del_can");

let id = null;
let date = null;
let item = null;
let price = null;
let fave = null;
let memo = null;
let type = null;
let iid =null

// 日付フォーマット関数
function formatDate(dateString) {
    if (!dateString) return '';
    const date = new Date(dateString);
    if (isNaN(date)) return '';
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}/${month}/${day}`;
}

// グッズ詳細モーダルを開く
for (let i = 0; i < open.length; i++) {
    open[i].onclick = function(event) {
        event.preventDefault();
        const link = this;

        id = link.dataset.prioriti;
        date = link.dataset.day || "未設定";
        item = link.dataset.item || "未設定";
        price = link.dataset.price || "0";
        fave = link.dataset.name || "未設定";
        memo = link.dataset.memo || "なし";
        type = link.dataset.type || "0";
        iid= link.dataset.id;

        const image = document.querySelector(".mohe .yusendo");
        image.innerHTML = `<img src="static/img/Y_${id}.png" alt="優先度${id}">`;

        document.querySelector(".mohe .goodsdetail .tate .day").textContent = formatDate(date);
        document.querySelector(".mohe .goodsdetail .tate .item").textContent = item;
        document.querySelector(".mohe .goodsdetail .tate .price").textContent = `￥${Number(price).toLocaleString()}`;
        document.querySelector(".mohe .goodsdetail .tate .name").textContent = fave;
        document.querySelector(".modal-header .memo").textContent = memo;
        document.querySelector(".mohe .goodsdetail .tate .type").textContent = type === "0" ? "グッズ名：" : "イベント名：";
        const edit = document.querySelector(".modal-body .edde");
        edit.innerHTML = `<a class="edit" href="goods_edit?osikatu_id=${iid}" >
                    <img src="static/img/EDIT2.png" alt="edit2">
                </a>
                <button type="button" class="delete" id="del_in_open"><img src="static/img/DELE2.png" alt="dele2"></button>
       `;

        modal.style.display = "block";
    };
}

// モーダルを閉じる
close.onclick = function() {
    modal.style.display = "none";
};

// 削除モーダルを開く
document.addEventListener('click', function(event) {
    if (event.target.closest('#del_in_open')) { // クリックされた要素が del_in_open の場合
        const image = document.querySelector("#delete_index_goods .delete-details .priority");
        image.innerHTML = `<img src="static/img/Y_${id}.png" alt="優先度${id}">`;

        document.querySelector("#delete_index_goods .delete-details .day").textContent = formatDate(date);
        document.querySelector("#delete_index_goods .delete-details .item").textContent = item;
        document.querySelector("#delete_index_goods .delete-details .price").textContent = `￥${Number(price).toLocaleString()}`;
        document.querySelector("#delete_index_goods .delete-details .name").textContent = fave;
        document.querySelector("#delete_index_goods .delete-details .memo").textContent = memo;
        document.querySelector("#delete_index_goods .delete-details .type").textContent = type === "0" ? "グッズ名：" : "イベント名：";
        document.querySelector("input[name='goods_id']").value = iid;

        modal.style.display = "none";
        delemodal.style.display = "block";
    }
});


// 削除モーダルを閉じる
delecan.onclick = function() {
    delemodal.style.display = "none";
    modal.style.display = "block";
};

// モーダル外をクリックして閉じる
window.onclick = function(event) {
    if (event.target === modal) {
        modal.style.display = "none";
    } else if (event.target === delemodal) {
        delemodal.style.display = "none";
    }
};


