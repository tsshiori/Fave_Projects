document.addEventListener('DOMContentLoaded', () => {
    const modalOpenButton = document.getElementById('modalOpen'); // モーダルを開くボタン
    const modal = document.getElementById('easyModal'); // モーダル要素
    const confirmButton = document.getElementById('confirmDelete'); // 確定ボタン
    const cancelButton = document.getElementById('cancelDelete'); // キャンセルボタン

    // フォームの入力要素
    const workInput = document.querySelector('input[name="work"]');
    const hourlyWageInput = document.querySelector('input[name="hourlywage"]');
    const mainWorkInput = document.querySelector('input[name="main"]');

    // モーダル内の表示要素
    const modalWorkName = document.getElementById('modal-work-name');
    const modalHourlyWage = document.getElementById('modal-hourlywage');
    const modalMainWork = document.getElementById('modal-mainwork');

    // プレースホルダーの内容を取得する関数
    const getPlaceholderOrValue = (inputElement) => {
        return inputElement.value.trim() || inputElement.getAttribute('placeholder') || "未入力";
    };

    // モーダルを開く処理
    modalOpenButton.addEventListener('click', () => {
        // フォーム内容をモーダルに反映
        modalWorkName.textContent = getPlaceholderOrValue(workInput);
        modalHourlyWage.textContent = getPlaceholderOrValue(hourlyWageInput)
            .replace(/(\d+)/, (match) => `¥${Number(match).toLocaleString()}`); // 数値をカンマ区切りに
        modalMainWork.innerHTML = mainWorkInput.checked
            ? '<span style="color: green;">✔ メインのバイト先に設定されます</span>'
            : '<span style="color: red;">✘ メインのバイト先には設定されません</span>';

        // モーダルを表示
        modal.style.display = 'block';
    });

    // モーダルを閉じる処理（キャンセル）
    cancelButton.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    // モーダル確定処理
    confirmButton.addEventListener('click', () => {
        document.getElementById('work_edit_form').submit(); // フォームを送信
    });

    // モーダル外をクリックしたら閉じる
    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
});

// フォーム送信時にプレースホルダーを反映
document.getElementById('work_edit_form').addEventListener('submit', (event) => {
    // 各入力要素を取得
    const workInput = document.getElementById('work_input');
    const hourlyWageInput = document.getElementById('hourlywage_input');

    // work の値が空の場合、プレースホルダーの値を設定
    if (!workInput.value.trim()) {
        workInput.value = workInput.placeholder;
    }

    // hourlywage の値が空の場合、プレースホルダーの値を設定
    if (!hourlyWageInput.value.trim()) {
        hourlyWageInput.value = hourlyWageInput.placeholder;
    }
});