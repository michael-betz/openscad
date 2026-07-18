$fn = $preview ? 30 : 100;

include <../roundedcube.scad>

module magnet_holder() {
	difference() {
		cylinder(h=7, d1=6, d2=8.5, center=true);
		translate([0, 0, 6.5 - 3])
			cylinder(h=6, d=7, center=true);
		cylinder(h=8, d=3, center=true);
	}
}


module button() {
	difference() {
		union() {
			cylinder(h=3, d1=6, d2=6, center=true);
			translate([0, 0, 1.5])
				difference() {
					sphere(r=6 / 2);
					translate([0, 0, -5])
						cube(size=[10, 10, 10], center=true);
				}
		}
		cylinder(h=7, d=2.9, center=true);
	}
}

module trigger_clamp() {
	h_clamp = 12;
	color("yellow")
	difference() {
		union() {
			cylinder(h=h_clamp, d=35, center=true);
			// little arm
			translate([0, -20.25, 0])
				roundedcubez([6.5, 20, h_clamp], radius=6.5/2, center=true);
		}
		// zip tie ring
		difference() {
			// outer diameter
			cylinder(h=6, d=36, center=true);
			// inner diameter
			cylinder(h=8, d=36 - 4, center=true);
		}
		// make space for zip tie head
		difference() {
			// outer diameter
			cylinder(h=h_clamp + 1, d=36, center=true);
			cylinder(h=h_clamp + 2, d=32, center=true);
			translate([0, -10, 0])
				cube(size=[50, 50, 20], center=true);
		}

		// big central hole
		cylinder(h=13, d=25.5, center=true);
		// slot for clamping
		cube(size=[40, 1, 40], center=true);
		// hole for carbon stick
		translate([0, -12 - 15, 0])
			cylinder(h=h_clamp + 1, d=4.6, center=true);
	}

	h_spring = 17;
	// h_spring = 9;

	// carbon stick
	// color("black")
	// 	translate([0, -12 - 15, -9 + 17 - h_spring])
	// 		cylinder(h=37, d=2.45, center=true);

	// Magnet holder
	// color("blue")
	// 	translate([0, -12 - 15, 9.5 + 17 - h_spring])
	// 		magnet_holder();

	// spring
	// color("white", alpha=0.3)
	// 	translate([0, -12 - 15, -6 - h_spring / 2])
	// 		cylinder(h=h_spring, d=4.3, center=true);

	// button end-cap
	// color("blue")
	// 	translate([0, -12 - 15, -24.5 + 17 - h_spring])
	// 		rotate([180, 0, 0])
	// 			button();

}


// export
// intersection() {
// 	trigger_clamp();
// 	translate([0, -50, 0])
// 		cube(size=[100, 100, 100], center=true);
// }

// button();

magnet_holder();
