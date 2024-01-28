$fn = 75;

module valve() {
	difference() {
		cylinder(h=20, d=6.6, center=true);
		translate([-5 - 3.3 + 1.05, 0 ,0])
			cube([10, 10, 21], center=true);
	}
	for (a=[0:60:350]) {
		rotate([0, 0, a]) {
			translate([-12, 0, 0])
				rotate([0, 0, 30])
					cylinder(h=20, d=10.5, center=true, $fn=6);
			rotate([0, 0, 30])
				translate([-20.5, 0, 0])
					cylinder(h=20, d=10, center=true);

		}
	}
}

difference(){
	union() {
		cylinder(d=38, h=5,  center=true);
		translate([0, 0, -5])
			cylinder(d=13, h=8,  center=true);
	}
	valve();
}
