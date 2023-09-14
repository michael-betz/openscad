$fn=200;

w_proj = 116.5;
h_proj = 43;
funnel_offs = -22;
w_wall = 2;
d_fan = 93;

module fan_bracket() {
	difference() {
		union() {
			cylinder(h=5, d=d_fan + 2 * w_wall, center=true);
			cube(size=[d_fan, d_fan, 5], center=true);
		}
		cylinder(h=5 + 1, d=d_fan, center=true);
		for (i=[1, -1])
			for (j=[1, -1])
				translate([i * 42, j * 42])
					cylinder(h=5 + 1, d=4.5, center=true);
	}
}

h_cyl = 50;

module funnel_inside() {
	intersection() {
		translate([0, 0, -11])
			cylinder(h=h_cyl + 22.1, d1=65, d2=d_fan, center=true);
		scale([2.5, 1, 1])
			translate([0, -4.8, 7])
				rotate([-3, 0, 0])
					rotate([0, 0, 45])
						cylinder(h=2 * h_cyl, d1=31 * sqrt(2), d2=180, center=true, $fn=4);
	}
}

module funnel() {
	difference() {
		translate([0, 0, -11])
			cylinder(h=h_cyl + 22, d1=65 + w_wall * 2, d2=d_fan + w_wall * 2, center=true);
		funnel_inside();
	}
}

module funnel_b() {
	translate([0, 0, h_cyl / 2 + 2])
		fan_bracket();
	funnel();
}

module funnel_rot() {
	translate([funnel_offs, 16, 35])
		rotate([-23, 0, 0])
			funnel_b();
}

module funnel_cut() {
	difference() {
		funnel_rot();
		// cut away pro_bracket
		translate([0, 0, - 5])
			cube(size=[w_proj + 2 * w_wall, h_proj + 2 * w_wall, 15 + 10], center=true);

		// cut away side
		translate([0, -98.5, 0])
			cube(size=[150, 150, 120], center=true);

		// cut away bottom
		translate([0, 0, -37.5])
			cube(size=[150, 150, 60], center=true);
	}
}

module pro_bracket() {
	difference() {
		cube(size=[w_proj + 2 * w_wall, h_proj + 2 * w_wall, 15], center=true);
		translate([0, 0, -w_wall])
			cube(size=[w_proj, h_proj, 15], center=true);
		translate([funnel_offs, 16, 35])
			rotate([-23, 0, 0])
				funnel_inside();
	}
}


intersection() {
	union() {
		funnel_cut();
		// pro_bracket();
	}
	// translate([178, 0, 0])
	// 	cube(size=[400, 400, 400], center=true);
}
