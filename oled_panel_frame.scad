$fn = $preview ? 30 : 100;

include <../ali_parts.scad>

w_panel = 84;
w_flex = 60;
h_panel = 25.8;
t_panel = 2.0;


shell_thickness = 1.0;

// space (wiggle room) between panel and frame around it
gap = 0.5;

// How far the panel is lifted from the carrier PCB
h_offset = 7.0;

// The rounded lip part
d_lip = 4.5;
y_lip = 1.25;


module panel() {
	color("grey")
		translate([0, 1, (t_panel - 0.75) / 2])
			cube(size=[w_panel, h_panel - 2, t_panel - 0.75], center=true);
	color("lightgrey")
		translate([0, 0, t_panel - 0.75 / 2])
			cube(size=[w_panel, h_panel, 0.75], center=true);
	translate([0, -10 - h_panel / 2, 1.20])
		cube(size=[w_flex, 25, 0.1], center=true);
}


// translate([0, 0, h_offset])
// 	panel();

module oled_frame() {
	difference() {
		translate([0, -shell_thickness, (h_offset + t_panel + gap) / 2])
			cube(size=[w_panel + shell_thickness * 4, h_panel + shell_thickness * 4, h_offset + t_panel + gap], center=true);

		// pocket for the display
		translate([0, 0, 5 + h_offset])
			cube(size=[w_panel + gap, h_panel + gap, 10], center=true);

		// Opening for the flex
		// remove the lip to shape it better
		translate([0, -5 - h_panel / 2 - shell_thickness + y_lip, 7])
			cube(size=[w_flex + gap, 10, 10], center=true);

		// Clear out the bottom
		cube(size=[w_flex + gap, 100, 14 - d_lip * 2], center=true);

		// slots for square nuts
		for (i=[-1, 1])
			translate([40 * i, 0, 3]) {
				// #square_nut_m3();
				translate([2 * i, 0, 0])
					cube(size=[10, 6, 2.25], center=true);
				cylinder(h=7, d=3.5, center=true);
			}
	}

	// The rounded lip
	translate([0, - h_panel / 2 - shell_thickness + y_lip, -d_lip/2 + h_offset]) {
		rotate([0, 90, 0])
			cylinder(h=w_flex + gap, d=d_lip, center=true);
	}
}


intersection() {
	oled_frame();
	// translate([50, 0, 0])
	// 	cube(size=[100, 100, 100], center=true);
}
