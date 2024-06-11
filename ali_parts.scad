use <catchnhole/catchnhole.scad>;

module bolt_m5_16_cs(head_up=false) {
  l = 16;
  rotate([head_up ? 180 : 0, 0, 0])
    translate([0, 0, -l])
      bolt("M5", length=l, kind="countersunk");
}


module bolt_m5_20_hx(head_up=false) {
  l = 20;
  rotate([head_up ? 180 : 0, 0, 0])
    translate([0, 0, -l])
      bolt("M5", length=l, kind="socket_head");
}

module bolt_m3_20_cs(head_up=false) {
  l = 20;
  rotate([head_up ? 180 : 0, 0, 0])
    translate([0, 0, -l])
      bolt("M3", length=l, kind="countersunk");
}

module spacer_m3_10() {
  difference() {
    cylinder(h=10, d=7, center=true);
    cylinder(h=11, d=3.2, center=true);
  }
}

module _square_nut(d, s, m, e) {
  intersection() {
    difference() {
      cube([s, s, m], center=true);
      cylinder(h=m + 1, d=d, center=true);
    }
    rotate([0, 0, 45])
      cube([e, e, m + 1], center=true);
  }
}

module square_nut_m3(clearance=0) {
  _square_nut(clearance ? 0 : 3, 5.3, 1.7, 6.5);
}

// use clearance > 0 when subtracting a hole for a nut
// 0.3 to 0.5 mm should work well
module square_nut_m5(clearance=0) {
  _square_nut(clearance ? 0 : 5, 8 + clearance, 2.7 + clearance, 10 + clearance * 100);
}
