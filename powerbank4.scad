// for the big one, found in 03/2023

$fn=50;

w_batt = 61;
h_batt = 80;
t_batt = 39;

// Make it a multiple of nozzle size
t_wall = 1.2;

// thickness of the PCB holder
pcb_h = 7;

// PCB position
pcb_x = 13.6;
pcb_y = -3.01;
pcb_z = pcb_h / 2 + t_batt / 2 + 0.01;

// thickness of the top and bottom denim-lined plates
h_plates = 1;
t_denim = 1;
plate_z = t_batt / 2 + h_plates / 2 + pcb_h + t_denim;

module corners(w=10, h=5) {
    for (i = [-1, 1])
        for (j = [-1, 1])
            translate([w / 2 * i, h / 2 * j, 0]) children(0);
}


module batt() {
    // color("green") {
    //     translate([12.0, 4, t_batt / 2 + 3])
    //         cube(size=[32.5, 65, 6], center=true);
    // }
    color("grey")
        cube(size=[w_batt, h_batt, t_batt], center=true);
}


module box() {
    h_box = t_batt + pcb_h + 2 * h_plates + 4 * t_denim;
    translate([0, 0, pcb_h / 2])
        difference() {
            // outer dimensions of box
            cube(size=[w_batt + 2 * t_wall, h_batt + 2 * t_wall, h_box], center=true);
            // inner dimensions of box
            cube(size=[w_batt, h_batt, h_box + 1], center=true);
            // bottom notch for lid
            // translate([0, 0, (t_wall - h_box - 0.01) / 2])
            //     cube(size=[w_batt + t_wall, h_batt + t_wall, t_wall], center=true);
            // USB holes
            translate([pcb_x, pcb_y, pcb_z - pcb_h / 2])
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
        translate([-17, -53, 0])
            rotate([90, 0, 0])
                cylinder(h=10, d=5, center=true);

        // LED holes
        translate([-16, -53 + 9, 10])
            cube(size=[15, 3, 20], center=true);
    }
}


module pcb_holder() {
    difference() {
        cube(size=[w_batt - 1, h_batt - 1, pcb_h], center=true);

        // cavity for PCB
        translate([pcb_x, pcb_y, 0])
            cube(size=[33, 73, 10], center=true);
    }
}

module denim_plate() {
    difference() {
        cube(size=[w_batt - 2 * t_denim, h_batt - 2 * t_denim, h_plates], center=true);
        translate([pcb_x, pcb_y, -10])
            usb_holes();
    }
}


intersection() {
    union() {
        // batt();
        box();

        // color("orange")
        //     for (z = [plate_z, -plate_z + pcb_h])
        //         translate([0, 0, z])
        //             denim_plate();

        // color("blue")
        //     translate([0, 0, pcb_z])
        //         pcb_holder();
    }
    // translate([0, 100, 0])
    //     cube([200, 200, 200], center=true);
}
