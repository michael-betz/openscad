// print with 0.4 mm nozzle, 0.2 mm layer height
$fn=50;


module pen() {
	da = 8.5;
	db = 6.2;
	dc = 4;

	translate([0, 0, 20/2])
		cylinder(h=20, d=da, center=true, $fn=6);
	translate([0, 0, -2.75/2])
		cylinder(h=2.75, d=db, center=true);
	translate([0, 0, -2.75 - 8.4/2])
		cylinder(h=8.4, d2=db, d1=dc, center=true);
	translate([0, 0, -2.75 - 8.4 - 2])
		cylinder(h=4, d=dc, center=true);
}

module flange() {
	difference() {
		cube(size=[18, 30, 2], center=true);
		translate([5, 10, 0])
			cylinder(h=3, d=3.5, center=true);
		translate([5, -10, 0])
			cylinder(h=3, d=3.5, center=true);
	}
}

difference() {
	cylinder(h=34, d=11, center=true);
	translate([0, 0, -4])
		scale(1.08)
			pen();
}

translate([14, 0, 0])
	rotate([90])
		flange();
