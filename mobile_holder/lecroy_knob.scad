$fn = 64;


module roundRec(r_inner=6, x_block=1, y_block=1, step=22.5, h=10) {
	for (angle=[-180: step: 180])
		rotate([0, 0, angle])
			translate([r_inner, 0, 6])
				cube(size=[x_block, y_block, h], center=true);
}

module bulk() {
	roundRec(4.8, 1, 1);
	cylinder(h=11, d1=11, d2=9.5, center=false);
}


difference() {
	bulk();
	translate([0, 0, -5])
		difference() {
			cylinder(d=5.9, h=15, center=false);
			translate([0, 3 + 2, 10])
				cube(size=[6, 6, 20], center=true);
		}
	intersection() {
		translate([0, 0, -1])
			roundRec(5.9/2, x_block=1, y_block=1.75, step=45, h=11);
			translate([0, -8.7, 0])
				cube(size=[20, 20, 20], center=true);
	}
}

// roundRec();
