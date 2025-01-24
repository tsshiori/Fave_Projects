const buttonOpen = document.getElementById('modalOpen');
const modal = document.getElementById('easyModal');
const buttonCancel = document.getElementById('cancelRe');
const buttonConfirmRe = document.getElementById('confirmRe'); // 修正箇所

// モーダルを開く
buttonOpen.addEventListener('click', () => {
    // 入力値を取得
    const registerForm = document.getElementById('registerForm');
    const logId = registerForm.log_id.value || "未入力";
    const password = registerForm.password.value || "未入力";
    const nick = registerForm.nick.value || "未入力";
    const regImg = registerForm.regimg.value || "0";
    const amountHand = registerForm.amounthand.value || "0"; // 未入力なら 0 を設定
    const living = registerForm.living.value || "0"; // 未入力なら 0 を設定
    const name = registerForm.name.value || "未入力";

    // 入力値をモーダルに反映
    document.getElementById("modalId").textContent = logId;
    document.getElementById("modalPassword").textContent = "*".repeat(password.length); // パスワードを非表示
    document.getElementById("modalNick").textContent = nick;
    document.querySelector(".modal-body img").src = `static/img/I_${["N", "B", "G", "R", "V", "Y"][regImg]}.png`; // アイコン切り替え
    document.getElementById("modalAmount").textContent = `¥${Number(amountHand).toLocaleString()}`; // 数値をフォーマット
    document.getElementById("modalLiving").textContent = `¥${Number(living).toLocaleString()}`; // 数値をフォーマット
    document.getElementById("modalSai").textContent = name;

    // モーダルを表示
    modal.style.display = "block";
});

// モーダルを閉じる（キャンセルボタン）
buttonCancel.addEventListener('click', () => {
    modal.style.display = 'none';
});

// 登録ボタンのイベントリスナー（フォーム送信）
buttonConfirmRe.addEventListener('click', () => {
    const form = document.getElementById('registerForm');
    form.submit();
});

// モーダルの外をクリックして閉じる
window.addEventListener('click', (e) => {
    if (e.target === modal) {
        modal.style.display = 'none';
    }
});
