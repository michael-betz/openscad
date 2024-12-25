"""
Encoder knob for the CRT clocks
tuned for Cura, 0.3 mm layer height, 0.6 mm nozzle
"""

import cadquery as cq

xy = cq.Workplane("XY")

d_knob = 12

d_hole = xy.cylinder(20, 6.65 / 2) - xy.center(15 + 1.6, 0).box(30, 30, 20)
d_hole = d_hole.translate((0, 0, -3))
# debug(d_hole)

# base = xy.cylinder(16, d_knob / 2)
base = xy.polygon(6, 19).extrude(10).translate((0, 0, -16 / 2))
base = base.edges(">Z").chamfer(8, 5)
base += xy.polygon(6, d_knob).extrude(16).translate((0, 0, -16 / 2))
# debug(base)

base = base.faces("<Z").workplane().hole(14.5, 2)

r = base - d_hole

show_object(r)
