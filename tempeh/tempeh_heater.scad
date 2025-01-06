$fn = $preview ? 30 : 100;

wall = 1;
d_inside = 15.5;

// difference() {
// 	cube(size=[20 + 2 * wall, 16 + 2 * wall, 5], center=true);
// }

module inner(wall=0) {
	intersection() {
		translate([0, 0, 15 + 2 * wall])
			cube(size=[20 + 2 * wall, 16 + 2 * wall, 30 + 2 * wall], center=true);
		translate([0, 0, 10])
			cylinder(h=20 + 2 * wall, d1=30 + 2 * wall, d2=d_inside + 2 * wall, center=true);
	}
}

module shell() {
	difference() {
		inner(1);
		inner(0);
		cylinder(h=50, d=d_inside, center=true);
	}

	translate([0, 0, 25]) {
		difference() {
			cylinder(h=10, d=d_inside + 2 * wall, center=true);
			cylinder(h=50, d=d_inside, center=true);
		}
	}
}

difference() {
	shell();
	for (i=[-1, 1]) {
		translate([i * d_inside / 2.05, 0, 25])
			cylinder(h=50, d=2, center=true);
	}
}
