document.addEventListener("DOMContentLoaded", () => {
    // フォームの表示切替
    const checkbox = document.getElementById('switch');
    const title = document.querySelector('.title');
    const galleryForm = document.getElementById('gallery');
    const listForm = document.getElementById('list');

    checkbox.addEventListener('click', () => {
        if (checkbox.checked) {
            galleryForm.style.display = 'none';
            listForm.style.display = 'block';
        } else {
            galleryForm.style.display = 'block';
            listForm.style.display = 'none';
        }
    });

    // 初期状態でイベントフォームを非表示
    listForm.style.display = 'none';

});
