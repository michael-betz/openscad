$fn=75;

r_plate = 163 / 2;
h_plate = 4.6 + 0.2;
T = 8;   // plastic thickness / primary height
A = 25;  // slot depth
cone_angle = 20;
h_holder = 36;
d_wire = 3.5;
N_holders = 6;

d_mounting_hole = 3.6;

module chamfer_block() {
	translate([5 / sqrt(2), 5 / sqrt(2)]) rotate([0, 0, 45]) square([10, 20], center=true);
}

module 2d_shape() {
	difference() {
		polygon([
			[0, 0],
			[0, -T],
			[A + T, -T],
			[A + T, T + h_plate],
			[T + T * sin(cone_angle), T + h_plate],
			[T + T * sin(cone_angle) + h_holder * sin(cone_angle), T + h_plate + h_holder],
			[(h_holder + T) * sin(cone_angle), T + h_plate + h_holder],
			[0, h_plate],
			[A, h_plate],
			[A, 0]
		]);
		translate([(T + d_wire / 2) * sin(cone_angle) + T, T + h_plate + d_wire / 2, 0])
			for (i = [0: d_wire: h_holder]) {
				translate([i * sin(cone_angle), i, 0])
					circle(r=d_wire / 2);
			}
		chamfer_val = 3;
		translate([A + T - chamfer_val, T + h_plate - chamfer_val])
			chamfer_block();
		translate([A + T - chamfer_val, -T + chamfer_val])
			rotate([180, 0]) chamfer_block();
	}
}

module 3d_shape() {
	// radius and angle of mounting hole
	r_temp = r_plate - d_mounting_hole * 1.5;
	alpha = 45 / 4 / 2;
	difference() {
		rotate_extrude(angle=45 / 4, $fn=200)
			translate([r_plate - A, 0, 0]) 2d_shape();
		// Drill a mounting hole
		translate([r_temp * cos(alpha), r_temp * sin(alpha), -12])
			cylinder(h=15, r=d_mounting_hole / 2, center=false, $fn=20);
	}
}

// 2d_shape();

// ---------------------------------
//  Model of how it will look like
// ---------------------------------
// cylinder(h=h_plate, r=r_plate);
// cylinder(h=300, r=110 / 2);
// color("grey")
// 	for (i = [0: 360 / N_holders: 359]) {
// 		echo(i);
// 		rotate([0, 0, i]) 3d_shape();
// 	}

// ----------------
//  for exporting
// ----------------
3d_shape();
