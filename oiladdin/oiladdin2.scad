$fn=50;

d_bottle = 25.4;
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
			translate([0, 0, 61]) rotate([78, 0, 0]) cylinder(r1=7, r2=5, h=175);
			translate([0, 0, 82]) rotate([0, 90, 0]) cylinder(d=20, h=50, center=true);
			translate([0,  30, 55]) rotate([0, 90, 0]) cylinder(d=20, h=50, center=true);
			translate([0, -30, 45]) rotate([0, 90, 0]) cylinder(d=20, h=50, center=true);
			translate([0, -33, -165]) rotate([-8, 0, 0]) cylinder(r=8, h=235);
			translate([0, 15, 0]) rotate([-45, 0, 0]) cylinder(r=2, h=20);
			translate([0, 15, -61.4]) cylinder(r=2, h=63);
			translate([0, 15, -60]) rotate([-135, 0, 0]) cylinder(r=2, h=20);
		}
	}
}

intersection() {
	oiladdin();
	// translate([350, 0, 0]) cube(size=[700, 700, 700], center=true);  	// left side
	translate([-350, 0, 0]) cube(size=[700, 700, 700], center=true);		// right side
}

// pin (need 3)
// scale(size) translate([0, -30, 45]) rotate([0, 90, 0]) cylinder(h=48, d=18, center=true);
