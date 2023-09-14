$fn=300;

module endcap() {
	difference() {
		union() {
			cylinder(h=3, r=109 / 2);
			cylinder(h=10, r=103 / 2);
		};
		translate([0, 0, -10]) cylinder(h=30, r=6.5 / 2);
		translate([0, 0, 4]) cylinder(h=6.5, r=12.5 / 2, $fn=6);
		translate([0, 0, 3]) cylinder(h=2, r=20 / 2);
		translate([60, 0, 4]) rotate([0, -90, 0]) cylinder(h=120, r=2 / 2);
		translate([0, 60, 4]) rotate([90, -90, 0]) cylinder(h=120, r=2 / 2);
	}
}

intersection() {
	endcap();
	// translate([-100, 0, -100]) cube(size=[200, 200, 200], center=false);
}

