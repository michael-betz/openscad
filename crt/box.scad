$fn = 128;

include <b10s3.scad>
include <../roundedcube.scad>

module pos_crt(s=1.0) {
	translate([0, 0, 65])
		rotate([0, -15, 0])
			scale(s)
				crt();
}


h = 100;
z = 2.5 + h / 2;
x = 10;

module tube_holder_base() {
	difference() {
		translate([x, 0, z])
			roundedcubez(size=[60, 100, h], center=true, radius=15);
		pos_crt(1.075);
	}
}

module tube_holder(is_top=false) {
	intersection() {
		tube_holder_base();
		rotate([0, -15, 0])
			translate([15, 0, 18 + (is_top ? 92 : 0)])
				cube(size=[100, 110, 90], center=true);
	}
}

module tube_holder_all() {
	difference() {
		union() {
			tube_holder(0);
			tube_holder(1);
		}
		for (i=[-1,1]) {
			translate([x, 40 * i, 75])
				cylinder(h=150, d=5.25, center=true);
			translate([x, 40 * i, h - 12 + 7])
				cylinder(h=35, d=9, center=true);  //, $fn=6);
		}
		roundedcube(size=[100, 60, 60], center=true, radius=15);
	}
}

module plate() {
	difference() {
		roundedcubez(size=[300, 100, 5], center=true, radius=15);
		for (i=[-1,1])
			translate([x, 40 * i, 0])
				cylinder(h=10, d=7, center=true);
	}
}

// PCB
color("green")
	translate([0, 0, 5])
		cube(size=[150, 50, 1], center=true);

pos_crt();

// intersection() {
	tube_holder_all();
	// translate([60, 0, 0])
	// 	cube([100, 100, 500], center=true);
// }

plate();
