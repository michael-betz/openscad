$fn = $preview ? 30 : 100;

d_circle = 26.0;
d_pin = 1.0;
N_PIN = 15;


// Pin position with angular coordinates
module make_pin() {
	alpha = 360 / N_PIN;

	for (i=[0:N_PIN])
		rotate([0, 0, i * alpha])
			translate([0, d_circle / 2, 0])
				children();
}

module singlePinShape() {
	translate([1.25 - 1.9 / 2, 0, 0.01])
		difference() {
			union() {
				translate([0, 0, -15])
					cube([2.5, 2.5, 30], center=true);
				translate([0, 0, +1 - 7])
					cube([2.5, 3.5, 2], center=true);
				translate([0, 0, -15 - 8.5])
					cube([3.5, 3.5, 30], center=true);
			}
			translate([3 - 2.5/2 + 1.9 , 0, 15 - 3])
				cube([6, 6, 30], center=true);
		}
}

// -----------------------
//  Test piece for 1 pin
// -----------------------
// difference() {
// 	translate([0, 0, -16 / 2 - 0.1])
// 		cube(size=[6, 6, 16], center=true);
// 	singlePinShape();
// }

// -----------------------
//  B7S2 socket
// -----------------------
difference() {
	translate([0, 0, -8])
		cylinder(h=16, d=35, center=true);
	make_pin()
		singlePinShape();

	cylinder(h=40, d=15, center=true);
}
