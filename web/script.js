// DG-HUD NUI

const hud = document.getElementById("hud");
const vehicleHud = document.getElementById("vehicleHud");

// Status Bars
const health = document.getElementById("health-bar");
const armor = document.getElementById("armor-bar");
const hunger = document.getElementById("hunger-bar");
const thirst = document.getElementById("thirst-bar");
const stress = document.getElementById("stress-bar");
const stamina = document.getElementById("stamina-bar");

// Vehicle
const speed = document.getElementById("speed-value");
const gear = document.getElementById("gear-value");
const fuel = document.getElementById("fuel-value");
const rpm = document.getElementById("rpm-fill");

// Voice
const voiceMode = document.getElementById("voice-mode");
const voiceIcon = document.getElementById("voice-icon");

// Clock
const clock = document.getElementById("clock");

// Update Clock
setInterval(() => {
    const now = new Date();

    clock.innerText =
        now.getHours().toString().padStart(2, "0") +
        ":" +
        now.getMinutes().toString().padStart(2, "0");
}, 1000);

// Listen for Lua Messages
window.addEventListener("message", function (event) {

    const data = event.data;

    switch (data.action) {

        case "toggleHud":

            hud.style.display = data.state ? "flex" : "none";

        break;

        case "status":

            health.style.width = `${data.health}%`;
            armor.style.width = `${data.armor}%`;
            hunger.style.width = `${data.hunger}%`;
            thirst.style.width = `${data.thirst}%`;
            stress.style.width = `${data.stress}%`;
            stamina.style.width = `${data.stamina}%`;

        break;

        case "voice":

            voiceIcon.style.color = data.talking ? "#00ff88" : "#ffffff";

            switch (data.mode) {

                case 1:
                    voiceMode.innerText = "Whisper";
                break;

                case 2:
                    voiceMode.innerText = "Normal";
                break;

                case 3:
                    voiceMode.innerText = "Shouting";
                break;

            }

        break;

        case "vehicleUpdate":

            vehicleHud.style.display = data.show ? "block" : "none";

            if (!data.show) return;

            speed.innerText = data.speed;
            gear.innerText = data.gear === 0 ? "R" : data.gear;
            fuel.innerText = `${data.fuel}%`;

            rpm.style.width = `${data.rpm}%`;

            document
                .getElementById("seatbelt")
                .classList.toggle("active", data.seatbelt);

            document
                .getElementById("cruise")
                .classList.toggle("active", data.cruise);

            if (data.fuel <= 15) {

                fuel.parentElement.classList.add("lowFuel");

            } else {

                fuel.parentElement.classList.remove("lowFuel");

            }

        break;

    }

});
