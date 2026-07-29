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
