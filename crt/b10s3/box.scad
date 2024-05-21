// $fn = 128;
$fn = 32;

include <b10s3.scad>
include <../../roundedcube.scad>

crt_angle = 15;

module pos_crt(s=1.0) {
	translate([0, 0, 65])
		rotate([0, -crt_angle, 0])
			scale(s)
				crt();
}


h = 90;
z = 2.5 + h / 2;

module tube_holder_base() {
	difference() {
		translate([0, 0, z])
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
		tube_holder_base();
		for (i=[-1,1]) {
			translate([0, 40 * i, h + 5])
				cylinder(h=35, d=9, center=true);  //, $fn=6);
			translate([0, 40 * i, 50])
				cylinder(h=150, d=5.25, center=true);
		}
		// Top square nuts
		translate([0, 0, 60])
			cube(size=[8.5, 90, 3], center=true);

		// Bottom square nuts
		translate([0, 0, 10])
			cube(size=[8.5, 90, 3], center=true);

		// bridge cut-out
		roundedcube(size=[100, 60, 62], center=true, radius=15);
	}
}

module plate() {
	difference() {
		roundedcubez(size=[300, 100, 5], center=true, radius=15);
		for (i=[-1,1]) {
			// tube holder holes
			translate([0, 40 * i, 0])
				cylinder(h=10, d=5.25, center=true);
			// socket block holes
			translate([-139, 40 * i, 0])
				cylinder(h=10, d=5.25, center=true);
			// UI board holes
			translate([139, 40 * i, 0])
				cylinder(h=10, d=5.25, center=true);
		}
		pcb();
	}
}

module poly_block(is_top=false) {
	include <../../poly_surface.scad>

	function fct(x, y) = 3 * sin(10 * x + 100) * sin(9 * y + 100) + sin(crt_angle) * x;

	function ftop(x,y) = is_top ? 70 : fct(x, y) - 1;
	function fbottom(x,y) = is_top ? fct(x, y) + 1 : -70;

    poly_surface(-30, 50, -55, 55, $fn, $fn);
}

module tube_holder_cut(is_top=false) {
	intersection() {
		tube_holder_all();
		translate([0, 0, 66])
			poly_block(is_top);

		// Get parametric surface on the top lid
		// if (is_top)
		// 	// rotate([0, crt_angle, 0])
		// 		translate([0, 0, h - 10])
		// 			poly_block(0);
	}
}

// PCB
module pcb() {
	translate([0, 0, 10]) {
		cube(size=[150, 50, 1], center=true);
		translate([0, 0, -10])
			linear_extrude(height=20, center=true)
				rotate([0, 0, 90])
					import("pcb.svg", center=true);
	}
}

module hv_cap() {
	height = 65;
	wall = 3;
	difference(){
		roundedcubez(size=[50, 100, height], center=true, radius=15);

		translate([10 + wall, 0, -wall / 2 - 1])
			roundedcubez(size=[50 + 20, 100 - 25, height - wall + 2], center=true, radius=15);
		translate([60, 0, 0])
			cube(size=[100, 150, 100], center=true);

		for (i=[-1, 1]) {
			// screw holes
			translate([-14, 40 * i, -30])
				cylinder(h=40, d=5.25, center=true);
		}

		// square nut slot
		translate([-14, 0, -25])
			cube(size=[8.5, 90, 3], center=true);
	}
}


module main() {
	tube_holder_cut(1);
	tube_holder_cut(0);
	translate([-125, 0, (60 + 5) / 2])
		hv_cap();
	pos_crt();
	color("green")
		pcb();
	plate();
}


intersection() {
	main();
	// translate([0, 190, 0])
	// 	cube([300, 300, 300], center=true);
}


