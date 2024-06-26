// Telefunken, Lager-Nr. 30223,
// Fuer Diheptalsockel B12-37

$fn = 80;


// Pin position with angular coordinates
module make_pin() {
	r_pin_circle = 44 / 2;
	alpha = 360 / 14;

	for (i=[0:13])
		rotate([0, 0, (i + 0.5) * alpha])
			translate([0, r_pin_circle, 0])
				children();
}

module contact() {
	rotate([0, 90, 0])
		linear_extrude(1.5, center=true)
			translate([-0.7, -1.25, 0])
				import("spring.svg");
}

module pin() {
	translate([0, 0, -3])
		cylinder(h=6, d1=3, d2=2.25, center=true);

	translate([0, 0, 3])
		cylinder(h=6, d2=3, d1=2.25, center=true);
}

module pocket() {
	// Square section for cable and crimp connection
	translate([0, -3, -5])
		cube(size=[2.0, 2.0, 10.1], center=true);
	// Wider section at the top, for the flat end of the contact
	translate([0, -3.6, 3])
		cube(size=[3.0, 0.8, 10], center=true);
	// Opening for the contact spring
	translate([0, -2.5, 3.5])
		cube(size=[1.2, 3, 7], center=true);
	// Pocket for the little hook to engage in
	translate([0, -3.75, 3.5])
		rotate([-7, 0, 0])
			cube(size=[1, 2, 3], center=true);
}

module pocket2() {
	cylinder(h=20, d=3.4, center=true);
	rotate([-8, 0, 0])
		pocket();
	translate([0, 0, 3.75 + 3])
		cylinder(h=3, d1=3, d2=8, center=true);
}

// cylinder(h=20, d=43, center=true);
// make_pin()
// 	cylinder(h=16, d=2, center=true);

// color("red")
// 	rotate([-5, 0, 0])
// 		translate([0, -3.1, 4])
// 			contact();


// Little cube for fine-tuning the geometry
// intersection() {
// 	difference() {
// 		translate([0, -1, 0])
// 			cube(size=[8, 10, 16], center=true);
// 		translate([0, 0, 0.75])
// 			pocket2();
// 	}
	// translate([-50, 0, 0])
	// 	cube(size=[100, 100, 100], center=true);
// }


// the notched pin in the middle
module central_pin() {
	cylinder(h=20, d=20.5, center=true);
	translate([0, -20.5 / 2, 0])
		cylinder(h=20, d=3, center=true);
}


module socket() {
	difference() {
		cylinder(h=16, d=62, center=true);
		make_pin()
			translate([0, 0, 0.75])
				rotate([0, 0, 180])
					pocket2();
		scale(1.1)
			central_pin();
		cylinder(h=20, d1=10.5, d2=30, center=true);
	}
}

socket();
