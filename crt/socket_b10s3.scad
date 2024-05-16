$fn = 60;

module make_pin() {
	r_pin_circle = 28.0;
	alpha = 26.75;

	for (j=[-1,1])
		for (i=[-2:1:2])
			translate([r_pin_circle * sin(i * alpha), j * r_pin_circle * cos(i * alpha), 0])
				children();
}

module make_pin2() {
	for (i=[-1, 1])
		for (j=[-1,1]) {
			translate([0, 28 * j, 0])
				children();

			translate([12.5 * i, 25.0 * j, 0])
				children();

			translate([22.53 * i, 16.6 * j, 0])
				children();
		}
}

module contact() {
	rotate([0, 90, 0])
		linear_extrude(1.5, center=true)
			translate([-0.7, -1.25, 0])
				import("spring.svg");
}

module pin() {
	translate([0, 0, -3])
		cylinder(h=6, d1=3, d2=2.25, center=true);

	translate([0, 0, 3])
		cylinder(h=6, d2=3, d1=2.25, center=true);
}

module pocket() {
	translate([0, -2.8, 0])
		cube(size=[1.8, 1.4, 10], center=true);
	translate([0, -2, 2])
		cube(size=[2.75, 3, 4], center=true);

	// translate([0, -1.0, -2.5])
	// 	cube(size=[3, 1.5, 4], center=true);
	// translate([0, -1.6 - 0.6, 0.6])
	// 	cube(size=[1, 2, 1], center=true);
}

// cylinder(h=20, d=43, center=true);
// make_pin()
// 	cylinder(h=16, d=2, center=true);

// color("red")
// 	rotate([-5, 0, 0])
// 		translate([0, -3.1, 4])
// 			contact();

intersection() {
	difference() {
		cube(size=[8, 9, 8], center=true);
		cylinder(h=10, d=3.4, center=true);
		rotate([-5, 0, 0])
			pocket();
		translate([0, 0, 3.75])
			cylinder(h=3, d1=3, d2=8, center=true);
	}
	// translate([50, 0, 0])
	// 	cube(size=[100, 100, 100], center=true);
}

// pin();

// cylinder(h=20, d=10.5, center=true);
// translate([0, -5.5, 0])
// 	cylinder(h=20, d=2, center=true);
// translate([0, -4.5, 0])
// 	cube(size=[2, 2, 20], center=true);


// color("red")
// 	make_pin()
// 		cylinder(h=16, d=3, center=true);

// make_pin2()
// 	cylinder(h=16, d=3, center=true);
