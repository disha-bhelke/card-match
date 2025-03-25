let score1=0
let score2=0
let x=0;
let y=0;
let i=0;

function shuffleArray(cards) {
    for (let i = cards.length - 1; i > 0; i--) {
        let j = Math.floor(Math.random() * (i + 1)); // Pick a random index
        [cards[i], cards[j]] = [cards[j], cards[i]]; // Swap elements
    }
    return cards;
}

let cards = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]
console.log(shuffleArray(cards));


instruct=()=>{
    alert("Player 1 starts the game");
}

start = ()=>{
    if (document.getElementById("player1").value!="" && document.getElementById("player2").value!=""){
        event.preventDefault();
        window.location.href='game.html'
        let play1 = document.getElementById("player1").value;
        let play2 = document.getElementById("player2").value;

        localStorage.setItem('first_player',play1)
        localStorage.setItem('first_score',score1)
        localStorage.setItem('second_player',play2)
        localStorage.setItem('second_score',score2)
        display_names();
        game();
    }
    else{
        alert("Enter player's names")
    }
}

display_names=()=>{
    document.getElementById("playe1").innerText=localStorage.getItem("first_player")
    document.getElementById("sc1").innerText=localStorage.getItem("first_score")
    document.getElementById("playe2").innerText=localStorage.getItem("second_player")
    document.getElementById("sc2").innerText=localStorage.getItem("second_score")
}

window.onbeforeunload = function(event) {
    if (window.location.pathname.includes("game.html")) {
        event.preventDefault();
        let confirmation = confirm("Are you sure you want to leave the game?")
        if (confirmation) {
            localStorage.clear()
            window.history.back()
        } else {

            history.pushState(null, null, window.location.href)
        }
    }
    
}

clear_storage=()=>{
    localStorage.clear()
}

window.onload = function() {
    if (window.location.pathname.includes("game.html")) {
        display_names();
    }
};

display_image=(n)=>{
    let division = document.querySelectorAll(".card_grid div");
    division[n-1].innerHTML = `<img src="images/card${cards[n-1]}.png" width=100% align-self=centre>`;
}

reset_cards = (x, y) => {
    let division = document.querySelectorAll(".card_grid div");
    if (x > 0 && y > 0) {  // Ensure valid indices
        division[x - 1].innerHTML = "";
        division[y - 1].innerHTML = "";
    }
};

set=(n)=>{
    display_image(n)
    if (x==0){
        x=n;
    }
    else{
        y=n;
        game();
    }
}

game=()=>{
    if (cards[x-1]==cards[y-1]){
        if (i%2==0){
            score1 += 10
            localStorage.setItem('first_score',score1)
            display_names()

        }
        else{
            score2 +=10
            localStorage.setItem('second_score',score2)
            display_names()
        }
        cards.splice(x-1,1)
        cards.splics(y-1,1)
    }
    else{
        let tempX=x;
        let tempY=y;
        setTimeout(() => reset_cards(tempX, tempY), 1000);
        i++;
    }
    x=0
    y=0

    if (cards.length==0){
        if (score1>score2){
            alert(`${first_player} WINS!!`)
        }
        else if (score2>score1){
            alert(`${second_player} WINS!!`)
        }
        else{
            alert("IT'S A TIE!!")
        }
    }
}