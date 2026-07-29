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
// Vehicle HUD
//======================================

function updateVehicle(data){

    showVehicle(data.show);

    if(!data.show){
        return;
    }

    // Speed
    HUD.speed.innerHTML = data.speed;

    // Gear
    if(data.gear == 0){

        HUD.gear.innerHTML = "R";

    }else if(data.gear == 1 && data.speed == 0){

        HUD.gear.innerHTML = "P";

    }else{

        HUD.gear.innerHTML = data.gear;

    }

    // Fuel

    HUD.fuel.innerHTML = data.fuel + "%";

    if(data.fuel <= 15){

        HUD.fuel.classList.add("lowFuel");

    }else{

        HUD.fuel.classList.remove("lowFuel");

    }

    // Engine

    HUD.engine.innerHTML = Math.floor(data.engine) + "%";

    HUD.engine.classList.remove(
        "engineGood",
        "engineMedium",
        "engineBad"
    );

    if(data.engine >= 75){

        HUD.engine.classList.add("engineGood");

    }else if(data.engine >= 40){

        HUD.engine.classList.add("engineMedium");

    }else{

        HUD.engine.classList.add("engineBad");

    }

    // Icons

    setActive(HUD.seatbelt,data.seatbelt);

    setActive(HUD.cruise,data.cruise);

    setActive(HUD.lights,data.lights);

    setActive(HUD.lock,data.lock);

}

//======================================
// Receive Messages (Dispatcher)
//======================================

window.addEventListener("message",(event)=>{

    const data = event.data;

    if(!data.action) return;

    switch(data.action){

        case "toggleHud":

            UI.setVisible(data.state);

        break;

        case "theme":

            UI.setTheme(data.theme);

        break;

        case "player":

            updatePlayer(data);

        break;

        case "status":

            updateStatus(data);

        break;

        case "voice":

            updateVoice(data);

        break;

        case "compass":

            updateCompass(data);

        break;

        case "vehicleUpdate":

            updateVehicle(data);

        break;

    }

});

//======================================
// DG-HUD UI Manager
//======================================

const UI = {

    visible: true,

    vehicle: false,

    theme: "purple",

    setVisible(state){

        this.visible = state;

        document.body.style.display =
            state ? "block" : "none";

    },

    setVehicle(state){

        this.vehicle = state;

        HUD.vehicleHud.style.display =
            state ? "block" : "none";

    },

    setTheme(theme){

        this.theme = theme;

        document.body.className = "";

        document.body.classList.add(
            "theme-" + theme
        );

    }

};
