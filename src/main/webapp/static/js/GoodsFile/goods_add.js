document.addEventListener("DOMContentLoaded", () => {
    // フォームの表示切り替え
    const checkbox = document.getElementById('switch');
    const title = document.querySelector('.title');
    const goodsForm = document.getElementById('goods');
    const eventsForm = document.getElementById('events');

    checkbox.addEventListener('click', () => {
        if (checkbox.checked) {
            title.textContent = 'イベント';
            goodsForm.style.display = 'none';
            eventsForm.style.display = 'block';
        } else {
            title.textContent = 'グッズ';
            goodsForm.style.display = 'block';
            eventsForm.style.display = 'none';
        }
    });

    // 初期状態でイベントフォームを非表示
    eventsForm.style.display = 'none';

    // モーダル関連要素
    const modalGoods = document.getElementById('easyModalGoods');
    const modalEvents = document.getElementById('easyModalEvents');
    const addGoodsButton = document.getElementById('AddGoods');
    const cancelGoodsButton = document.getElementById('ReGoods');
    const addEventsButton = document.getElementById('AddEvents');
    const cancelEventsButton = document.getElementById('ReEvents');

    // グッズモーダルの表示/非表示
    document.getElementById('modalOpenGoods').addEventListener('click', () => {
        modalGoods.style.display = 'block';
    });
    cancelGoodsButton.addEventListener('click', () => {
        modalGoods.style.display = 'none';
    });
    addGoodsButton.addEventListener('click', () => {
        const goodsName = document.getElementById('goodsInput').value;
        console.log('追加するグッズ:', goodsName);
        modalGoods.style.display = 'none';
    });

    // イベントモーダルの表示/非表示
    document.getElementById('modalOpenEvents').addEventListener('click', () => {
        modalEvents.style.display = 'block';
    });
    cancelEventsButton.addEventListener('click', () => {
        modalEvents.style.display = 'none';
    });
    addEventsButton.addEventListener('click', () => {
        const eventName = document.getElementById('eventsInput').value;
        console.log('追加するイベント:', eventName);
        modalEvents.style.display = 'none';
    });

    // ウィンドウ外クリックでモーダルを閉じる
    window.addEventListener('click', (event) => {
        if (event.target.className === 'modalbody') {
            modalGoods.style.display = 'none';
            modalEvents.style.display = 'none';
        }
    });
});
