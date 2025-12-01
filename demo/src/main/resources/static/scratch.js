console.log("SCRATCH JS STARTED");
let currentUser = null;

// Регистрация
async function register() {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();

    if (!username || !password) {
        alert('Пожалуйста, заполните все поля.');
        return;
    }

    const res = await fetch('/auth/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `username=${encodeURIComponent(username)}&password=${encodeURIComponent(password)}`
    });
}

// Вход
async function login() {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();

    if (!username || !password) {
        alert('Введите логин и пароль.');
        return;
    }

    const res = await fetch(`/auth/login?username=${username}&password=${password}`, { method: 'POST' });
    const data = await res.json();

    if (res.status !== 200) {
        return alert(data.message);
    }

    currentUser = { id: data.id, username, role: data.role }; // <-- теперь точно получаем роль
    document.getElementById('authSection').style.display = 'none';
    document.getElementById('bookingSection').style.display = 'block';
    document.getElementById('userDisplay').innerText = username;
    loadRooms();
}

// Выход
function logout() {
    currentUser = null;
    document.getElementById('authSection').style.display = 'block';
    document.getElementById('bookingSection').style.display = 'none';
}

// Загрузка списка комнат
async function loadRooms() {
    const res = await fetch('/hotel2/rooms');
    const rooms = await res.json();
    const div = document.getElementById('rooms');
    div.innerHTML = '';

    rooms.forEach(r => {
        const roomDiv = document.createElement('div');
        roomDiv.className = 'room';
        roomDiv.style.display = 'flex';                 // включаем flex для выравнивания
        roomDiv.style.justifyContent = 'space-between'; // разделяем контент и ссылку
        roomDiv.style.alignItems = 'center';
        roomDiv.style.padding = '10px';
        roomDiv.style.border = '1px solid #ccc';
        roomDiv.style.borderRadius = '8px';
        roomDiv.style.marginBottom = '10px';

        // Левая часть с инфо и кнопкой
        const leftDiv = document.createElement('div');
        leftDiv.innerHTML = `
            <p><b>${r.name}</b></p>
            <p>Цена: ${r.price ?? '—'} €</p>
            <p>Статус: <b>${r.vacant ? 'Свободна' : 'Забронирована'}</b></p>
            <label>Дата начала: <input type="date" id="start-${r.id}" ${r.vacant ? '' : 'disabled'}></label>
            <label>Дата окончания: <input type="date" id="end-${r.id}" ${r.vacant ? '' : 'disabled'}></label>
        `;

        const button = document.createElement('button');
        if (r.vacant) {
            button.textContent = 'Бронировать';
            button.className = 'book-btn';
            button.addEventListener('click', () => bookRoom(r.id));
        } else {
            button.textContent = 'Отменить бронирование';
            button.className = 'cancel-btn';
            button.addEventListener('click', () => cancelBooking(r.id));
        }
        leftDiv.appendChild(button);

        // Правая часть — ссылка "See details >>>"
        const rightDiv = document.createElement('div');
        const detailsLink = document.createElement('a');
        detailsLink.href = `/rooms/${r.id}`;
        detailsLink.textContent = 'See details >>>';
        detailsLink.className = 'details-link';
        detailsLink.style.textDecoration = 'none';
        detailsLink.style.color = '#007bff';
        detailsLink.style.fontWeight = 'bold';

        rightDiv.appendChild(detailsLink);

        // Собираем в одну карточку
        roomDiv.appendChild(leftDiv);
        roomDiv.appendChild(rightDiv);

        div.appendChild(roomDiv);
    });
}

// Бронирование комнаты
async function bookRoom(id) {
    const startDate = document.getElementById(`start-${id}`).value;
    const endDate = document.getElementById(`end-${id}`).value;

    if (!startDate || !endDate) {
        alert('Пожалуйста, выберите даты бронирования');
        return;
    }
    if (endDate < startDate) {
        alert('Дата окончания не может быть раньше даты начала');
        return;
    }

   const res = await fetch(
       `/hotel2/rooms/${id}/book?startDate=${startDate}&endDate=${endDate}&userId=${currentUser.id}`,
       { method: 'POST' }
   );
    if (res.ok) {
        alert('Комната успешно забронирована!');
        loadRooms();
    } else {
        const err = await res.text();
        alert('Ошибка бронирования: ' + err);
    }
}

async function cancelBooking(id) {
    const res = await fetch(
        `/hotel2/rooms/${id}/cancel?userId=${currentUser.id}&role=${currentUser.role || 'USER'}`,
        { method: 'POST' }
    );
    if (res.ok) {
        alert('Бронирование отменено!');
        loadRooms();
    } else {
        const err = await res.text();
        alert('Ошибка отмены бронирования: ' + err);
    }
}

