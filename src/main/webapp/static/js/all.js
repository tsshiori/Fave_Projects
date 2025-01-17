// 初期設定
const foregroundMeter = document.querySelector('.foreground-meter');
const backgroundMeter = document.querySelector('.background-meter');
const temotiImage = document.querySelector('.temoti img');
const kyuuryoubiImage = document.querySelector('.kyuuryoubi img');

// メーター値に応じて画像の位置を更新する関数
function updateImagePosition() {
    const meterContainer = document.querySelector('.meter-container');

    // コンテナ幅と画像位置を計算
    const containerWidth = meterContainer.offsetWidth;

    // `value` をメーターの横幅に変換（割合で位置を決定）
    const foregroundPosition = Math.min((foregroundMeter.value / foregroundMeter.max) * containerWidth, containerWidth);
    const backgroundPosition = Math.min((backgroundMeter.value  / backgroundMeter.max) * containerWidth, containerWidth);


    // 画像の位置を更新
    temotiImage.style.left = `${foregroundPosition}px`;
    kyuuryoubiImage.style.left = `${backgroundPosition}px`;
}

// 初期状態で画像位置を設定
updateImagePosition();

// メーターの値が変化したときに更新
foregroundMeter.addEventListener('input', updateImagePosition);
backgroundMeter.addEventListener('input', updateImagePosition);


const temotiValue = document.querySelector('.temoti-value');
const kyuuryoubiValue = document.querySelector('.kyuuryoubi-value');

const foregroundMeter0 = document.querySelector('.foreground-meter');
const backgroundMeter0 = document.querySelector('.background-meter');

// 初期状態でvalueを設定
temotiValue.textContent = `所持金額: ¥${foregroundMeter0.value}`;
const back0 = backgroundMeter0.value - foregroundMeter0.value;
kyuuryoubiValue.textContent = `給与予定額: ¥${back0}`;

// 金額にカンマ区切りを追加する関数
function formatAmount(amount) {
    return amount.toLocaleString(); // カンマ区切りでフォーマット
}

// メーターの値が変化したときに金額表示を更新
foregroundMeter0.addEventListener('input', () => {
    temotiValue.textContent = `所持金額: ¥${formatAmount(foregroundMeter0.value)}`;
});

backgroundMeter0.addEventListener('input', () => {
    kyuuryoubiValue.textContent = `給与予定額: ¥${formatAmount(back0)}`;
});

// 初期状態で金額をフォーマットして表示
temotiValue.textContent = `所持金額: ¥${formatAmount(foregroundMeter0.value)}`;
kyuuryoubiValue.textContent = `給与予定額: ¥${formatAmount(back0)}`;


