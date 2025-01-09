// テキスト入力とスライダーを同期する関数
function syncRange(inputId, rangeId) {
    const input = document.getElementById(inputId);
    const range = document.getElementById(rangeId);

    if (input && range) {
        let value = parseInt(input.value);
        if (!isNaN(value)) {
            value = Math.max(0, Math.min(value, 999999)); // 範囲制限
            input.value = value;
            range.value = value;
        }
    }
}

// 入力値またはスライダーを調整する関数
function adjustAmount(step, inputId, rangeId) {
    const input = document.getElementById(inputId);
    const range = document.getElementById(rangeId);

    if (input && range) {
        let value = parseInt(input.value) + step;

        // 0から999999の範囲内で値を設定
        value = Math.max(0, Math.min(value, 999999));

        // テキスト入力とスライダーの値を更新
        input.value = value;
        range.value = value;
    }
}

// スライダーの値をテキスト入力に反映する関数
function syncInput(inputId, rangeId) {
    const input = document.getElementById(inputId);
    const range = document.getElementById(rangeId);

    if (input && range) {
        // スライダーの値を入力に反映
        let value = parseInt(range.value);
        value = Math.max(0, Math.min(value, 999999)); // 範囲制限
        input.value = value;
    }
}

// モーダルの「登録」ボタンを押したときの処理
const buttonConfirmRe = document.getElementById('confirm');
const form = document.getElementById('my_edit_form');
buttonConfirmRe.addEventListener('click', () => {
    form.submit(); // フォーム送信
});