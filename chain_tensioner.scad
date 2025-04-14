$fn = $preview ? 30 : 100;

include <roundedcube.scad>

module sprocket(teeth=20, roller=3, pitch=17, thickness=3, tolerance=0.2){
	roller=roller/2; //We need radius in our calculations, not diameter
	distance_from_center=pitch/(2*sin(180/teeth));
	echo(distance_from_center);
	angle=(360/teeth);

	pitch_circle=sqrt((distance_from_center*distance_from_center) - (pitch*(roller+tolerance))+((roller+tolerance)*(roller+tolerance)));

	echo(pitch_circle);

	difference(){
		union(){
			cylinder(r=pitch_circle,h=thickness);
			for(tooth=[1:teeth]){
				intersection(){
					rotate(a=[0,0,angle*(tooth+0.5)]){
						translate([distance_from_center,0,0]){
							cylinder(r=pitch-roller-tolerance,h=thickness);
						}
					}
					rotate(a=[0,0,angle*(tooth-0.5)]){
						translate([distance_from_center,0,0]){
							cylinder(r=pitch-roller-tolerance,h=thickness);
						}
					}
				}
			}
		}
		for(tooth=[1:teeth]){
			rotate(a=[0,0,angle*(tooth+0.5)]){
				translate([distance_from_center,0,-1]){
					cylinder(r=roller+tolerance,h=thickness+2);
				}
			}
		}
	}
}

hole_d = 6;

module bike_sprocket() {
	// Example for 08B roller chain
	teeth=9;
	roller_d=7.7;
	thickness=2.0;
	pitch=12.70; // 12.7
	tolerance=0.2;

	/* [Shaft] */
	shaft_d=20;
	shaft_h=10;

	intersection() {
		difference(){
			union(){
				translate([0, 0, -thickness / 2])
					sprocket(teeth, roller_d, pitch, thickness, tolerance);

				cylinder(h=shaft_h, d=shaft_d, center=true); // TOP
			}
			cylinder(h=40, d=hole_d, center=true);
		}
		cylinder(h=40, d=41, center=true);
	}
}


module frm() {
	rotate([0, 90, 0])
		resize(newsize=[18, 25])
			cylinder(h=50, d=20, center=true);
}

module boxed_sprocket() {
	// Holding plates
	for (offs=[-1,1])
		translate([0, -25, offs * 7.75])
			roundedcubez(size=[40, 80, 5], center=true, radius=15);

	translate([0, -47, 0])
		roundedcubez(size=[40, 37, 19.1], center=true, radius=15);
}

module all() {
	difference() {
		boxed_sprocket();
		cylinder(h=40, d=hole_d, center=true);
		translate([0, -47, 0]) {
			frm();
			for (i=[-1,1])
				for (j=[-1,1])
					translate([j * 9, i * 14, 0])
						cube(size=[6, 2, 50], center=true);
		}
	}
}



intersection() {
	union() {
		bike_sprocket();
		all();
	}
	translate([0, 0, -50])
		cube(size=[100, 200, 100], center=true);
}

