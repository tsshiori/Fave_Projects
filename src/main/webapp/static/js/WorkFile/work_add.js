document.addEventListener('DOMContentLoaded', () => {
    const modalOpenButton = document.getElementById('modalOpen'); // モーダルを開くボタン
    const modal = document.getElementById('easyModal'); // モーダル要素
    const confirmButton = document.getElementById('confirmDelete'); // 追加確定ボタン
    const cancelButton = document.getElementById('cancelDelete'); // キャンセルボタン

    // フォームの入力要素
    const workInput = document.querySelector('input[name="work"]');
    const hourlyWageInput = document.querySelector('input[name="hourlywage"]');
    const mainWorkInput = document.querySelector('input[name="mainwork"]');

    // モーダル内の表示要素
    const modalWorkName = document.getElementById('modal-work-name');
    const modalHourlyWage = document.getElementById('modal-hourlywage');
    const modalMainWork = document.getElementById('modal-mainwork');

    // モーダルを開く処理
    modalOpenButton.addEventListener('click', () => {
        // フォーム内容をモーダルに反映
        modalWorkName.textContent = workInput.value.trim() || "未入力"; // 未入力時はデフォルト表示
        modalHourlyWage.textContent = hourlyWageInput.value.trim()
            ? `¥${Number(hourlyWageInput.value).toLocaleString()}` // 数値をカンマ区切りに
            : "未入力";
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
        document.getElementById('work_add_form').submit(); // フォームを送信
    });

    // モーダル外をクリックしたら閉じる
    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
});
