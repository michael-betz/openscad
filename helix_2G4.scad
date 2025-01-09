include <helix_extrude.scad>
$fn = $preview ? 30 : 100;  // Enable Manifold rendering in settings

module hex_nut_imperial_not_m3() {
  cylinder(h=3.5, d=9.5, center=true, $fn=6);
  cylinder(h=15, d=3.7, center=true);
}

// Inspired by http://www.w1ghz.org/antbook/conf/Helical_feed_antennas.pdf
// For impedance matching, add a copper foil strip to the first quarter turn
// starting width should be around 5 mm (0.04 * lambda) and taper down

f_0 = 2.422e9;
d_wire_outer = 2.5 + 0.1;
// d_wire_cu = 1.7;
helix_pitch = 13;  // [deg], typically 12 .. 14 deg
n_turns = 6;

lambda = 299792458 / f_0 * 1000;
echo(lambda = lambda, "mm");

// Typical helix circumference = 1 wavelength
d_helix = lambda / PI;
echo(d_helix = d_helix, "mm");

// Turn spacing or pitch [mm]
turn_spacing = tan(helix_pitch) * PI * d_helix;
echo(turn_spacing = turn_spacing, "mm");

h_total = n_turns * turn_spacing;
echo(h_total = h_total, "mm  (printer is 177 mm max.)");

// 3 dB beam-width [degrees]
echo(beam_width_3dB = 52 / (d_helix * PI / lambda * sqrt(n_turns * turn_spacing / lambda)), "deg");

module spiral(offs) {
	translate([0, 0, turn_spacing / 12])
		// spiral_extrude(Height=h_total, Radius=d_helix / 2, Pitch=turn_spacing, StepsPerRev=$fn / 4)
		// 	circle(d=d_wire_outer);
		helix_extrude(angle=360 * n_turns, height=h_total)
			translate([offs, 0, 0])
				circle(d=d_wire_outer);

}

module pipe() {
	difference() {
		translate([0, 0, (h_total + 5) / 2])
			cylinder(h=h_total + 5, d=d_helix, center=true);
		spiral(d_helix / 2);
		translate([0, 0, 5])
			hex_nut_imperial_not_m3();
	}
}

intersection() {
	!pipe();
	// translate([-250, 0, 0])
	// 	cube(size=[500, 500, 500], center=true);
}

