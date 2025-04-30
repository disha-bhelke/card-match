let score1 = 0;
let score2 = 0;
let x = null;
let y = null;
let i = 0;
let flipped = Array(20).fill(false);
let canClick = true;
const flipSound = new Audio("images/flipcard-91468-VEED.mp3");

let cards = shuffleArray([1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]);

function shuffleArray(cards) {
    for (let i = cards.length - 1; i > 0; i--) {
        let j = Math.floor(Math.random() * (i + 1));
        [cards[i], cards[j]] = [cards[j], cards[i]];
    }
    return cards;
}

start = () => {
    const p1 = document.getElementById("player1").value;
    const p2 = document.getElementById("player2").value;

    if (p1 && p2) {
        localStorage.setItem('first_player', p1);
        localStorage.setItem('second_player', p2);
        localStorage.setItem('first_score', 0);
        localStorage.setItem('second_score', 0);
        window.location.href = 'game.html';
    } else {
        alert("Enter player names");
    }
};

display_names = () => {
    document.getElementById("playe1").innerText = localStorage.getItem("first_player");
    document.getElementById("playe2").innerText = localStorage.getItem("second_player");
    document.getElementById("sc1").innerText = localStorage.getItem("first_score");
    document.getElementById("sc2").innerText = localStorage.getItem("second_score");
};

window.onload = () => {
    if (window.location.pathname.includes("game.html")) {
        display_names();
    }
};

set = (n) => {
    if (!canClick || flipped[n - 1]) return;

    // Don't allow clicking same card twice
    if (x === n) return;

    canClick = false;
    flipSound.currentTime = 0;
    flipSound.play().catch(() => {});

    display_image(n);

    if (x === null) {
        x = n;
        canClick = true;
    } else {
        y = n;
        setTimeout(checkMatch, 1000);
    }
};


display_image = (n) => {
    const divs = document.querySelectorAll(".card_grid div");
    divs[n - 1].innerHTML = `<img src="images/card${cards[n - 1]}.png" width="100%">`;
};

reset_cards = (a, b) => {
    const divs = document.querySelectorAll(".card_grid div");
    divs[a - 1].innerHTML = "";
    divs[b - 1].innerHTML = "";
};

checkMatch = () => {
    if (cards[x - 1] === cards[y - 1]) {
        flipped[x - 1] = true;
        flipped[y - 1] = true;

        if (i % 2 === 0) {
            score1 += 10;
            localStorage.setItem('first_score', score1);
        } else {
            score2 += 10;
            localStorage.setItem('second_score', score2);
        }
    } else {
        reset_cards(x, y);
        i++; // next player's turn
    }

    display_names();

    x = null;
    y = null;
    canClick = true;

    if (flipped.every(f => f)) {
        endGame();
    }
};

endGame = () => {
    const p1 = localStorage.getItem("first_player");
    const p2 = localStorage.getItem("second_player");

    if (score1 > score2) {
        alert(`${p1} WON !!`);
    } else if (score2 > score1) {
        alert(`${p2} WON !!`);
    } else {
        alert("IT'S A TIE !!");
    }

    localStorage.clear();
    window.location.href = 'home.html';
};

clear_storage = () => {
    const confirmation = confirm("Are you sure you want to EXIT the game?");
    if (confirmation) {
        localStorage.clear();
        window.location.href = 'home.html';
    }
};

window.addEventListener("popstate", () => {
    const confirmation = confirm("Are you sure you want to EXIT the game?");
    if (confirmation) {
        localStorage.clear();
        window.location.href = 'home.html';
    }
});
