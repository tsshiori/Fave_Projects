// document.addEventListener("DOMContentLoaded", () => {
//     // フォームの表示切り替え(トグル)
//     const checkbox = document.getElementById('switch');
//     const title = document.querySelector('.title');
//     const goodsForm = document.getElementById('goods');
//     const eventsForm = document.getElementById('events');
//
//     checkbox.addEventListener('click', () => {
//         if (checkbox.checked) {
//             title.textContent = 'イベント';
//             goodsForm.style.display = 'none';
//             eventsForm.style.display = 'block';
//         } else {
//             title.textContent = 'グッズ';
//             goodsForm.style.display = 'block';
//             eventsForm.style.display = 'none';
//         }
//     });
//
//     // 初期状態でイベントフォームを非表示
//     eventsForm.style.display = 'none';
//
//     // モーダル関連要素
//     const modalGoods = document.getElementById('easyModalGoods');
//     const modalEvents = document.getElementById('easyModalEvents');
//     const addGoodsButton = document.getElementById('AddGoods');
//     const cancelGoodsButton = document.getElementById('ReGoods');
//     const addEventsButton = document.getElementById('AddEvents');
//     const cancelEventsButton = document.getElementById('ReEvents');
//
//     // グッズモーダルの表示/非表示
//     document.getElementById('modalOpenGoods').addEventListener('click', () => {
//         modalGoods.style.display = 'block';
//     });
//     cancelGoodsButton.addEventListener('click', () => {
//         modalGoods.style.display = 'none'; // キャンセルボタンでグッズモーダルを非表示
//     });
//     addGoodsButton.addEventListener('click', () => {
//         const goodsName = document.getElementById('goodsInput').value;
//         console.log('追加するグッズ:', goodsName);
//         modalGoods.style.display = 'none';
//     });
//
//     // イベントモーダルの表示/非表示
//     document.getElementById('modalOpenEvents').addEventListener('click', () => {
//         modalEvents.style.display = 'block';
//     });
//     cancelEventsButton.addEventListener('click', () => {
//         modalEvents.style.display = 'none';
//     });
//     addEventsButton.addEventListener('click', () => {
//         const eventName = document.getElementById('eventsInput').value;
//         console.log('追加するイベント:', eventName);
//         modalEvents.style.display = 'none';
//     });
//
//     // ウィンドウ外クリックでモーダルを閉じる
//     window.addEventListener('click', (event) => {
//         // モーダルの外側がクリックされた場合に閉じる
//         if (event.target === modalGoods || event.target === modalEvents) {
//             modalGoods.style.display = 'none';
//             modalEvents.style.display = 'none';
//         }
//     });
// });


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
        window.location.href = '../goods/goods.html';
    });
    buttonConfirmEvents.addEventListener('click', () => {
        window.location.href = '../goods/goods.html';
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
        showModal("modalGoods"); // 一般モーダルを表示
    });

// 閉じるボタンにイベントリスナーを追加
    document.getElementById("closeModalGoodsv").addEventListener("click", function() {
        closeModal("modalGoods");
    });

    document.getElementById("closeModalEvents").addEventListener("click", function() {
        closeModal("modalEvents");
    });

// ウィンドウの外をクリックしたらモーダルを閉じる
    window.onclick = function(event) {
        if (event.target.className === "modal") {
            closeModal("modalGoods");
            closeModal("modalEvents");
        }
    };


document.querySelector('.back-button').addEventListener('click', function () {
    // 保存したURLを取得
    const previousPage = localStorage.getItem('previousPage');

    if (previousPage) {
        // 保存したURLに戻る
        window.location.href = previousPage;
    } else {
        alert('前のページが見つかりません');
    }
});

document.getElementById('confirmReGoods').addEventListener('click', function () {
    // フォームを取得
    const form = document.querySelector('.goods_add_form');

    if (form) {
        // フォーム送信
        form.submit();
    } else {
        console.error('フォームが見つかりません');
    }
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




// モーダルの完了ボタンとキャンセルボタンの処理(プラスボタン)
const addButtonGoods = document.getElementById("AddGoods");
const cancelButtonGoods = document.getElementById("ReGoods");
const addButtonEvents = document.getElementById("AddEvents");
const cancelButtonEvents = document.getElementById("ReEvents");

// 完了ボタンをクリックしたときの処理 (グッズ)
addButtonGoods.addEventListener("click", () => {
    const inputName = document.querySelector("#plusForm input[name='modalosi']").value;
    console.log("追加する推しの名前:", inputName);
    closeModal("modalGoods");
});

// キャンセルボタンをクリックしたときの処理 (グッズ)
cancelButtonGoods.addEventListener("click", () => {
    closeModal("modalGoods");
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






document.getElementById('confirmReEvents').addEventListener('click', function () {
    // フォームを取得
    const form = document.querySelector('.events_add_form'); // classのフォームを取得

    if (form) {
        // フォーム送信
        form.submit();
    } else {
        console.error('フォームが見つかりません');
    }
});


//日付
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.input-container').forEach(container => {
        const input = container.querySelector('.pl');  // input要素
        const placeholder = container.querySelector('.date-text');  // プレースホルダー

        // 初期状態でプレースホルダーに「日付を入力してください。」を表示
        placeholder.style.display = 'block';  // 初期状態では表示
        input.style.color = "#A9A8C2";  // 初期色（薄い色）

        // フォーカス時に「年/月/日」のプレースホルダーに変更
        input.addEventListener('focus', () => {
            placeholder.style.display = 'none';  // プレースホルダーを非表示
            input.style.color = "#221D7E";  // フォーカス時に色を濃く
        });

        // フォーカスが外れたとき（blur）にプレースホルダーを再表示
        input.addEventListener('blur', () => {
            if (!input.value) {
                placeholder.style.display = 'block';  // 入力がなければプレースホルダーを表示
                input.style.color = "#A9A8C2";  // 色を元に戻す
            }
        });

        // プレースホルダーをクリックしたら入力にフォーカス
        placeholder.addEventListener('click', () => {
            input.focus();  // プレースホルダーをクリックで入力フィールドにフォーカス
        });
    });
});


