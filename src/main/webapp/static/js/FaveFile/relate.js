// アコーディオンのボタンをすべて取得
const accordionButtons = document.querySelectorAll('.accordion-button');

// 各ボタンにクリックイベントを設定
accordionButtons.forEach(button => {
    button.addEventListener('click', function() {
        const content = this.closest('.accordion-item').querySelector('.accordion-content');
        const downImage = this.querySelector('.DOWN');

        document.querySelectorAll('.accordion-content').forEach(item => {
            if (item !== content) {
                item.classList.remove('show');
                const otherDownImage = item.closest('.accordion-item').querySelector('.DOWN');
                if (otherDownImage) {
                    otherDownImage.src = 'static/img/DOWN.png';
                }
            }
        });

        content.classList.toggle('show');

        if (content.classList.contains('show')) {
            downImage.src = 'static/img/DOWN2.png';
        } else {
            downImage.src = 'static/img/DOWN.png';
        }
    });
});

// '閉じる'ボタンまたはテキストをクリックしたときにアコーディオンを閉じる処理
const closeElements = document.querySelectorAll('.close');

closeElements.forEach(closeElement => {
    closeElement.addEventListener('click', function() {
        const content = this.closest('.accordion-content');
        const parentAccordionItem = content.closest('.accordion-item');
        const downImage = parentAccordionItem.querySelector('.DOWN');

        content.classList.remove('show');
        downImage.src = "static/img/DOWN.png";
    });
});

// モーダル要素を取得
const editModal = document.getElementById("editModal");
const editModal2 = document.getElementById("editModal2");
const deleteModal = document.getElementById("deleteModal");
const deleteModal2 = document.getElementById("deleteModal2");
const addModal = document.getElementById("addModal");
const addModal2 = document.getElementById("addModal2");

// ボタン要素を取得
const editButtons = document.querySelectorAll(".EDIT");
const editButtons2 = document.querySelectorAll(".EDIT2");
const deleteButtons = document.querySelectorAll(".DELE");
const deleteButtons2 = document.querySelectorAll(".DELE2");
const addButtons = document.querySelectorAll(".ADD");
const addButtons2 = document.querySelectorAll(".ADD2");

// 閉じるボタンを取得
const closeButtons = document.querySelectorAll(".close");

// 編集ボタンのクリックイベント（カテゴリ編集）
document.querySelectorAll(".EDIT").forEach(button => {
    button.onclick = (event) => {
        // EDITボタンの親要素 (container) を取得
        const container = button.closest('.container');

        // container 内の accordion-button を取得
        const accordionButton = container.querySelector('.accordion-button');

        // accordion-button からデータ属性を取得
        const categoryId = accordionButton.getAttribute('data-cate-id');
        const categoryName = accordionButton.getAttribute('data-category');

        // デバッグログ
        console.log('クリックされた編集ボタン:', button);
        console.log('カテゴリID:', categoryId);
        console.log('カテゴリ名:', categoryName);

        // 編集モーダルを表示
        const editModal = document.getElementById("editModal");
        editModal.style.display = "block";

        // モーダル内の入力フィールドにカテゴリ名を設定
        const modalInput = editModal.querySelector('#editInput1');
        modalInput.value = categoryName || '未設定のカテゴリ名'; // デフォルト値を設定

        // 隠しフィールドにカテゴリIDを設定
        const hiddenInput = editModal.querySelector('#categoryIdInput');
        hiddenInput.value = categoryId;

        // 完了ボタンの処理
        document.getElementById("confirmEdit").onclick = () => {
            console.log('カテゴリID:', categoryId);
            console.log('編集後のカテゴリ名:', modalInput.value);

            // フォームを送信
            document.getElementById("cate_edit_form").submit();
        };
    };
});




// 編集ボタン 2のクリックイベント（タグ編集）
document.querySelectorAll(".EDIT2").forEach(button => {
    button.onclick = () => {
        // EDIT2 ボタンの親要素をたどって必要な情報を取得

        // 1. カテゴリ情報を取得
        const accordionItem = button.closest('.accordion-item'); // 親の accordion-item を取得
        const accordionButton = accordionItem.querySelector('.accordion-button'); // カテゴリ情報が入ったボタンを取得
        const categoryId = accordionButton.getAttribute('data-cate-id'); // cate_id を取得
        const categoryName = accordionButton.getAttribute('data-category'); // category を取得

        // 2. タグ名を取得
        const listItem = button.closest('li'); // ボタンが属する li を取得
        const tagName = listItem.querySelector('.li').innerText.trim(); // li 内のタグ名を取得

        // 編集モーダル 2 を表示
        const editModal2 = document.getElementById("editModal2");
        editModal2.style.display = "block";

        // モーダル内の入力フィールドにタグ名を設定
        const modalInput = editModal2.querySelector('#editInput2');
        modalInput.value = tagName; // 取得したタグ名を設定

        // cate_idを隠しフィールドに設定
        const cateIdInput = document.getElementById("cateIdInput");
        cateIdInput.value = categoryId;

        // デバッグ用ログ
        console.log('カテゴリID:', categoryId);
        console.log('カテゴリ名:', categoryName);
        console.log('タグ名:', tagName);

        // 完了ボタンの処理
        document.getElementById("confirmEdit2").onclick = () => {
            console.log('編集後のカテゴリID:', categoryId);
            console.log('編集後のカテゴリ名:', categoryName);
            console.log('編集後のタグ名:', modalInput.value);

            // フォームを送信
            const form = document.getElementById("tag_edit_form");
            form.submit(); // フォームを送信
        };
    };
});





// 削除ボタンのクリックイベント（カテゴリ削除）
deleteButtons.forEach(button => {
    button.onclick = (event) => {
        // DELEbtn が属する親要素 (div.container) を取得
        const container = button.closest('.container');

        // その中の accordion-button を取得
        const accordionButton = container.querySelector('.accordion-button');

        // accordion-button から data 属性を取得
        const categoryId = accordionButton.getAttribute('data-cate-id');
        const categoryName = accordionButton.getAttribute('data-category');

        // デバッグ用ログ
        console.log('クリックされた削除ボタン:', button);
        console.log('対応するカテゴリID:', categoryId);
        console.log('対応するカテゴリ名:', categoryName);

        // モーダル表示処理
        const deleteModal = document.getElementById("deleteModal");
        deleteModal.style.display = "block";

        // モーダル内の入力フィールドにカテゴリ名を設定
        const deleteInput = deleteModal.querySelector('#deleteInput1');
        deleteInput.value = categoryName;

        // 隠しフィールドにカテゴリIDを設定
        const hiddenInput = deleteModal.querySelector('#categoryIdInput2');
        hiddenInput.value = categoryId;

        // 確認ボタンのクリックイベント
        document.getElementById("confirmDELE").onclick = () => {
            console.log('削除が確定されたカテゴリID:', categoryId);
            console.log('削除対象のカテゴリ名:', categoryName);

            // フォームを送信
            document.getElementById("cate_delete_form").submit();
        };
    };
});



// 削除ボタン 2のクリックイベント（タグ削除）
deleteButtons2.forEach(button => {
    button.onclick = () => {
        // 1. カテゴリ情報を取得
        const accordionItem = button.closest('.accordion-item'); // 親の accordion-item を取得
        const accordionButton = accordionItem.querySelector('.accordion-button'); // カテゴリ情報が入ったボタンを取得
        const categoryId = accordionButton.getAttribute('data-cate-id'); // cate_id を取得
        const categoryName = accordionButton.getAttribute('data-category'); // category を取得

        // 2. タグ名を取得
        const listItem = button.closest('li'); // ボタンが属する li を取得
        const tagName = listItem.querySelector('.li').innerText.trim(); // li 内のタグ名を取得

        // モーダルの表示
        const deleteModal2 = document.getElementById("deleteModal2");
        deleteModal2.style.display = "block";

        // モーダル内の入力フィールドにタグ名を設定
        const deleteInput = deleteModal2.querySelector('#deleteInput2');
        deleteInput.value = tagName;

        // cate_idを隠しフィールドに設定
        const cateIdInput2 = document.getElementById("cateIdInput2");
        cateIdInput2.value = categoryId;

        // デバッグ用ログ
        console.log('カテゴリID:', categoryId);
        console.log('カテゴリ名:', categoryName);
        console.log('削除対象のタグ名:', tagName);

        // 削除確認ボタンの処理
        document.getElementById("confirmDELE2").onclick = () => {
            console.log('削除が確定されたカテゴリID:', categoryId);
            console.log('削除対象のタグ名:', tagName);

            // フォームを送信
            const form = document.getElementById("tag_delete_form");
            form.submit(); // フォームを送信
        };
    };
});



// 追加ボタンがクリックされたらaddModalを表示
addButtons.forEach(button => {
    button.onclick = () => {
        addModal.style.display = "block";
    };
});

addButtons2.forEach(button => {
    button.onclick = () => {
        addModal2.style.display = "block";
    };
});

// 閉じるボタンまたは背景がクリックされたらモーダルを閉じる
closeButtons.forEach(button => {
    button.onclick = () => {
        button.closest(".modal").style.display = "none";
    };
});

window.onclick = (event) => {
    if (event.target.classList.contains("modal")) {
        event.target.style.display = "none";
    }
};



document.getElementById("confirmAdd").onclick = () => {
    // 1. カテゴリ情報を取得
    const accordionItem = button.closest('.accordion-item'); // 親の accordion-item を取得
    const accordionButton = accordionItem.querySelector('.accordion-button'); // カテゴリ情報が入ったボタンを取得
    const categoryId = accordionButton.getAttribute('data-cate-id'); // cate_id を取得
    const categoryName = accordionButton.getAttribute('data-category'); // category を取得

    const cateIdInput2 = document.getElementById("cateIdInput3");
    cateIdInput2.value = categoryId;

    // フォームを送信
    const form = document.getElementById("tag_add_form");
    form.submit(); // フォームを送信
};

document.getElementById("confirmAdd2").onclick = () => {
    // フォームを送信
    const form = document.getElementById("cate_add_form");
    form.submit(); // フォームを送信
};

// document.getElementById("confirmEdit").onclick = () => {
//     location.href = "relate"; // 編集後の処理を追加
// };
//
// document.getElementById("confirmEdit2").onclick = () => {
//     location.href = "relate"; // 編集後の処理を追加
// };
//
// document.getElementById("confirmDELE").onclick = () => {
//     location.href = "relate"; // 削除後の処理を追加
// };
//
// document.getElementById("confirmDELE2").onclick = () => {
//     location.href = "relate"; // 削除後の処理を追加
// };

