//==================================================
// DG-HUD
// Main NUI Script
//==================================================

const HUD = {

    compass: document.getElementById("compass"),

    heading: document.getElementById("heading"),
    degrees: document.getElementById("degrees"),
    street: document.getElementById("street"),

    time: document.getElementById("time"),
    players: document.getElementById("players"),
    playerid: document.getElementById("playerid"),

    cash: document.getElementById("cash"),
    bank: document.getElementById("bank"),
    dirty: document.getElementById("dirty"),

    job: document.getElementById("job"),
    duty: document.getElementById("duty"),

    zone: document.getElementById("zone"),
    road: document.getElementById("road"),

    vehicleHud: document.getElementById("vehicleHud"),

    speed: document.getElementById("speed"),

    fuel: document.getElementById("fuel"),
    engine: document.getElementById("engine"),

    gear: document.getElementById("gearDisplay"),

    seatbelt: document.getElementById("seatbelt"),
    lights: document.getElementById("lights"),
    cruise: document.getElementById("cruise"),
    lock: document.getElementById("lock"),

    health: document.getElementById("healthCircle"),
    armor: document.getElementById("armorCircle"),
    hunger: document.getElementById("hungerCircle"),
    thirst: document.getElementById("thirstCircle"),
    stress: document.getElementById("stressCircle"),
    stamina: document.getElementById("staminaCircle")

};

let HudVisible = true;

//======================================
// Helper Functions
//======================================

function showVehicle(show){

    HUD.vehicleHud.style.display = show ? "block" : "none";

}

function setCirclePercent(element,value){

    value = Math.max(0,Math.min(100,value));

    element.style.opacity = (.35 + (value/100)).toFixed(2);

}

function moneyFormat(amount){

    return "$"+Number(amount).toLocaleString();

}

function setActive(element,state){

    if(state){

        element.classList.add("active");

    }else{

        element.classList.remove("active");

    }

}

//======================================
// Receive Messages
//======================================

window.addEventListener("message",(event)=>{

    const data = event.data;

    switch(data.action){

        case "toggleHud":

            HudVisible = data.state;

            document.body.style.display =
                HudVisible ? "block" : "none";

        break;

        case "player":

            HUD.cash.innerHTML =
                moneyFormat(data.cash);

            HUD.bank.innerHTML =
                moneyFormat(data.bank);

            HUD.dirty.innerHTML =
                moneyFormat(data.dirty);

            HUD.job.innerHTML =
                data.job;

            HUD.duty.innerHTML =
                data.duty;

            HUD.playerid.innerHTML =
                data.id;

            HUD.players.innerHTML =
                data.online + "/" + data.maxPlayers;

        break;

    }

});
