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
