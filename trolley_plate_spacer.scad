$fn=32;

include <roundedcube.scad>


difference() {
	roundedcubez(size=[15, 15, 75], center=true, radius=5);
	for (i=[-1, 1])
		translate([0, 0, (75 / 2 - 9) * i])
			cylinder(h=30, d=4.7, center=true);
}
