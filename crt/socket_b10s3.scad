$fn = 30;

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

cylinder(h=20, d=10.5, center=true);
translate([0, -5.5, 0])
	cylinder(h=20, d=2, center=true);
translate([0, -4.5, 0])
	cube(size=[2, 2, 20], center=true);


color("red")
	make_pin()
		cylinder(h=16, d=3, center=true);

// make_pin2()
// 	cylinder(h=16, d=3, center=true);
