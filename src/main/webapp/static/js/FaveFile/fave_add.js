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

const openTabButton = document.querySelector(".btn-plus .plus2");
const openConButton = document.querySelector(".btn-plus .plus3");
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

document.addEventListener('DOMContentLoaded', function() {
    // カテゴリ選択時にタグ選択肢を変更
    const categorySelect = document.getElementById('categorySelect');
    const tagSelect = document.getElementById('tagSelect');

    categorySelect.addEventListener('change', function() {
        const selectedCategoryId = categorySelect.value;

        // AJAXでカテゴリIDをサーブレットに送信
        const xhr = new XMLHttpRequest();
        xhr.open('GET', `GetTagsForCategory?categoryId=${selectedCategoryId}`, true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                // サーブレットから受け取ったタグデータを選択肢に反映
                const tags = JSON.parse(xhr.responseText);
                tagSelect.innerHTML = ''; // 現在の選択肢をクリア
                tags.forEach(function(tag) {
                    const option = document.createElement('option');
                    option.value = tag.id;
                    option.textContent = tag.name;
                    tagSelect.appendChild(option);
                });
            }
        };
        xhr.send();
    });
});
