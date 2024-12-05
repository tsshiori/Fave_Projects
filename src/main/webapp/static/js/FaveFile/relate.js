// アコーディオンのボタンをすべて取得
const accordionButtons = document.querySelectorAll('.accordion-button');

// 各ボタンにクリックイベントを設定
accordionButtons.forEach(button => {
    button.addEventListener('click', function() {
        // 最も近い親の .accordion-item 内の .accordion-content を取得
        const content = this.closest('.accordion-item').querySelector('.accordion-content');
        const downImage = this.querySelector('.DOWN');  // ボタン内の画像要素

        // すべてのコンテンツを閉じる
        document.querySelectorAll('.accordion-content').forEach(item => {
            if (item !== content) {
                item.classList.remove('show');  // 他のセクションを閉じる
                // 他のセクションが閉じる時は画像も元に戻す
                const otherDownImage = item.closest('.accordion-item').querySelector('.DOWN');
                if (otherDownImage) {
                    otherDownImage.src = 'static/img/DOWN.png';  // 閉じる時の画像
                }
            }
        });

        // 現在のセクションを表示・非表示に切り替える
        content.classList.toggle('show');

        // 画像の切り替え
        if (content.classList.contains('show')) {
            downImage.src = 'static/img/DOWN2.png';  // 開いたときの画像
        } else {
            downImage.src = 'static/img/DOWN.png';  // 閉じたときの画像
        }
    });
});

// '閉じる'ボタンまたはテキストをクリックしたときにアコーディオンを閉じる処理
const closeElements = document.querySelectorAll('.close');

closeElements.forEach(closeElement => {
    closeElement.addEventListener('click', function() {
        // クリックされた要素が親の .accordion-content 内の .accordion-item を取得
        const content = this.closest('.accordion-content');  // '閉じる'ボタンの親要素である .accordion-content を取得
        const parentAccordionItem = content.closest('.accordion-item'); // 親の .accordion-item を取得
        const downImage = parentAccordionItem.querySelector('.DOWN'); // 親のボタン内の画像要素

        // コンテンツを非表示にし、画像を元に戻す
        content.classList.remove('show');
        downImage.src = "static/img/DOWN.png";  // 閉じたときの画像
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


// 編集ボタンがクリックされたらeditModalを表示
editButtons.forEach(button => {
    button.onclick = () => {
        editModal.style.display = "block";
    };
});

editButtons2.forEach(button => {
    button.onclick = () => {
        editModal2.style.display = "block";
    };
});

// 削除ボタンがクリックされたらdeleteModalを表示
deleteButtons.forEach(button => {
    button.onclick = () => {
        deleteModal.style.display = "block";
    };
});

deleteButtons2.forEach(button => {
    button.onclick = () => {
        deleteModal2.style.display = "block";
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

document.getElementById("confirmEdit").onclick = () => {
    location.href = "relate.html";
};

document.getElementById("confirmEdit2").onclick = () => {
    location.href = "relate.html";
};

document.getElementById("confirmAdd").onclick = () => {
    location.href = "relate.html";
};

document.getElementById("confirmAdd2").onclick = () => {
    location.href = "relate.html";
};

document.getElementById("confirmDELE").onclick = () => {
    location.href = "relate.html";
};

document.getElementById("confirmDELE2").onclick = () => {
    location.href = "relate.html";
};