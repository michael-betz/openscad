$fn = $preview ? 21 : 71;

module main() {
	difference() {
		body();
		feet(4.2, 35);
	}
	// feet(3);
}

module body() {
	r = 3;
	d_b = 84.0;
	t = 7;
	minkowski() {
		difference() {
			cylinder(h=30, d=d_b + 2 * t - 2 * r, center=true);
			translate([0, 0, 15 + t])
				cylinder(h=30, d=d_b + 2 * r, center=true);
			translate([0, 0, t])
				sphere(d=d_b + 2 * r);
		}
		sphere(r=r);
	}
}

module feet(d=3, h=150) {
	for (j=[0:60:360])
		// color(c=[j / 360, 0, 1 - j / 360])
			translate([0, 0, -10])
				rotate([-30, 0, j])
					translate([0, 0, -53])
							foot(d, h);
}

module foot(d, h) {
	for (i=[-1, 1])
		rotate([7, 16.5 * i, 0])  // align top ends
			translate([i * 26, 0, 75 - h / 2])  // align holes in holder
				cylinder(h=h, d=d, center=true);
}

intersection() {
	main();
	// rotate([0, 0, 2])
	// 	translate([0, 200, 0])
	// 		cube(size=[400, 400, 400], center=true);
}
