document.getElementById('fileInput').addEventListener('change', function() {
    const fileInput = document.getElementById('fileInput');
    const preview = document.getElementById('preview');

    if (fileInput.files && fileInput.files[0]) {
        // 選択されたファイルのオブジェクトURLを作成
        preview.src = URL.createObjectURL(fileInput.files[0]);

        // オブジェクトURLのメモリ解放のためのイベントリスナー
        preview.onload = function() {
            URL.revokeObjectURL(preview.src);
        };
    }
});

function updateFileName() {
    const fileInput = document.getElementById('fileInput');
    const fileLabel = document.getElementById('fileLabel');
    const maxWidth = 175; // 表示幅（px）を調整

    if (fileInput.files.length > 0) {
        let fileName = fileInput.files[0].name;

        // ダミー要素を使って文字列の描画幅を計算
        const canvas = document.createElement('canvas');
        const context = canvas.getContext('2d');
        context.font = getComputedStyle(fileLabel).font; // ラベルと同じフォント設定を適用

        let textWidth = context.measureText(fileName).width;

        while (textWidth > maxWidth && fileName.length > 1) {
            fileName = fileName.slice(0, -2) + '…'; // 長すぎる場合は末尾を省略
            textWidth = context.measureText(fileName).width;
        }

        fileLabel.textContent = fileName;
    } else {
        fileLabel.textContent = "　画像のアップロード";
    }
}


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



// モーダル関連の要素取得
const modalTab = document.getElementById("addtab");
const modalCon = document.getElementById("addcon");

const openConButton = document.querySelector(".btn-plus .plus2");
const openTabButton = document.querySelector(".btn-plus .plus3");
const closeButtons = document.querySelectorAll(".close");

// モーダルを開く処理
openTabButton.addEventListener("click", () => {
    modalTab.style.display = "block";
});

openConButton.addEventListener("click", () => {
    modalCon.style.display = "block";
});

// モーダルを閉じる処理
closeButtons.forEach((button) => {
    button.addEventListener("click", () => {
        modalTab.style.display = "none";
        modalCon.style.display = "none";
    });
});

// 背景クリックで閉じる処理
window.addEventListener("click", (event) => {
    if (event.target === modalTab) {
        modalTab.style.display = "none";
    } else if (event.target === modalCon) {
        modalCon.style.display = "none";
    }
});


document.addEventListener("DOMContentLoaded", () => {
    const relatedProject = document.getElementById("categorySelect"); // プロジェクト選択の <select>
    const selectElements = document.querySelectorAll('select[name^="tab"]'); // 'tab'で始まるname属性を持つselect要素を取得
    // relatedProject が変更されたときの処理
    relatedProject.addEventListener("change", () => {
        if (relatedProject.value !== "") {
            // すべての songTeam の <select> を有効化
            selectElements.forEach((selectElement) => {
                selectElement.disabled = false; // 無効化解除
            });

            // すべてのボタンを有効化
            const plusButtons = document.querySelectorAll(".plus3");
            plusButtons.forEach((button) => {
                button.disabled = false; // 無効化解除
            });
        }
    });
});


// モーダルを非表示にする関数
function closeModal(modalId) {
    document.getElementById(modalId).style.display = "none";
}

// ウィンドウの外をクリックしたらモーダルを閉じる
window.onclick = function(event) {
    if (event.target.className === "modal") {
        closeModal("modal");
        closeModal("modalEvents");
    }
};

// category.js

// カテゴリIDに基づいてタグを取得してセレクトボックスを更新
function fetchTagsByCategory(cateId) {
    fetch(`TagByCategoryServlet?cate_id=${cateId}`)
        .then(response => response.json())
        .then(data => {
            updateTagDropdown(data);
        })
        .catch(error => console.error("Error:", error));
}

// タグセレクトボックスを更新する
// カテゴリIDに基づいてタグを取得してセレクトボックスを更新
function fetchTagsByCategory(cateId) {
    fetch(`TagByCategoryServlet?cate_id=${cateId}`)
        .then(response => response.json())
        .then(data => {
            if (data.length === 0) {
                // データが空の場合は「未登録」を表示
                updateTagDropdownWithNoData();
            } else {
                updateTagDropdown(data);
            }
        })
        .catch(error => console.error("Error:", error));
}

// タグセレクトボックスを更新する
function updateTagDropdown(tags) {
    for (let i = 1; i <= 5; i++) {
        const tagSelect = document.getElementsByName(`tab${i}`)[0];
        tagSelect.innerHTML = "";

        const defaultOption = document.createElement("option");
        defaultOption.value = "";
        defaultOption.textContent = "曲/チーム/組名等を選択してください。"; // デフォルトメッセージ
        defaultOption.disabled = true;
        defaultOption.selected = true;
        defaultOption.classList.add("default-option"); // クラスを追加
        tagSelect.appendChild(defaultOption);

        tags.forEach(tag => {
            const option = document.createElement("option");
            option.value = tag;
            option.textContent = tag;
            tagSelect.appendChild(option);
        });

        tagSelect.disabled = false;
    }
}

// タグセレクトボックスを「未登録」と表示する
function updateTagDropdownWithNoData() {
    for (let i = 1; i <= 5; i++) {
        const tagSelect = document.getElementsByName(`tab${i}`)[0];
        tagSelect.innerHTML = "";

        const defaultOption = document.createElement("option");
        defaultOption.value = "";
        defaultOption.textContent = "未登録"; // 「未登録」を表示
        defaultOption.disabled = true;
        defaultOption.selected = true;
        tagSelect.appendChild(defaultOption);

        tagSelect.disabled = true; // セレクトボックスを無効化
    }
}





// 選択済みの値を追跡するための配列
const selectedValues = new Set();

// セレクトボックスをすべて取得
const selectElements = document.querySelectorAll('.tab');

// セレクトボックスの値が変更されたときのイベントリスナー
selectElements.forEach((select) => {
    select.addEventListener('change', (event) => {
        // 変更前の値を削除
        const previousValue = select.dataset.previousValue;
        if (previousValue) {
            selectedValues.delete(previousValue);
        }

        // 新しい値を追加
        const newValue = event.target.value;
        if (newValue) {
            selectedValues.add(newValue);
        }

        // 選択済みの値を更新
        select.dataset.previousValue = newValue;

        // 他のセレクトボックスの選択肢を更新
        updateSelectOptions();
    });
});

// 他のセレクトボックスから選択済みの値を削除する関数
function updateSelectOptions() {
    selectElements.forEach((select) => {
        const currentValue = select.value;

        // 一度すべての選択肢を有効化
        const options = Array.from(select.options);
        options.forEach((option) => {
            if (option.value !== currentValue && selectedValues.has(option.value)) {
                option.disabled = true; // 選択済みなら無効化
            } else {
                option.disabled = false; // 未選択なら有効化
            }
        });
    });
}


// モーダルに関連する要素
const modalGoods = document.getElementById('fave_add_modal');
const buttonConfirmAdd = document.getElementById('fadd');
const buttonCancelAdd = document.getElementById('fadd_can');

// モーダルの表示/非表示
document.getElementById('fadd_open').addEventListener('click', () => {
    modalGoods.style.display = 'block';
});
buttonCancelAdd.addEventListener('click', () => modalGoods.style.display = 'none');

buttonConfirmAdd.addEventListener('click', () => {
    document.getElementById('fadd_form').submit();
});

window.addEventListener('click', (e) => {
    if (e.target == modalGoods) modalGoods.style.display = 'none';
});



// モーダルを表示する関数
function showModal(modalId) {
    document.getElementById(modalId).style.display = "block";
}

// モーダルを非表示にする関数
function closeModal(modalId) {
    document.getElementById(modalId).style.display = "none";
}

// ウィンドウの外をクリックしたらモーダルを閉じる
window.onclick = function(event) {
    if (event.target.className === "modal") {
        closeModal("modal");
        closeModal("modalEvents");
    }
};
