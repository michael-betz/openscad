$fn=200;

w_light = 55;
h_light = 20;
d_corner = 18;

led_dist = 20;
screw_dist = 44;

module outline()
{
	minkowski() {
		square([w_light - d_corner, h_light - d_corner], center=true);
		circle(d_corner / 2);
	}
}

module led_holder()
{
	difference() {
		// extruded solid
		linear_extrude(3.5)
			outline();
		translate([0, 0, 4 + 3.5 - 2.0]) {  // wall thickness
			for (i=[-1, 1]) {
				// LED holes
				translate([i * led_dist / 2, 0, 0]) {
					translate([0, 0, -1])
						cylinder(d=6.3, h=8, center=true);
					cylinder(d=8.3, h=8, center=true);
					cube([4, 17, 8], center=true);
				}
				// wire channels
				translate([0, i * 7, 0])
					cube(size=[led_dist, 3, 8], center=true);
				// screw holes
				translate([i * screw_dist / 2, 0, 0])
					cylinder(h=20, d=4.3, center=true);
			}
			translate([0, 3, 0])
				cube(size=[3, led_dist, 8], center=true);
		}
	}
}

module diffuser()
{
	r_sphere = 140;
	difference() {
		intersection() {
			linear_extrude(5)
				outline();
			translate([0, 0, -r_sphere + 6.0])
			scale([1.0, 0.4, 1.0])
				sphere(r=r_sphere);
		}
		h = 5;
		d1 = 4;
		for (i=[-1, 1]) {
			// screw holes
			translate([i * screw_dist / 2, 0, h / 2 + 2]) {
				cylinder(h=h, d1=d1, d2=d1 + 2 * h, center=true);  // chamfer
				cylinder(h=15, d=d1, center=true);
			}
			// light holes
			translate([i * led_dist / 2, 0, 2 - 0.01])
				cylinder(h=5, d1=20, d2=9, center=true);
		}
	}
}

module half_pipe()
{
	d = 28;
	difference() {
		linear_extrude(10)
			outline();
		translate([0, 0, -d / 2 + 8])
			rotate([90, 0, 0])
				cylinder(d=d, h=30, center=true);

		// screw holes
		for (i=[-1, 1])
			translate([i * screw_dist / 2, 0, 5])
				cylinder(h=20, d=3.9, center=true);
	}
}

intersection() {
	translate([0, 25, 0])
		cube([100, 50, 100], center=true);
	union() {
		translate([0, 0, 10])
			diffuser();
		translate([0, 0, -5])
	 		led_holder();
		translate([0, 0, -17])
			half_pipe();

		translate([0, 0, -39])
			rotate([0, 180, 0])
				half_pipe();
	}
}
