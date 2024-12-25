$fn = $preview ? 30 : 100;

d_circle = 26.0;
d_pin = 1.0;
N_PIN = 15;


// Pin position with angular coordinates
module make_pin() {
	alpha = 360 / N_PIN;

	for (i=[0:N_PIN])
		rotate([0, 0, i * alpha])
			translate([0, d_circle / 2, 0])
				children();
}

difference() {
	cylinder(h=10, d=35, center=true);
	translate([0, 0, 5])
		make_pin()
			cylinder(h=12, d=d_pin * 1.2, center=true);

	translate([0, 0, -5])
		make_pin()
			cylinder(h=12, d=3, center=true);

	cylinder(h=20, d=15, center=true);
}
