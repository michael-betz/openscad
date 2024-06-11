$fn = 500;

difference() {
	union() {
		translate([-2.28, -7.43, -4.0])
			linear_extrude(4.0)
				import("clock_gear.svg");
		translate([0, 0, -1.5/2])
			cylinder(h=1.5, d=6.0, center=true);
	}
	translate([0, 0, -2])
		cylinder(h=6, d=2.6, center=true);
}
