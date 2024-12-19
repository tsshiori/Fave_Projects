document.addEventListener("DOMContentLoaded", () => {
    // モーダル関連の要素を取得
    const buttonOpen = document.getElementById('modalOpen');
    const buttonOpenzikyu = document.getElementById('modalOpenzikyu');
    const modal = document.getElementById('easyModal');
    const modal2 = document.getElementById('easyModal2');
    const buttonCancel = document.getElementById('cancelRe');
    const buttonCancel2 = document.getElementById('cancelRe2');
    const buttonConfirmRe = document.getElementById('confirmRe');
    const buttonConfirmRe2 = document.getElementById('confirmRe2');

    // フォーム要素を取得
    const form = document.getElementById('shift_edit_form');
    const workSelect = document.getElementById('menu');
    const startTimeInput = document.getElementById('start-time');
    const endTimeInput = document.getElementById('end-time');
    const breakTimeInput = document.querySelector("input[name='breaktime']");
    const wageInput = document.getElementById('wage');

    // モーダル内の表示要素を取得
    const modalWork = document.getElementById('modal-work');
    const modalStart = document.getElementById('modal-start');
    const modalEnd = document.getElementById('modal-end');
    const modalBreak = document.getElementById('modal-break');
    const modalWage = document.getElementById('modal-wage');
    const modalWageInput = modal2.querySelector(".modal-input"); // 時給変更用モーダル内の時給入力欄
    const modalRadioButtons = modal2.querySelectorAll("input[name='zikyu-change']"); // ラジオボタン

    // 日付フォーマット関数（YYYY/MM/DD HH:mm）
    function formatDate(date) {
        const d = new Date(date);
        const year = d.getFullYear();
        const month = String(d.getMonth() + 1).padStart(2, '0');
        const day = String(d.getDate()).padStart(2, '0');
        const hours = String(d.getHours()).padStart(2, '0');
        const minutes = String(d.getMinutes()).padStart(2, '0');
        return `${year}/${month}/${day} ${hours}:${minutes}`;
    }

    // モーダルを開く（登録）
    buttonOpen.addEventListener('click', () => {
        // フォームの値をモーダルに反映
        modalWork.textContent = workSelect.options[workSelect.selectedIndex]?.text || "未選択";
        modalStart.textContent = startTimeInput.value ? formatDate(startTimeInput.value) : startTimeInput.placeholder;
        modalEnd.textContent = endTimeInput.value ? formatDate(endTimeInput.value) : endTimeInput.placeholder;
        modalBreak.textContent = breakTimeInput.value || breakTimeInput.placeholder;
        modalWage.textContent = wageInput.value || wageInput.placeholder;

        // モーダルを表示
        modal.style.display = 'block';
    });

    // モーダルを開く（時給変更）
    buttonOpenzikyu.addEventListener('click', () => {
        const currentWage = wageInput.value; // 現在の時給を取得
        modalWageInput.value = currentWage || ""; // モーダル内の時給入力欄に設定

        // モーダルを表示
        modal2.style.display = 'block';
    });

    // モーダルを閉じる（キャンセルボタン）
    buttonCancel.addEventListener('click', modalClose);
    buttonCancel2.addEventListener('click', modalClose);
    function modalClose() {
        modal.style.display = 'none';  // モーダル1を閉じる
        modal2.style.display = 'none'; // モーダル2を閉じる
    }

    // モーダルの「登録」ボタンを押したときの処理
    buttonConfirmRe.addEventListener('click', () => {
        // 未入力のフィールドにプレースホルダーの値をセット
        if (!startTimeInput.value) startTimeInput.value = startTimeInput.placeholder;
        if (!endTimeInput.value) endTimeInput.value = endTimeInput.placeholder;
        if (!breakTimeInput.value) breakTimeInput.value = breakTimeInput.placeholder;
        if (!wageInput.value) wageInput.value = wageInput.placeholder;

        form.submit(); // フォーム送信
    });

    // モーダル外をクリックして閉じる
    window.addEventListener('click', (e) => {
        if (e.target === modal || e.target === modal2) {
            modalClose(); // モーダルを閉じる
        }
    });

    // プレースホルダーを非表示にする関数
    function hidePlaceholder(input) {
        const placeholder = input.nextElementSibling;
        if (placeholder) placeholder.style.display = 'none';
    }

    // プレースホルダーを表示する関数
    function showPlaceholder(input) {
        if (!input.value) {
            const placeholder = input.nextElementSibling;
            if (placeholder) placeholder.style.display = 'block';
        }
    }

    // 初期状態でプレースホルダーを表示
    const inputs = document.querySelectorAll('.pl-input');
    inputs.forEach(input => {
        const placeholder = input.nextElementSibling;
        if (!input.value && placeholder) {
            placeholder.style.display = 'block'; // 値がない場合、プレースホルダー表示
        }
    });

    // プレースホルダー表示・非表示の処理
    inputs.forEach(input => {
        const placeholder = input.nextElementSibling;

        input.addEventListener('focus', () => hidePlaceholder(input));
        input.addEventListener('blur', () => showPlaceholder(input));
    });

    // すべてのカスタムプレースホルダーを処理
    document.querySelectorAll('.input-container').forEach(container => {
        const input = container.querySelector('.pl-input');
        const placeholder = container.querySelector('.pl-placeholder');

        // プレースホルダーをクリックすると、inputにフォーカスして開く
        placeholder.addEventListener('click', () => {
            input.focus(); // inputにフォーカス
            input.click(); // 日付ピッカーを開くためにクリック
        });
    });

    // 時給変更モーダルの確認ボタン
    buttonConfirmRe2.addEventListener("click", () => {
        // モーダル内の時給をシフト追加フォームに反映
        wageInput.value = modalWageInput.value;

        // 選択されたラジオボタンの値をシフト追加フォームに反映
        const selectedRadio = Array.from(modalRadioButtons).find((radio) => radio.checked);
        if (selectedRadio) {
            // ラジオボタンの値をhiddenフィールドでシフト追加フォームに追加
            let existingHidden = form.querySelector("input[name='zikyu-change']");
            if (!existingHidden) {
                // 初回だけhiddenフィールドを作成
                existingHidden = document.createElement("input");
                existingHidden.type = "hidden";
                existingHidden.name = "zikyu-change";
                form.appendChild(existingHidden);
            }
            existingHidden.value = selectedRadio.value;
        } else {
            // ラジオボタンが未選択の場合はデフォルト値(-1)を設定
            let existingHidden = form.querySelector("input[name='zikyu-change']");
            if (!existingHidden) {
                // 初回だけhiddenフィールドを作成
                existingHidden = document.createElement("input");
                existingHidden.type = "hidden";
                existingHidden.name = "zikyu-change";
                form.appendChild(existingHidden);
            }
            existingHidden.value = "-1";
        }

        // モーダルを閉じる
        modalClose();
    });


    // 時給の動的更新
    workSelect.addEventListener("change", (event) => {
        const selectedOption = event.target.selectedOptions[0];
        const wage = selectedOption?.getAttribute("data-wage");

        if (wage) {
            wageInput.value = wage; // 選択された時給をフォームに反映
        } else {
            wageInput.value = ""; // 未選択時はクリア
        }
    });
});
