$fn = $preview ? 30 : 100;

// include <../ali_parts.scad>

w_panel = 84;
w_flex = 60;
h_panel = 25.8;
t_panel = 2.0;


shell_thickness = 2;

// space (wiggle room) between panel and frame around it
gap = 0.5;

// How far the panel is lifted from the carrier PCB
h_offset = 7.0;

// The rounded lip part
d_lip = 4;
y_lip = -1;


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

module oled_frame() {
	difference() {
		translate([0, 0, (h_offset + t_panel - 1.25 + gap * 2) / 2])
			cube(size=[w_panel + shell_thickness * 4, 30, h_offset + t_panel - 1.25 + gap * 2], center=true);

		// pocket for the display
		translate([0, 0, 5 + h_offset])
			cube(size=[w_panel + gap, h_panel + gap, 10], center=true);

		// Opening for the flex
		// remove the lip to shape it better
		translate([0, -10 - (h_panel + gap) / 2 - y_lip, 7])
			cube(size=[w_flex + 2 * gap, 20, 10], center=true);

		// Clear out the top
		translate([0, -25, 5 + h_offset])
			cube(size=[w_flex + 2 * gap, 50, 10], center=true);

		// Clear out the bottom
		cube(size=[w_flex + 2 * gap, 100, 14 - d_lip * 2], center=true);

		// slots for square nuts
		for (i=[-1, 1]) {
			translate([40 * i, 0, 3]) {
				translate([2 * i, 0, 0])
					cube(size=[10, 6, 2.25], center=true);
				translate([0, 0, -1])
					cylinder(h=7, d=3.5, center=true);
			}
			// Dog bones
			translate([i * ((w_panel + gap) / 2 - 0.8), ((h_panel + gap) / 2 - 0.8), 5 + h_offset - 1.3])
				cylinder(h=10, d=3, center=true);
			// translate([i * ((w_panel + gap) / 2 - 0.8), -((h_panel + gap) / 2 - 0.8), 5 + h_offset])
			// 	cylinder(h=10, d=3, center=true);
			translate([i * ((w_panel + gap) / 2 - 0.8), -((h_panel + gap) / 2 - 0.8) + 2, 5 + h_offset - 1.3])
				cylinder(h=10, d=3, center=true);

			translate([i * ((w_panel + gap) / 2 - 1), -((h_panel + gap) / 2 - 1) + 0.75, 5 + h_offset])
				cylinder(h=10, d=5, center=true);
		}
	}

	// The rounded lip
	translate([0, -(h_panel + gap) / 2 - y_lip, -d_lip/2 + h_offset]) {
		rotate([0, 90, 0])
			cylinder(h=w_flex + 2 * gap, d=d_lip, center=true);
	}
}

// translate([0, 0, h_offset - 1.25 + gap])
// 	panel();

module all()
{
	difference() {
		oled_frame();
		// Cut a deeper notch for the bottom glass plate
		translate([0, 1, 5 + h_offset - 1.3])
			cube(size=[w_panel + gap * 2, h_panel + gap * 2 - 2, 10], center=true);
	}
}

intersection() {
	all();
	// translate([50, 0, 0])
	// 	cube(size=[100, 100, 100], center=true);
}
