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
        fileLabel.textContent = "　fileName";
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
    const cate_id = document.getElementById("categorySelect");
    document.querySelector("#tagAdd .cate_id").value = cate_id.value;
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
    const relatedProject = document.getElementById("categorySelect"); // カテゴリー選択
    const selectElements = document.querySelectorAll('select[name^="tab"]'); // 曲/チーム/組名セレクト

    // カテゴリー変更時の処理
    relatedProject.addEventListener("change", () => {
        if (relatedProject.value !== "1") {
            // セレクトボックスとボタンを有効化
            selectElements.forEach((selectElement) => {
                selectElement.disabled = false;
            });

            const plusButtons = document.querySelectorAll(".plus3");
            plusButtons.forEach((button) => {
                button.disabled = false;
            });

            // 対応するタグデータを取得
            fetchTagsByCategory(relatedProject.value);
        }
    });
});



// モーダルを非表示にする関数
// function closeModal(modalId) {
//     document.getElementById(modalId).style.display = "none";
// }



// タグセレクトボックスを更新する関数
function fetchTagsByCategory(cateId) {
    fetch(`TagByCategoryServlet?cate_id=${cateId}`)
        .then(response => response.json())
        .then(data => {
            if (data.length === 0) {
                updateTagDropdownWithNoData(); // データがない場合
            } else {
                updateTagDropdown(data); // データ更新
            }
        })
        .catch(error => console.error("Error:", error));
}

// タグセレクトボックスを更新する
function updateTagDropdown(tags) {
    for (let i = 1; i <= 5; i++) {
        const tagSelect = document.getElementsByName(`tab${i}`)[0];
        tagSelect.innerHTML = "";

        // デフォルトオプション
        const defaultOption = document.createElement("option");
        defaultOption.value = "1";
        defaultOption.textContent = "曲/チーム/組名等を選択してください。";
        defaultOption.selected = true;
        tagSelect.appendChild(defaultOption);

        // タグオプションを追加
        tags.forEach(tag => {
            const option = document.createElement("option");
            option.value = tag.key; // サーバー側の値
            option.textContent = tag.value; // 表示名
            tagSelect.appendChild(option);
        });

        tagSelect.disabled = false; // 有効化
    }
}

// タグセレクトボックスを「未登録」と表示する
function updateTagDropdownWithNoData() {
    for (let i = 1; i <= 5; i++) {
        const tagSelect = document.getElementsByName(`tab${i}`)[0];
        tagSelect.innerHTML = "";

        // 「未登録」オプション
        const defaultOption = document.createElement("option");
        defaultOption.value = "1";
        defaultOption.textContent = "未登録";
        defaultOption.disabled = true;
        defaultOption.selected = true;
        tagSelect.appendChild(defaultOption);

        tagSelect.disabled = true; // 無効化
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
const modalGoods = document.getElementById('fave_edit_modal');
const buttonConfirmAdd = document.getElementById('fed');
const buttonCancelAdd = document.getElementById('fed_can');
const errorMessageDiv = document.querySelector('.error-message'); // エラーメッセージを表示するdiv

// モーダルの表示/非表示
document.getElementById('fed_open').addEventListener('click', function () {
    const name = document.querySelector('input[name="name"]').value.trim();
    if(name){
        modalGoods.style.display = 'block';
    }else{
        errorMessageDiv.style.display = 'block';
        errorMessageDiv.textContent = "名前を入力してください";
    }
});

buttonCancelAdd.addEventListener('click', () => modalGoods.style.display = 'none');


buttonConfirmAdd.addEventListener('click', () => {
    document.getElementById('fedit_form').submit();
});

window.addEventListener('click', (e) => {
    if (e.target == modalGoods) modalGoods.style.display = 'none';
});



// モーダルを表示する関数
// function showModal(modalId) {
//     document.getElementById(modalId).style.display = "block";
// }

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

// キャンセルボタンでモーダルを非表示
document.getElementById('fed_can').addEventListener('click', function () {
    document.getElementById('fave_edit_modal').style.display = 'none';
});

document.getElementById('fed_open').addEventListener('click', function () {
    // フォームから値を取得
    const name = document.querySelector('input[name="name"]').value.trim();
    const birthday = document.querySelector('input[name="birthday"]').value.trim();
    const memo = document.querySelector('textarea[name="memo"]').value.trim();

    const cateSelect = document.querySelector('select[name="cate_id"]');
    const category = cateSelect.options[cateSelect.selectedIndex].text;

    const tabs = [];
    for (let i = 1; i <= 5; i++) {
        const tabSelect = document.querySelector(`select[name="tab${i}"]`);
        if (tabSelect && !tabSelect.disabled) {
            const tabValue = tabSelect.options[tabSelect.selectedIndex].text;
            if (tabValue !== "曲/チーム/組名等を選択してください。") {
                tabs.push(tabValue);
            }
        }
    }

    // 画像の取得
    const fileInput = document.getElementById('fileInput'); // input[type="file"]
    const currentImageElement = document.querySelector('.current-image img'); // 現在表示中の画像
    const currentImageURL = currentImageElement ? currentImageElement.src : ""; // 表示されている画像のURL
    const currentImageAlt = currentImageElement ? currentImageElement.alt : ""; // 表示されている画像のalt（ファイル名）

    let fileName = currentImageAlt; // 初期値として既存画像のファイル名を使用
    let fileURL = currentImageURL; // 初期値として既存画像のURLを使用

    if (fileInput.files[0]) {
        // ファイルが選択されている場合、inputから取得
        fileName = fileInput.files[0].name;
        fileURL = URL.createObjectURL(fileInput.files[0]);
    }

    // モーダルの要素に値を設定
    document.querySelector('.modal-content0 .t_le td:nth-child(2)').textContent = name || "未入力";
    document.querySelector('.modal-content0 .t_le tr:nth-child(2) td:nth-child(2)').textContent = formatDate(birthday) || "不明";

    // 日付をスラッシュ区切りにフォーマットする関数
    function formatDate(dateString) {
        if (!dateString) return '';

        const date = new Date(dateString); // 文字列から Date オブジェクトに変換

        if (isNaN(date)) return ''; // 無効な日付の場合は空文字列を返す

        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0'); // 月は 0 から始まるため +1
        const day = String(date.getDate()).padStart(2, '0'); // 日付を 2 桁に

        return `${year}/${month}/${day}`; // スラッシュ区切りにして返す
    }

    // 画像
    const imageContainer = document.querySelector('.modal-content0 .t_le tr:nth-child(3) td');
    imageContainer.innerHTML = fileURL
        ? `<div class="mo-img"><img src="${fileURL}" alt="${fileName}"></div><p>${fileName}</p>`
        : `<div class='mo-img'><img src="static/faveImg/default.png" alt="デフォルト画像"></div><p>デフォルト画像</p>`;

    // メモ
    document.querySelector('.memodiv td').textContent = memo || "　";

    // 所属/関連プロジェクト
    document.querySelector('.t_ri tr:nth-child(1) td').textContent =
        (category && category !== "所属/関連プロジェクトを選択してください。") ? category : "──";

    // 曲/チーム/組名等
    const tabCells = document.querySelectorAll('.t_ri tr:nth-child(n+2) td');
    tabCells.forEach((cell, index) => {
        cell.textContent = tabs[index] || "──";
    });

    // 残りのセルをリセット
    for (let i = tabs.length; i < tabCells.length; i++) {
        tabCells[i].textContent = "──";
    }

    // モーダルを表示
    // document.getElementById('fave_add_modal').style.display = 'block';
});

document.getElementById('fed_open').addEventListener('click', function () {
    // 画像の取得
    const fileInput = document.getElementById('fileInput'); // input[type="file"]
    const currentImageUrl = document.getElementById('currentImageUrl').value; // 隠しフィールドからURLを取得
    const currentImageName = document.getElementById('currentImageName').value; // 隠しフィールドから名前を取得

    let fileName = currentImageName; // 初期値として既存画像のファイル名を設定
    let fileURL = currentImageUrl; // 初期値として既存画像のURLを設定

    if (fileInput.files[0]) {
        // 画像が選択されている場合は、inputから取得
        fileName = fileInput.files[0].name;
        fileURL = URL.createObjectURL(fileInput.files[0]);
    }

    // モーダルの画像部分を更新
    const imageContainer = document.querySelector('.modal-content0 .t_le tr:nth-child(3) td');
    imageContainer.innerHTML = fileURL
        ? `<div class="mo-img"><img src="${fileURL}" alt="${fileName}"></div><p>${fileName}</p>`
        : `<div class='mo-img'><img src="static/faveImg/default.png" alt="デフォルト画像"></div><p>デフォルト画像</p>`;
});


// キャンセルボタンでモーダルを非表示
document.getElementById('fed_can').addEventListener('click', function () {
    document.getElementById('fave_edit_modal').style.display = 'none';
});


// ボタンとモーダルの取得
const buttonOpen = document.getElementById('fe_dele');
const modal = document.getElementById('favedeleModal');
const buttonCancel = document.getElementById('fe_can_Delete');
const buttonConfirmDelete = document.getElementById('fe_Delete');

// モーダルを開くイベントリスナー
buttonOpen.addEventListener('click', (e) => {
    e.preventDefault(); // デフォルト動作を防止（必要に応じて追加）
    modal.style.display = 'block';

    const name = document.querySelector('input[name="name"]').value.trim();
    document.querySelector('.modal-content4 .modal-header4 .f_name_modal span').textContent = name || "未入力";
});

// モーダルを閉じるイベントリスナー
buttonCancel.addEventListener('click', (e) => {
    e.preventDefault(); // デフォルト動作を防止
    modal.style.display = 'none';
});

// 削除確定イベントリスナー
// buttonConfirmDelete.addEventListener('click', (e) => {
//     e.preventDefault(); // デフォルト動作を防止
//     modal.style.display = 'none';
//     console.log('削除確定処理を実行'); // ここに削除処理を追加
//
//     //ここでformを送れば行けると思われ
//     document.getElementById("fave_delete").submit();
// });

// モーダル外をクリックしたときにモーダルを閉じる
document.addEventListener('click', (e) => {
    if (e.target === modal) {
        modal.style.display = 'none';
    }
});
