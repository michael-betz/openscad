$fn=50;

w_batt = 57;
h_batt = 80;
t_batt = 27;

// Make it a multiple of nozzle size
t_wall = 1.2;

h_lid = 6;

// thickness of the top and bottom denim-lined plates
h_plates = 2;


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
    h_box = t_batt + h_lid + 2 * h_plates;
    translate([0, 0, h_lid / 2])
        difference() {
            // outer dimensions of box
            cube(size=[w_batt + 2 * t_wall, h_batt + 2 * t_wall, h_box], center=true);
            // inner dimensions of box
            cube(size=[w_batt, h_batt, h_box + 1], center=true);
            // bottom notch for lid
            // translate([0, 0, (t_wall - h_box - 0.01) / 2])
            //     cube(size=[w_batt + t_wall, h_batt + t_wall, t_wall], center=true);
            // USB holes
            translate([w_batt / 2, 4, 10.5])
                usb_holes();

        }
}


module usb_holes() {
    // cut 2 big USB holes
    for (i = [-1, 1])
        translate([0, i * 18, 3])
            cube(size=[10, 14, 6], center=true);

    // cut middle USB hole
    translate([0, 0, 3])
        cube(size=[10, 9.5, 4], center=true);
}


module pcb_holder(){
    dx = 12.5;
    dy = 4;
    difference() {
        cube(size=[w_batt - 1, h_batt - 1, h_lid], center=true);

        // cavity for PCB
        translate([dx, dy, 0])
            cube(size=[33, 65, 10], center=true);

        translate([dx - 5 - 15, dy, -3 - h_lid / 2])
            cube(size=[10, 100, 10], center=true);

        translate([dx - 16.5, dy, 0])
            cube(size=[3, 58, 10], center=true);
    }

    // pins + spacer
    translate([dx, dy, 0]) {
        corners(26.5, 58.8)
            union() {
                cylinder(d=2.5, h=h_lid, center=true);
                translate([0, 0, 1])
                    cylinder(d=4.5, h=h_lid - 2, center=true);
            }
        // cubes to connect pins to frame
        translate([-0.8, 0, 1])
            corners(28, 63)
                cube(size=[4.2, 5, h_lid - 2], center=true);
    }
}


// batt();
box();

color("blue")
    translate([0, 0, h_lid / 2 + t_batt / 2 + 0.01])
        pcb_holder();
