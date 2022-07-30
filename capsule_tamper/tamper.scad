$fn=100;

w_cube = 50;

module bottom() {
	translate([0, 0, 2])
		difference() {
			cube([w_cube, w_cube, 4], center=true);
			cube([w_cube - 4.5, w_cube - 4.5, 5], center=true);
		}
	difference() {
		translate([0, 0, -15])
			cube([w_cube, w_cube, 30], center=true);
		translate([0, 0, -11.9])
			cylinder(h=24, d2=30, d1=26, center=true);
		cylinder(h=70, d=26, center=true);
	}
}

module cone(add=0.0) {
	translate([0, 0, 14])
		cylinder(h=30, d2=55 + add, d1=27 + add, center=true);
}

module top_a() {
	difference() {
		cone(0);
		scale([1, 1, 1.001])
			cone(-2);
	}
}

module top_b() {
	difference() {
		translate([0, 0, 2])
			cube([w_cube - 5, w_cube - 5, 4], center=true);
		cone(0.25);
		cylinder(h=4, d=37.5, center=true);
	}
}

module tamper() {
	cylinder(d1=25, d2=23, h=5);
	difference() {
		cylinder(d=10, h=45);
		translate([0, 0, 37])
			rotate_extrude()
				translate([13, 0, 0])
					circle(d=19);
	}
}

top_a();
top_b();
bottom();
tamper();
