$fn = 128;
// $fn = 32;

include <b10s3.scad>
include <../roundedcube.scad>

crt_angle = 15;

module pos_crt(s=1.0) {
	translate([0, 0, 65])
		rotate([0, -crt_angle, 0])
			scale(s)
				crt();
}


h = 110;
z = 2.5 + h / 2;
x = 10;

module tube_holder_base() {
	difference() {
		translate([x, 0, z])
			roundedcubez(size=[60, 100, h], center=true, radius=15);
		pos_crt(1.05);
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
		tube_holder_base();
		for (i=[-1,1]) {
			translate([x, 40 * i, h - 12 + 7])
				cylinder(h=35, d=9, center=true);  //, $fn=6);
			translate([x, 40 * i, 50])
				cylinder(h=150, d=5.25, center=true);
		}
		// Square nuts
		translate([x, 0, 62])
			cube(size=[8.5, 90, 3], center=true);

		translate([x, 0, 10])
			cube(size=[8.5, 90, 3], center=true);

		// bridge cut-out
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

module poly_block(is_top=false) {
	include <../poly_surface.scad>

	function fct(x, y) = 3 * sin(10 * x - 10) * sin(9 * y + 100) + sin(crt_angle) * x;

	function ftop(x,y) = is_top ? 70 : fct(x, y) - 1;
	function fbottom(x,y) = is_top ? fct(x, y) + 1 : -70;

    poly_surface(-30, 50, -55, 55, 100, 100);
}

module tube_holder_cut(is_top=false) {
	intersection() {
		tube_holder_all();
		translate([0, 0, 66])
			poly_block(is_top);
		if (is_top)
			// rotate([0, crt_angle, 0])
				translate([0, 0, h - 10])
					poly_block(0);
	}
}

// PCB
// color("green")
// 	translate([0, 0, 5])
// 		cube(size=[150, 50, 1], center=true);

// pos_crt();

// intersection() {
// 	union() {
		// tube_holder_cut(1);
		tube_holder_cut(0);
// 	}
// 	translate([0, -10, 0])
// 		cube([100, 100, 500], center=true);
// }

// plate();

// tube_holder_all();
