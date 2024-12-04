$fn = $preview ? 30 : 100;

module shaft(h=6) {
	difference() {
		cylinder(h=h, d=4.2, center=true);
		translate([1 + 2 - 0.3, 0, 0])
			cube([2, 10, h + 1], center=true);
	}
}

difference() {
	h_shaft = 13;
	union() {
		translate([0, 0, -h_shaft / 2])
			cylinder(h=h_shaft, d1=10, d2=15, center=true);
	}
	translate([0, 0, -h_shaft / 2])
		shaft(h_shaft + 1);
	translate([0, 0, -2])
		cylinder(h=4.1, d=11.75, center=true, $fn=6);
}
