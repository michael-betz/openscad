$fn = $preview ? 21 : 71;

d_pin = 4.2;

// translate([0, 0, 175 / 2])
// 	%cylinder(d=691 / PI, h=175, center=true);


module pins() {
	translate([0, 0, 165])
		for (j=[0:360 / 7:360])
			for (s=[-1, 1])
				rotate([s * 7.3, -3.5, j])
					translate([112.5 / 2, 0, -254 / 2])
						cylinder(h=254, d=d_pin, center=true);
}

module top_ring() {
	difference() {
		cylinder(h=25, d=125, center=true);
		cylinder(h=27, d=100, center=true);
		translate([0, 0, 17])
			cube(size=[110, 70, 20], center=true);
	}
}


module bottom_ring() {
	difference() {
		union() {
			translate([0, 0, -1.5])
				cylinder(h=3, d=162, center=true);
			translate([0, 0, 5])
				cylinder(h=10, d=152, center=true);
		}
		cylinder(h=25, d=132, center=true);
	}
}

difference() {
	union() {
		// translate([0, 0, 160])
			// top_ring();
		bottom_ring();
	}
	pins();
}

// pins();
