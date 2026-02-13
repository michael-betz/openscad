$fn = $preview ? 30 : 100;
include <roundedcube.scad>


translate([0, 2.15 / 2, 1.9 / 2 - 0.9 / 2])
	cube_(size=[2, 2.15, 0.9]);
translate([0, 2.25 / 2 + 2.15 - 3.5, 0])
	cube_(size=[4.7, 2.25, 1.9]);

color("yellow")
	for (i=[-1, 1])
		translate([i * 1.7 / 2, 0, -0.3])
			cylinder(h=0.3, d=0.5);
