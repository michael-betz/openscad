$fn=50;

include <roundedcube.scad>


r_corner = 5;

w_batt = 57;
h_batt = 79;
t_batt = 27;

// Make it a multiple of nozzle size
t_wall = 1.8;

// thickness of the PCB holder
pcb_t = 6;

h_pcb = 65;
w_pcb = 33;
pcb_x = w_batt / 2 - w_pcb / 2;
pcb_y = h_batt / 2 - h_pcb / 2;
pcb_z = pcb_t / 2 + t_batt / 2 + 0.01;


// thickness of the top and bottom denim-lined plates
h_plates = 1;
t_denim = 0.6;
plate_z = t_batt / 2 + h_plates / 2 + pcb_t + t_denim;


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
    h_box = t_batt + pcb_t + 2 * h_plates + 3 * t_denim;
    translate([0, 0, pcb_t / 2])
        difference() {
            // outer dimensions of box
            roundedcubez(
                size=[w_batt + 2 * t_wall, h_batt + 2 * t_wall, h_box],
                center=true,
                radius=r_corner
            );
            // inner dimensions of box
            roundedcubez(
                size=[w_batt, h_batt, h_box + 1],
                center=true,
                radius=r_corner / 2
            );
            // bottom notch for lid
            // translate([0, 0, (t_wall - h_box - 0.01) / 2])
            //     cube(size=[w_batt + t_wall, h_batt + t_wall, t_wall], center=true);
            // USB holes
            translate([w_batt / 2, pcb_y, 13.5])
                usb_holes();

        }
}

module usb_holes() {
    // cut 2 big USB holes
    for (i = [-1, 1])
        translate([0, i * 18, 0])
            cube(size=[10, 14, 6], center=true);

    // cut middle USB hole
    translate([0, 0, 0.5])
        cube(size=[10, 9.5, 4], center=true);

    // button hole
    translate([-10, w_batt / 2 + 6, 0.5])
        rotate([90, 0, 0])
            cylinder(h=15, d=4, center=true);

    // side USB hole
    translate([-21, w_batt / 2 + 6, 0])
        cube([8, 15, 3.5], center=true);

    // LED holes
    translate([-16, -30, 10])
        cube(size=[15, 3, 20], center=true);
}


module pcb_holder(){
    difference() {
        roundedcubez(
            size=[w_batt - 1, h_batt - 1, pcb_t],
            center=true,
            radius=r_corner / 2
        );

        // cavity for PCB
        translate([pcb_x, pcb_y, 0])
            cube(size=[w_pcb, h_pcb, 10], center=true);

        // wire channels
        translate([pcb_x - 5 - 15, pcb_y, -3 - pcb_t / 2])
            cube(size=[10, 100, 10], center=true);

        translate([pcb_x - 16.5, pcb_y, 0])
            cube(size=[3, 58, 10], center=true);
    }

    // pins + spacer
    difference() {
        translate([pcb_x, pcb_y, 0]) {
            corners(26.5, 58.8)
                union() {
                    cylinder(d=2.5, h=pcb_t, center=true);
                    translate([0, 0, 1])
                        cylinder(d=4.5, h=pcb_t - 2, center=true);
                }
            // cubes to connect pins to frame
            translate([-1.5, -0.5, 1])
                corners(29, 60)
                    cube(size=[5, 5.0, pcb_t - 2], center=true);
        }
        // remove un-useful corner
        translate([27, 25, 0])
            cube([50, 50, 10], center=true);
    }
}

module denim_plate() {
    difference() {
        roundedcubez(
            size=[w_batt - 2 * t_denim, h_batt - 2 * t_denim, h_plates],
            center=true,
            radius=r_corner / 2
        );
        translate([pcb_x, pcb_y, -10])
            usb_holes();
    }
}


module main() {
    batt();
    box();

    color("blue")
        translate([0, 0, pcb_z])
            pcb_holder();

    color("orange")
        for (z = [plate_z, -plate_z + pcb_t])
            translate([0, 0, z])
                !denim_plate();
}


intersection() {
    main();
    // translate([0, 100, 0])
    //     cube([200, 200, 200], center=true);
}
