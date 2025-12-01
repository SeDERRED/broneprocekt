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
        let buttons = '';

        if (r.vacant) {
            buttons = `<button class="book-btn" onclick="bookRoom(${r.id})">Бронировать</button>`;
        } else {
            buttons = `<button class="cancel-btn" onclick="cancelBooking(${r.id})">Отменить бронирование</button>`;
        }

        div.innerHTML += `
            <div class="room">
                <p><b>${r.name}</b></p>
                <p>Цена: ${r.price ?? '—'} €</p>
                <p>Статус: <b>${r.vacant ? 'Свободна' : 'Забронирована'}</b></p>
                <label>Дата начала: <input type="date" id="start-${r.id}" ${r.vacant ? '' : 'disabled'}></label>
                <label>Дата окончания: <input type="date" id="end-${r.id}" ${r.vacant ? '' : 'disabled'}></label>
                ${buttons}
            </div>
        `;
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

    const res = await fetch(`/hotel2/rooms/${id}/book?startDate=${startDate}&endDate=${endDate}&userId=${currentUser.id}`,`, { method: 'POST' });
    if (res.ok) {
        alert('Комната успешно забронирована!');
        loadRooms();
    } else {
        const err = await res.text();
        alert('Ошибка бронирования: ' + err);
    }
}

async function cancelBooking(id) {
    const res = await fetch(`/hotel2/rooms/${id}/cancel`, { method: 'POST' });
    const text = await res.text();
    alert(text);
    loadRooms();
}