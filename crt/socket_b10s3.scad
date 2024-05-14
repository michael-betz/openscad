$fn = 30;

module make_pin() {
	r_pin_circle = 73 / 2;
	alpha = 26.6;

	for (j=[-1,1])
		for (i=[-2:1:2])
			translate([r_pin_circle * sin(i * alpha), j * r_pin_circle * cos(i * alpha), 0])
				children();
}

cylinder(h=20, d=43, center=true);
make_pin()
	cylinder(h=16, d=2, center=true);
