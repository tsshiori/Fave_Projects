// モーダル関連の要素取得
const modalTab = document.getElementById("money_de");
const openButton = document.querySelector("#detail_button");
const closeButton = document.getElementById("mo_de_close");

// モーダルを開く処理
openButton.addEventListener("click", () => {
    modalTab.style.display = "block";
});

// モーダルを閉じる処理
closeButton.addEventListener("click", () => {
    modalTab.style.display = "none";
});

// 背景クリックで閉じる処理
window.addEventListener("click", (event) => {
    if (event.target === modalTab) {
        modalTab.style.display = "none";
    }
});
