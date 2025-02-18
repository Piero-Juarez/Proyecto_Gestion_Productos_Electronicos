/**
 * Script Notas Rápidas
 */

const container = document.getElementById('card-container');
const addCardBtn = document.getElementById('add-card');
let cardCount = 0;

document.addEventListener('DOMContentLoaded', () => {
    const savedCards = getCards();

    cardCount = Object.keys(savedCards).length ? Math.max(...Object.keys(savedCards).map(Number)) + 1 : 0;

    Object.entries(savedCards).forEach(([id, content]) => createCard(content, parseInt(id)));
    
    if (Object.keys(savedCards).length >= 5) {
        addCardBtn.style.display = 'none';
    }
});

addCardBtn.addEventListener('click', () => {
    if (cardCount < 5) {
        createCard();
    }
});

function createCard(content = '', id = cardCount++) {
    const card = document.createElement('div');
    card.className = 'card';
    card.dataset.id = id;

    card.innerHTML = `
    <textarea ${content && 'readonly'} placeholder="Deja una nota rápida para todos tus compañeros de trabajo...">${content}</textarea>
    <div class="icon">
        <button class="save-btn" style="display: ${content ? 'none' : 'block'};"><i class="bi bi-check2-square"></i> Guardar</button>
        <button class="delete-btn" style="display: ${content ? 'block' : 'inline-block'};"><i class="bi bi-trash-fill"></i> Eliminar</button>
        <button class="edit-btn" style="display: ${content ? 'block' : 'none'};"><i class="bi bi-pencil-square"></i> Editar</button>
    </div>`;

    container.appendChild(card);
	
    const currentCards = Object.keys(getCards()).length;

    if (currentCards >= 4) {
        addCardBtn.style.display = 'none';
    }

    const [textarea, saveBtn, editBtn, deleteBtn] = 
          ['textarea', '.save-btn', '.edit-btn', '.delete-btn'].map(s => card.querySelector(s));

    textarea.focus();
    textarea.addEventListener('input', () => 
        saveBtn.style.display = textarea.value.trim() ? 'block' : 'none'
    );

    saveBtn.addEventListener('click', () => toggleEdit(textarea, saveBtn, editBtn, deleteBtn, id, true));
    editBtn.addEventListener('click', () => toggleEdit(textarea, saveBtn, editBtn, deleteBtn, id, false));
    deleteBtn.addEventListener('click', () => removeCard(card, id));
}

function toggleEdit(textarea, saveBtn, editBtn, deleteBtn, id, save) {
    textarea.toggleAttribute('readonly', save);
    saveToLocalStorage(id, save ? textarea.value : '');
    [saveBtn, editBtn, deleteBtn].forEach(btn => 
        btn.style.display = save === btn.classList.contains('save-btn') ? 'none' : 'inline-block'
    );
}

function removeCard(card, id) {
    card.remove();
    removeFromLocalStorage(id);
    cardCount--;
    const currentCards = Object.keys(getCards()).length;

    if (currentCards < 5) {
        addCardBtn.style.display = 'block';
    }
}

function getCards() {
    return JSON.parse(localStorage.getItem('cards') || '{}');
}

function saveToLocalStorage(id, content) {
    const cards = getCards();
    cards[id] = content;
    localStorage.setItem('cards', JSON.stringify(cards));
}

function removeFromLocalStorage(id) {
    const cards = getCards();
    delete cards[id];
    localStorage.setItem('cards', JSON.stringify(cards));
}
