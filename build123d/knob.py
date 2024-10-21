import cadquery as cq

xy = cq.Workplane("XY")

d_knob = 10

d_hole = xy.cylinder(13, 6.5 / 2) - xy.center(15 + 1.5, 0).box(30, 30, 13)
d_hole = d_hole.translate((0, 0, -1.5))

# base = xy.cylinder(16, d_knob / 2)
base = xy.polygon(6, 18).extrude(10).translate((0, 0, -16 / 2))
base = base.edges(">Z").chamfer(8, 5)
# debug(base)
base += xy.polygon(6, d_knob).extrude(14).translate((0, 0, -16 / 2))

base = base.faces("<Z").workplane().hole(14, 2)

r = base - d_hole

show_object(r)
