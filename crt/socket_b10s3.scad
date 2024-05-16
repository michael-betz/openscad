$fn = 60;

module make_pin() {
	r_pin_circle = 73 / 2;
	alpha = 26.6;

	for (j=[-1,1])
		for (i=[-2:1:2])
			translate([r_pin_circle * sin(i * alpha), j * r_pin_circle * cos(i * alpha), 0])
				children();
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
	difference() {
		translate([0, -2, 0])
			cube(size=[2.2, 2, 10], center=true);
		translate([0, -1.0, -3])
			cube(size=[2, 1.5, 4], center=true);
	}
	translate([0, -1.6 - 0.6, 0.6])
		cube(size=[1, 2, 1], center=true);
	cylinder(h=10, d=3, center=true);

	translate([0, 0, 3.75])
		cylinder(h=3, d1=3, d2=8, center=true);
}

// cylinder(h=20, d=43, center=true);
// make_pin()
// 	cylinder(h=16, d=2, center=true);

// color("red")
// 	translate([0, -2.85, 4])
// 		contact();


intersection() {
	difference() {
		cube(size=[8, 8, 8], center=true);
		pocket();
	}
	// translate([50, 0, 0])
	// 	cube(size=[100, 100, 100], center=true);
}

// pin();
