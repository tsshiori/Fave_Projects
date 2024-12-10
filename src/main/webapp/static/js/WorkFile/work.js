document.addEventListener("DOMContentLoaded", function () {
    // 削除ボタンとモーダルの取得
    const deleteButtons = document.querySelectorAll(".deleteButton");
    const modal1 = document.getElementById("modal1");
    const modal2 = document.getElementById("modal2");
    const cancelButtons = document.querySelectorAll("#cancelDelete1, #cancelDelete2");

    // 削除ボタンをクリックしたときの処理
    deleteButtons.forEach(button => {
        button.addEventListener("click", function (event) {
            event.preventDefault();

            // ボタンの属性からデータを取得
            const isMainWork = this.getAttribute("data-mainwork") === "true";
            const workName = this.getAttribute("data-work-name");
            const hourlyWage = this.getAttribute("data-hourlywage");

            // モーダルに情報を表示
            if (isMainWork) {
                modal1.style.display = "block";
            } else {
                // モーダル2の内容を更新
                const meElements = modal2.querySelectorAll(".me");
                meElements[0].textContent = workName; // バイト先名
                meElements[1].textContent = `¥ ${hourlyWage}`; // 時給
                modal2.style.display = "block";
            }
        });
    });

    // キャンセルボタンをクリックしたときの処理
    cancelButtons.forEach(button => {
        button.addEventListener("click", function () {
            modal1.style.display = "none";
            modal2.style.display = "none";
        });
    });

    // モーダル外をクリックしたときの処理
    window.addEventListener("click", function (event) {
        if (event.target === modal1) {
            modal1.style.display = "none";
        }
        if (event.target === modal2) {
            modal2.style.display = "none";
        }
    });
});
