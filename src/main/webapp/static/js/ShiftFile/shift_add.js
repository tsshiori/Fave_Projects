document.addEventListener("DOMContentLoaded", () => {
    // モーダル関連の要素を取得
    const buttonOpen = document.getElementById("modalOpen");
    const buttonOpenzikyu = document.getElementById("modalOpenzikyu");
    const modal = document.getElementById("easyModal");
    const modal2 = document.getElementById("easyModal2");
    const buttonCancel = document.getElementById("cancelRe");
    const buttonCancel2 = document.getElementById("cancelRe2");
    const buttonConfirmRe = document.getElementById("confirmRe");
    const buttonConfirmRe2 = document.getElementById("confirmRe2");

    // シフト追加フォームの要素を取得
    const workSelect = document.getElementById("menu");
    const startTimeInput = document.getElementById("start-time");
    const endTimeInput = document.getElementById("end-time");
    const breakTimeInput = document.querySelector("input[name='breaktime']");
    const wageInput = document.getElementById("wage");
    const shiftAddForm = document.getElementById("shift_add_form");

    // 時給変更用モーダルの要素を取得
    const modalWageInput = modal2.querySelector(".modal-input"); // モーダル内の時給入力欄
    const modalRadioButtons = modal2.querySelectorAll("input[name='zikyu-change']"); // ラジオボタン

    // モーダル内の値を表示する要素を取得
    const modalValues = modal.querySelectorAll(".value");

    // モーダルを開く（登録確認モーダル）
    buttonOpen.addEventListener("click", () => {
        // 各入力値を取得してモーダルに挿入
        const workName = workSelect.options[workSelect.selectedIndex]?.text || "未選択";
        const startTime = startTimeInput.value
            ? new Date(startTimeInput.value).toLocaleString("ja-JP", { dateStyle: "short", timeStyle: "short" })
            : "未入力";
        const endTime = endTimeInput.value
            ? new Date(endTimeInput.value).toLocaleString("ja-JP", { dateStyle: "short", timeStyle: "short" })
            : "未入力";
        const breakTime = breakTimeInput.value ? `${breakTimeInput.value} 分` : "未入力";
        const wage = wageInput.value ? `￥${parseInt(wageInput.value).toLocaleString()}` : "未入力";

        modalValues[0].textContent = workName; // バイト先
        modalValues[1].textContent = startTime; // 開始時間
        modalValues[2].textContent = endTime; // 終了時間
        modalValues[3].textContent = breakTime; // 休憩時間
        modalValues[4].textContent = wage; // 時給

        // モーダルを表示
        modal.style.display = "block";
        modal.style.opacity = "1"; // 表示用のオパシティを設定
        modal.style.visibility = "visible"; // visibilityで表示状態にする
    });

    // モーダルを開く（時給変更）
    buttonOpenzikyu.addEventListener("click", () => {
        const currentWage = wageInput.value; // 現在の時給を取得
        modalWageInput.value = currentWage || ""; // モーダル内の時給入力欄に設定

        // モーダルを表示
        modal2.style.display = "block";
        modal2.style.opacity = "1"; // 表示用のオパシティを設定
        modal2.style.visibility = "visible"; // visibilityで表示状態にする
    });

    // モーダルを閉じる（キャンセルボタン）
    buttonCancel.addEventListener("click", closeAllModals);
    buttonCancel2.addEventListener("click", closeAllModals);

    // モーダル外クリックで閉じる
    window.addEventListener("click", (event) => {
        if (event.target === modal || event.target === modal2) {
            closeAllModals();
        }
    });

    // モーダルを閉じる関数
    function closeAllModals() {
        modal.style.visibility = "hidden";
        modal2.style.visibility = "hidden";
        modal.style.opacity = "0"; // 非表示にするためopacityを設定
        modal2.style.opacity = "0"; // 非表示にするためopacityを設定
    }

    // 時給変更モーダルの確認ボタン
    buttonConfirmRe2.addEventListener("click", () => {
        console.log("Confirm button clicked");

        // モーダル内の時給をシフト追加フォームに反映
        wageInput.value = modalWageInput.value;

        // 選択されたラジオボタンの値をシフト追加フォームに反映
        const selectedRadio = Array.from(modalRadioButtons).find((radio) => radio.checked);
        if (selectedRadio) {
            // ラジオボタンの値をhiddenフィールドでシフト追加フォームに追加
            let existingHidden = shiftAddForm.querySelector("input[name='zikyu-change']");
            if (!existingHidden) {
                // 初回だけhiddenフィールドを作成
                existingHidden = document.createElement("input");
                existingHidden.type = "hidden";
                existingHidden.name = "zikyu-change";
                shiftAddForm.appendChild(existingHidden);
            }
            existingHidden.value = selectedRadio.value;
        } else {
            // ラジオボタンが未選択の場合はデフォルト値(-1)を設定
            let existingHidden = shiftAddForm.querySelector("input[name='zikyu-change']");
            if (!existingHidden) {
                // 初回だけhiddenフィールドを作成
                existingHidden = document.createElement("input");
                existingHidden.type = "hidden";
                existingHidden.name = "zikyu-change";
                shiftAddForm.appendChild(existingHidden);
            }
            existingHidden.value = "-1";
        }

        // モーダルを閉じる
        closeAllModals();
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

    // プレースホルダーの表示・非表示処理
    const inputs = document.querySelectorAll(".pl-input");
    inputs.forEach((input) => {
        const placeholder = input.nextElementSibling;

        input.addEventListener("focus", () => {
            if (placeholder) placeholder.style.display = "none";
        });

        input.addEventListener("blur", () => {
            if (!input.value && placeholder) {
                placeholder.style.display = "block";
            }
        });

        // 初期状態のプレースホルダー設定
        if (!input.value && placeholder) {
            placeholder.style.display = "block";
        }
    });

    // モーダルの確認ボタンをクリックでフォームを送信
    buttonConfirmRe.addEventListener("click", function () {
        document.getElementById("shift_add_form").submit();
    });
});
