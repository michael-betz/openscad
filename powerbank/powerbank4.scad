// for the big one, found in 03/2023

$fn=75;

include <../roundedcube.scad>

// TODO confirm dimension
w_batt = 61;
h_batt = 78;
t_batt = 38;

// Make it a multiple of nozzle size
t_wall = 1.8;

// corner radius
rad = 5.0;

// thickness of the PCB holder
pcb_t = 7;

// PCB position
h_pcb = 72.5;
w_pcb = 27;
pcb_x = w_batt / 2 - w_pcb / 2;
pcb_y = -h_batt / 2 + h_pcb / 2;
pcb_z = pcb_t / 2 + t_batt / 2 + 0.01;

// thickness of the top and bottom denim-lined plates
h_plates = 1.25;
t_denim = 0.75;
plate_z = t_batt / 2 + h_plates / 2 + pcb_t + t_denim;

module batt() {
    // color("green") {
    //     translate([12.0, 4, t_batt / 2 + 3])
    //         cube(size=[32.5, 65, 6], center=true);
    // }
    color("grey")
        cube(size=[w_batt, h_batt, t_batt], center=true);
}


module box() {
    h_box = t_batt + pcb_t + 2 * h_plates + 4 * t_denim;
    translate([0, 0, pcb_t / 2])
        difference() {
            // outer dimensions of box
            roundedcubez(size=[w_batt + 2 * t_wall + rad / 2, h_batt + 2 * t_wall + rad / 2, h_box], radius=rad, center=true);
            // inner dimensions of box
            roundedcubez(size=[w_batt + rad / 2, h_batt + rad / 2, h_box + 1], radius=rad, center=true);
            // bottom notch for lid
            // translate([0, 0, (t_wall - h_box - 0.01) / 2])
            //     cube(size=[w_batt + t_wall, h_batt + t_wall, t_wall], center=true);
            // USB holes
            translate([pcb_x, pcb_y, pcb_z - pcb_t / 2])
                usb_holes();
        }
}


module usb_holes() {
    translate([33 / 2, 72 / 2 - 20, 0]) {
        // cut 2 big USB holes
        for (i = [-1, 1])
            translate([0, i * 10, 0])
                cube(size=[10, 14, 7], center=true);

        // cut USB-C hole
        translate([0, -27.5, -1.25])
            cube(size=[10, 11, 4], center=true);

        // apple hole
        translate([0, -43, 0])
            cube(size=[10, 10, 7], center=true);

        // button hole
        translate([-19, -53, -2])
            rotate([90, 0, 0])
                cylinder(h=10, d=4, center=true);

        // LED holes
        translate([-16, -53 + 9, 10])
            cube(size=[15, 3, 20], center=true);
    }
}


module pcb_holder() {
    difference() {
        roundedcubez(size=[w_batt + rad / 2 - 1, h_batt + rad / 2 - 1, pcb_t], radius=rad, center=true);

        // cavity for PCB
        translate([pcb_x + 5, pcb_y - 5, 0])
            cube(size=[w_pcb + 10, h_pcb + 10, 10], center=true);
    }
}

module denim_plate() {
    difference() {
        roundedcubez(size=[w_batt + rad / 2 - 2 * t_denim, h_batt + rad / 2 - 2 * t_denim, h_plates], radius=rad, center=true);
        translate([pcb_x, pcb_y, -10])
            usb_holes();
    }
}


intersection() {
    union() {
        box();

        color("red")
            batt();

        color("orange")
            for (z = [plate_z, -plate_z + pcb_t])
                translate([0, 0, z])
                    !denim_plate();

        color("blue")
            translate([0, 0, pcb_z])
                pcb_holder();
    }
    translate([0, 0, -75])
        cube([200, 200, 200], center=true);
}
