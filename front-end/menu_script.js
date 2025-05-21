const userIcon = document.querySelector('.user-icon');
const dropdownMenu = document.querySelector('.dropdown-menu');

userIcon.addEventListener('click', () => {
    dropdownMenu.classList.toggle('show');
});


document.addEventListener('click', (event) => {
    
    const isClickInsideUserIcon = userIcon.contains(event.target);
    const isClickInsideDropdownMenu = dropdownMenu.contains(event.target);

    if (!isClickInsideUserIcon && !isClickInsideDropdownMenu) {
        dropdownMenu.classList.remove('show');
    }
});