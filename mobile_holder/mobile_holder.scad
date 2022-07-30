// done, Need to fix z_offset USB
// done, Need to have more space for the USB connector (height)
// Need to make USB connector poke out further

$fn = 32;

w = 80;
w_nokia = 76;
t = 2;
t_nokia = 8.5;
h = 50;

w_usb_a = 8.2 * 1.2;
w_usb_b = 10.6 * 1.05;
h_usb = 16.1 + 1;
z_offset_usb = 4.48 - 0.9;
h_usb_block = 10;


module nokia() {
	color("black")
		translate([-w_nokia / 2, 0, 0])
			cube(size=[w_nokia, 76, t_nokia]);
}

module screwBlock() {
	difference() {
		cube(size=[w + 20, 10, t], center=true);
		translate([-w / 2 - 4, 0, 0])
			cylinder(h=t * 2, d=4, center=true);
		translate([w / 2 + 4, 0, 0])
			cylinder(h=t * 2, d=4, center=true);
	}
}

module wedge() {
	linear_extrude(t_nokia)
		polygon([
			[0, 0],
			[(w - w_nokia) / 2, 0],
			[(w - w_nokia) / 2, 20],
			[(w - w_nokia) / 2 - 1, h],
			[0, h]
		]);
	translate([0, 0, t_nokia])
		cube(size=[5, h, t], center=false);
}

module holder() {
	translate([0, 0, -t / 2])
		cube(size=[w, h, t], center=true);

	translate([-w / 2, -h / 2, 0])
		wedge();

	translate([w / 2, -h / 2, 0])
		mirror([1, 0, 0])
			wedge();

	translate([-w / 2, -h / 2, t_nokia])
		cube(size=[w, t, t]);
}

module usb_mock() {
	translate([0, -h_usb / 2, 1.2]) {
		translate([0, h_usb / 2 + 6.6 / 2, 0])
			cube(size=[w_usb_a, 6.6, 2.4 * 1.2], center=true);
		cube(size=[w_usb_b, h_usb, 6.5], center=true);
		translate([0, -10, 0])
			rotate([90, 0 ,0])
				cylinder(h=20, d=5.3, center=true);
	}
}

module conBlock() {
	translate([0, -10, t_nokia / 2])
		difference() {
			union() {
				translate([0, 0, (h_usb_block - t_nokia ) / 2 - t])
					cube(size=[w_usb_b + 2 * t, 20, h_usb_block], center=true);
				translate([0, 10 - t / 2, 0])
					cube(size=[w, t, t_nokia + 2 * t], center=true);
			}
			translate([0, 10 - 0.5, z_offset_usb - t_nokia / 2])
				usb_mock();
			translate([0, -t, 5 + z_offset_usb - 6.1 / 2])
				cube(size=[w_usb_b, 20, 10], center=true);
		}
}

// translate([0, -h / 2, 0])
// 	nokia();

module phone_holder() {
	union() {
		translate([0, h / 2 + 5, -t / 2])
			screwBlock();

		difference() {
			holder();
			translate([0, 15, 10])
				rotate(([-10, 0, 0]))
					cube([w + 10, 30, 10], center=true);
		}

		translate([0, -h / 2, 0])
			conBlock();
	}
}

intersection() {
	phone_holder();
	// translate([-25, 0, 0])
	// 	cube(size=[50, 100, 50], center=true);
}

	// translate([0, -h / 2 - 1.2, z_offset_usb])
	// 	color("grey") usb_mock();
