document.addEventListener("DOMContentLoaded", () => {
    // フォームの表示切替
    const checkbox = document.getElementById('switch');
    const title = document.querySelector('.title');
    const goodsForm = document.getElementById('goods');
    const eventsForm = document.getElementById('events');

    checkbox.addEventListener('click', () => {
        if (checkbox.checked) {
            title.textContent = 'イベント';
            goodsForm.style.display = 'none';
            eventsForm.style.display = 'block';
        } else {
            title.textContent = 'グッズ';
            goodsForm.style.display = 'block';
            eventsForm.style.display = 'none';
        }
    });

    // 初期状態でイベントフォームを非表示
    eventsForm.style.display = 'none';

    // モーダルに関連する要素
    const modalGoods = document.getElementById('easyModalGoods');
    const easyModalEvents = document.getElementById('easyModalEvents'); // 変数名を変更
    const buttonCancelGoods = document.getElementById('cancelReGoods');
    const buttonConfirmGoods = document.getElementById('confirmReGoods');
    const buttonCancelEvents = document.getElementById('cancelReEvents');
    const buttonConfirmEvents = document.getElementById('confirmReEvents');

    // モーダルの表示/非表示
    document.getElementById('modalOpenGoods').addEventListener('click', () => {
        modalGoods.style.display = 'block';
    });
    document.getElementById('modalOpenEvents').addEventListener('click', () => {
        easyModalEvents.style.display = 'block'; // 変数名を変更
    });
    buttonCancelGoods.addEventListener('click', () => modalGoods.style.display = 'none');
    buttonCancelEvents.addEventListener('click', () => easyModalEvents.style.display = 'none'); // 変数名を変更

    buttonConfirmGoods.addEventListener('click', () => {
        window.location.href = '../../index/index.html';
    });
    buttonConfirmEvents.addEventListener('click', () => {
        window.location.href = '../../index/index.html';
    });

    window.addEventListener('click', (e) => {
        if (e.target == modalGoods) modalGoods.style.display = 'none';
        if (e.target == easyModalEvents) easyModalEvents.style.display = 'none'; // 変数名を変更
    });



// モーダルを表示する関数
    function showModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

// モーダルを非表示にする関数
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }

// ボタンのクリックイベントリスナーを追加
    document.getElementById("plusButtonEvents").addEventListener("click", function() {
        showModal("modalEvents"); // イベントモーダルを表示
    });

    document.getElementById("plusButtonGoods").addEventListener("click", function() {
        showModal("modal"); // 一般モーダルを表示
    });

// 閉じるボタンにイベントリスナーを追加
    document.getElementById("closeModal").addEventListener("click", function() {
        closeModal("modal");
    });

    document.getElementById("closeModalEvents").addEventListener("click", function() {
        closeModal("modalEvents");
    });

// ウィンドウの外をクリックしたらモーダルを閉じる
    window.onclick = function(event) {
        if (event.target.className === "modal") {
            closeModal("modal");
            closeModal("modalEvents");
        }
    };


// モーダルの完了ボタンとキャンセルボタンの処理
    const addButtonGoods = document.getElementById("AddGoods");
    const cancelButtonGoods = document.getElementById("ReGoods");
    const addButtonEvents = document.getElementById("AddEvents");
    const cancelButtonEvents = document.getElementById("ReEvents");

// 完了ボタンをクリックしたときの処理 (グッズ)
    addButtonGoods.addEventListener("click", () => {
        const inputName = document.querySelector("#plusForm input[name='modalosi']").value;
        console.log("追加する推しの名前:", inputName);
        closeModal("modal");
    });

// キャンセルボタンをクリックしたときの処理 (グッズ)
    cancelButtonGoods.addEventListener("click", () => {
        closeModal("modal");
    });

// 完了ボタンをクリックしたときの処理 (イベント)
    addButtonEvents.addEventListener("click", () => {
        const inputName = document.querySelector("#plusFormEvents input[name='modalosi']").value;
        console.log("追加する推しの名前:", inputName);
        closeModal("modalEvents");
    });

// キャンセルボタンをクリックしたときの処理 (イベント)
    cancelButtonEvents.addEventListener("click", () => {
        closeModal("modalEvents");
    });
    window.addEventListener("click", function(event) {
        const modals = document.querySelectorAll(".modalbody");
        modals.forEach(modal => {
            if (event.target === modal) {
                closeModal(modal.id);
            }
        });
    });
});


function hidePlaceholder(input) {
    const placeholder = input.nextElementSibling;
    if (placeholder) placeholder.style.display = 'none';
}

function showPlaceholder(input) {
    const placeholder = input.nextElementSibling;
    if (!input.value && placeholder) {
        placeholder.style.display = 'block';
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const dateInputs = document.querySelectorAll('input[type="date"]');

    dateInputs.forEach(input => {
        const placeholder = input.nextElementSibling;

        // 初期表示の設定: inputが空ならプレースホルダーを表示
        if (!input.value) {
            placeholder.style.display = 'block';
        }

        // inputにフォーカスがあるときプレースホルダーを非表示
        input.addEventListener('focus', () => hidePlaceholder(input));

        // inputからフォーカスが外れたとき、入力がない場合にプレースホルダーを表示
        input.addEventListener('blur', () => showPlaceholder(input));

        // プレースホルダーをクリックするとinputにフォーカス
        placeholder.addEventListener('click', () => input.focus());
    });
});
