use <catchnhole/catchnhole.scad>;

module m5_14_cs(is_upside_down=false) {
	rotate([is_upside_down ? 180 : 0, 0, 0])
		bolt("M5", length=14 + 2.8, kind="countersunk");
}

m5_14_cs(true);
