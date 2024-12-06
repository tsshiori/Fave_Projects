// ボタンとモーダルの取得
const showModal1 = document.getElementById('showModal1');
const showModal2 = document.getElementById('showModal2');
const modal1 = document.getElementById('modal1');
const modal2 = document.getElementById('modal2');
const buttonCancel1 = document.getElementById('cancelDelete1');
const buttonCancel2 = document.getElementById('cancelDelete2');
const buttonConfirmDelete1 = document.getElementById('confirmDelete1');
const buttonConfirmDelete2 = document.getElementById('confirmDelete2');

// モーダルを開くイベントリスナー
showModal1.addEventListener('click', function() {
    modal1.style.display = 'block';
});

showModal2.addEventListener('click', function() {
    modal2.style.display = 'block';
});

// モーダルを閉じるイベントリスナー
buttonCancel1.addEventListener('click', function() {
    modal1.style.display = 'none';
});

buttonCancel2.addEventListener('click', function() {
    modal2.style.display = 'none';
});

// 削除確定イベントリスナー
// buttonConfirmDelete1.addEventListener('click', function() {
//     window.location.href = '../login/login.html';
// });

buttonConfirmDelete1.addEventListener('click',ConfirmDelete1);
function ConfirmDelete1() {
    modal2.style.display = 'none';
}

// モーダル外をクリックしたときにモーダルを閉じる
window.addEventListener('click', function(e) {
    if (e.target === modal1) {
        modal1.style.display = 'none';
    }
    if (e.target === modal2) {
        modal2.style.display = 'none';
    }
});
