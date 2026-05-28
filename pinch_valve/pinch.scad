$fn = $preview ? 30 : 100;

include <../roundedcube.scad>

// x-distance from servo center to servo axis
servo_x_offset = 7;

cam_angle = 100;  // [degree]
cam_stroke = 5;
displacement = 25 + cam_stroke / 2 * (cos(cam_angle));

key_length = 16.5;

/**
 *  Head / Tooth parameters
 *
 *  First array (head related) :
 *  0. Head external diameter (including teeth)
 *  1. Head heigth
 *  2. Head thickness (thickness of wall)
 *  3. Head screw diameter (diameter of screw hole)
 *
 *  Second array (tooth related) :
 *  0. Tooth count
 *  1. Tooth height
 *  2. Tooth length
 *  3. Tooth width
 */
// FUTABA 3F Standard cam (25 teeth)
FUTABA_3F_SPLINE = [
    [5.92, 4, 1.1, 2.5],
    [25, 0.3, 0.7, 0.1]
];
// FUTABA 2F cam (21 teeth) ??
FUTABA_2F_SPLINE = [
    [4.5, 4, 1.1, 2.5],
    [22, 0.25, 0.6, 0.09]
];
// FUTABA 1F cam (15 teeth)
FUTABA_1F_SPLINE = [
    [4.0, 3.75, 1.1, 2.4],
    [15, 0.25, 0.6, 0.09]
];
// HITEC A1 Sub-micro cam (15 teeth)
// A15T = A1 3.9mm
A15T_A1_SPLINE = [
    [3.9, 3.2, 1.1, 2.4],
    [15, 0.375, 0.66, 0.13]
];
// SG90 21T (approximation, because the SG90 has a round tooth profile, see  https://community.robotshop.com/blog/show/modelling-a-servo-cam)
SG90_SPLINE = [
    [4.9, 3.2, 1.5, 2.5],
    [21, 0.25, 0.65, 0.25]
];
// Tower Pro SG90 21T
SG90TP_SPLINE = [
    [4.7, 3.2, 1.5, 2.5],
    [21, 0.25, 0.65, 0.25]
];


/**
 *  servo head tooth
 *
 *    |<-w->|
 *    |_____|___
 *    /     \  ^h
 *  _/       \_v
 *   |<--l-->|
 *
 *  - tooth length (l)
 *  - tooth width (w)
 *  - tooth height (h)
 *  - height
 *
 */
module servo_head_tooth(length, width, height, head_height) {
    linear_extrude(height = head_height) {
        polygon([[-length / 2, 0], [-width / 2, height], [width / 2, height], [length / 2,0]]);
    }
}


/**
 *  Servo head (a model of the part where our servo arm will fit on)
 *  This will later be subtracted from our arm.
 */
module servo_head(params, gap = servo_head_gap) {

    head = params[0];
    tooth = params[1];

    head_diameter = head[0];
    head_heigth = head[1];

    tooth_count = tooth[0];
    tooth_height = tooth[1];
    tooth_length = tooth[2];
    tooth_width = tooth[3];

    //% cylinder(r = head_diameter / 2, h = head_heigth + 1);

    //the core of the head
    cylinder(r = head_diameter/2 - tooth_height + 0.03 + gap, h = head_heigth);

    //the teeth
    for (i = [0 : tooth_count]) {
        rotate([0, 0, i * (360 / tooth_count)]) {
            translate([0, head_diameter/2 - tooth_height + gap, 0]) {
                servo_head_tooth(tooth_length, tooth_width, tooth_height, head_heigth);
            }
        }
    }
}

module servo() {
	cube_(size=[40.6, 19.8, 36.6]);
	translate([servo_x_offset, 0, 26.8 + 16.5 - 7])
		scale([1, 1, 1.5])
			servo_head(FUTABA_3F_SPLINE, gap=0);
		// cylinder(h=3, d=30, center=false);
	difference() {
		for (i=[-1, 1])
			translate([48.4 / 2 * i, 0, 26.8])
				cube_([8, 19.8, 4]);

		for (i=[-1, 1])
			for (j=[-1, 1])
				translate([48.4 / 2 * i, 10 / 2 * j, 26.8])
					cylinder(h=10, d=5, center=true);
	}
}

module cam() {
	difference() {
		translate([cam_stroke / 2, 0, 0])
		cylinder(h=10, d=50, center=false);
		translate([0, 0, -0.1])
			servo_head(FUTABA_3F_SPLINE, gap=0.2);
	}
}

module frame() {
	difference() {
		union() {
			translate([5, 0, 0])
				cube_([85, 50, 7]);
			translate([39, 0, 0])
				cube_(size=[22, 50, 18]);
		}
		// Servo mounting screw holes
		for (i=[-1, 1])
			for (j=[-1, 1])
				translate([48.4 / 2 * i - servo_x_offset, 10 / 2 * j, 2])
					cylinder(h=20, d=5, center=true);

		// Hole for servo body
		translate([-servo_x_offset, 0, -0.1])
			cube_(size=[42, 21, 10]);

		// pipe hole
		translate([40, 0, 11.5])
			rotate([0, 90, 90])
				cylinder(h=55, d=7, center=true);

		// key slot
		translate([33.5, 0, 7])
			cube_([20, 3, 10]);

		// Relief
		translate([41, 0, 7])
			cube_([6, 15, 20]);
	}
}

module key() {
	kl = key_length - 2.5;
	translate([kl / 2, 0, 0])
		cube_([kl, 2.5, 9.5]);
	translate([kl, 0, 0])
		cylinder(h=9.5, d=2.5, center=false);
}


translate([-servo_x_offset, 0, -26.8 - 4])
	color("blue")
		servo();

translate([0, 0, servo_x_offset + 0.25])
	rotate([0, 0, cam_angle])
		color("green")
			cam();

intersection() {
	translate([0, 50, 0])
		cube(size=[100, 100, 100], center=true);
	frame();
}

translate([displacement, 0, 7])
	color("yellow")
		key();
