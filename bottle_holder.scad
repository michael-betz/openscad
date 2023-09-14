$fn = $preview ? 21 : 71;

d_pin = 4.2;

module main() {
	difference() {
		body();
		feet(d_pin, 35);
	}
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

module clip_p() {
	clip_t()
		scale([1, 0.75, 1])
			cylinder(h=10, d=d_pin * 2 + 1, center=true);
}

module clip_n() {
	clip_t()
		for (i=[-1, 1])
			translate([i * d_pin / 2.2, 0, 0])
				rotate([0, i * 3, 0])
					cylinder(h=21, d=d_pin, center=true);
}

module clip_t() {
	for (j=[0:60:360])
		rotate([0, 0, j])
			translate([0, 55, 5])
				rotate([15, 0, 0])
					children();
}

module clips_plate() {
	difference() {
		union() {
			translate([0, 0, 1])
				cylinder(h=2, r=62, center=true);
					clip_p();
		}
		clip_n();
		cylinder(h=5, r=53, center=true);
		translate([0, 0, -50])
			cube([200, 200, 100], center=true);
	}
}

// intersection() {
	// main();
// 	// rotate([0, 0, 2])
// 	// 	translate([0, 200, 0])
// 	// 		cube(size=[400, 400, 400], center=true);
// }

// feet(3);

// clip();

clips_plate();
