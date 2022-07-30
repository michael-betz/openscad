$fn=50;

d_bottle = 25.3;
size = 0.5;

module oiladdin() {
	difference() {
		union() {
			translate([0, 0, -20]) cylinder(
				h=50,
				d1=d_bottle * 0.9,
				d2=d_bottle,
				center=true
			);
			scale(size) translate([-47.5, 115.5, 0]) import("LAMP_filled.stl");
		}
		scale(size) union() {
			translate([0, 0, 61]) rotate([78, 0, 0]) cylinder(r=4, h=190);
			translate([0, -15, 82]) rotate([0, 90, 0]) cylinder(d=20, h=50, center=true);
			translate([0,  30, 55]) rotate([0, 90, 0]) cylinder(d=20, h=50, center=true);
			translate([0, -30, 45]) rotate([0, 90, 0]) cylinder(d=20, h=50, center=true);
			translate([0, 0, -170]) cylinder(r=5, h=235);
		}
	}
}

// intersection() {
// 	oiladdin();
	// translate([350, 0, 0]) cube(size=[700, 700, 700], center=true);  	// left side
	// translate([-350, 0, 0]) cube(size=[700, 700, 700], center=true);		// right side
// }

// pin (need 3)
scale(size) translate([0, -30, 45]) rotate([0, 90, 0]) cylinder(h=48, d=18, center=true);
