// $fn = 128;
$fn = 32;

include <crt.scad>
include <../../roundedcube.scad>

crt_angle = 10;

module pos_crt(s=1.0) {
	translate([-10, 0, 100])
		rotate([180, 90 - crt_angle, 0])
			scale([s, s, 1])
				crt();
}

h = 90;
z = 2.5 + h / 2;

module tube_holder_base(x_pos=0) {
	difference() {
		translate([x_pos, 0, z])
			roundedcubez(size=[70, 100, h], center=true, radius=15);
		pos_crt(1.05);
	}
}

module tube_holder_mid(x_pos=0) {
	difference() {
		tube_holder_base(x_pos);
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

module tube_holder_back(x_pos=0, is_top=1) {
	difference() {
		tube_holder_base(x_pos);

		translate([x_pos, 0, 0]) {
			translate([0, 0, z - h/4 + (is_top ? 0 : h/2)])
				cube(size=[150, 150, h / 2], center=true);

			translate([-5, 0, h / 2 - 2])
				roundedcubez(size=[50, 100 - 5, h], center=true, radius=15);

			for (i=[-1, 1]) {
				// screw holes
				translate([27, 40 * i, h / 2])
					cylinder(h=h + 10, d=5.25, center=true);

				// bigger holes on top
				translate([27, 40 * i, 40 / 2 + 10 + z])
					cylinder(h=40, d=9, center=true);

				// square nut slot
				for (zp=[10, h / 2 - 5])
					translate([21, 40 * i, zp])
						cube(size=[20, 8.5, 3], center=true);
			}

			translate([27, 0, -20])
				roundedcube(size=[50, 60, 62], center=true, radius=15);
		}
	}
}


module plate() {
	difference() {
		translate([-87, 0, 0])
			roundedcubez(size=[506, 100, 5], center=true, radius=15);
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
	}
}

module main() {
	pos_crt();
	// tube_holder_back(-305, 1);
	tube_holder_back(-305, 0);
	tube_holder_mid();
	// translate([-125, 0, (60 + 5) / 2])
	// 	hv_cap();
	plate();
}


intersection() {
	main();
	translate([0, 150, 0])
		cube([1000, 300, 300], center=true);
}



