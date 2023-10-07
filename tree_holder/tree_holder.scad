$fn = $preview ? 21 : 71;

include <../roundedcube.scad>

module tree() {
	rotate([0, 90, 0])
		cylinder(h=1000, d=20, center=true);
}

module holder() {
	difference() {
		roundedcube(size=[50, 50, 30], center=true, radius=5);
		rotate([0, 90, 0])
			cylinder(h=100, d=23, center=true);
		for (i=[-1,1])
			translate([0, i * 15, 0]) {
				cylinder(h=26, d=4.5, center=true);
				translate([0, 0, -15])
					cylinder(h=12, d=10, center=true);
			}
		spikes();
	}
}

module holder_cut(is_top) {
	intersection() {
		holder();
		translate([0, 0, 50 * (is_top ? 1 : -1)])
			cube(size=[100, 100, 100], center=true);
	}
}

module spikes() {
	for (j=[-1,1])
		for (i=[-3, -2, -1, 1, 2, 3])
			translate([i * 14, j * 32, -60])
				rotate([j * 15, -i * 7, 0])
					cylinder(h=150, d=3.5, center=true);
}

// color("white")
// 	tree();

// color("red")
// 	spikes();

// holder_cut(false);
holder_cut(true);

// translate([0, 0, -120])
// 	cube([150, 120, 5], radius=5, center=true);
