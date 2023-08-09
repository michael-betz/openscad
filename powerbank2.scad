$fn=50;

w_batt = 57;
h_batt = 80;
t_batt = 27;

t_wall = 2.0;

module batt() {
    color("green") {
        translate([11.5, 0, t_batt / 2 + 3])
            cube(size=[33, 65, 6], center=true);
    }
    color("grey")
        cube(size=[w_batt, h_batt, t_batt], center=true);
}

module box() {
    difference() {
        cube(size=[w_batt + 2 * t_wall, h_batt + 2 * t_wall, t_batt + 2 * t_wall], center=true);
        translate([0, 0, 0])
            cube(size=[w_batt, h_batt, t_batt + 5], center=true);
        translate([0, 0, (t_batt + t_wall + 0.01) / 2])
            cube(size=[w_batt + t_wall, h_batt + t_wall, t_wall], center=true);
        translate([0, 0, -(t_batt + t_wall + 0.01) / 2])
            cube(size=[w_batt + t_wall, h_batt + t_wall, t_wall], center=true);
    }
}

h_lid = 6 + t_wall;
module lid(){
    difference() {
        cube(size=[w_batt + 2 * t_wall, h_batt + 2 * t_wall, h_lid], center=true);

        // cavity for PCB
        translate([12.5, 0, -2])
            cube(size=[33, 65, 10], center=true);

        // cut 2 big USB holes
        for (i = [-1, 1])
            translate([30, i * 18, -1.1])
                cube(size=[10, 14, 6], center=true);

        // cut middle USB hole
        translate([30, 0, -1.6])
            cube(size=[10, 9.5, 5], center=true);
    }

    translate([12.5, 0, -1.5]) {
        corners(26.5, 58.8)
            union() {
                cylinder(d=2.5, h=5, center=true);
                translate([0, 0, 2])
                    cylinder(d=5, h=5, center=true);
            }
    translate([0, 0, 2])
        corners(30, 62)
            cube(size=[6, 5, 5], center=true);
    }
}

module corners(w=10, h=5) {
    for (i = [-1, 1])
        for (j = [-1, 1])
            translate([w / 2 * i, h / 2 * j, 0]) children(0);
}


// batt();
box();

translate([0, 0, 17.6])
    difference() {
        lid();
        // notch
        translate([0, 0, t_wall / 2 + h_lid / 2 - 1.5])
            cube(size=[w_batt + t_wall, h_batt + t_wall, t_wall], center=true);
    }
