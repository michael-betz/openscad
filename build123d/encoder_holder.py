from build123d import *
from numpy import mod

plate_width = 110
screw_width = plate_width - 16

# stamp to be subtracted from a shape to make space for encoder
with BuildPart() as encoder_stamp:
    with BuildSketch():
        with Locations((-0.7 / 2 - 0.4, 0)):
            Rectangle((9.3 + 8.3) + 3, 16.8 + 2)
        with Locations((-13.5 / 2, 0)):
            Rectangle(14.5, 4 + 2)
    extrude(amount=-50)

    Cylinder(5, 10)

    with Locations((-9.3, 0, 0)):
        Cylinder(3.5 / 2, 5)


with BuildPart() as encoder_holder:
    with Locations((0, 0, 15)):
        Box(35, plate_width, 30)

    for i in [-1, 1]:
        with Locations((0, i * screw_width / 2, 3.5)):
            Cylinder(height=15, radius=5.25 / 2, mode=Mode.SUBTRACT)
        with Locations((-10, i * screw_width / 2, 3)):
            Box(8.5 + 20, 8.5, 3, mode=Mode.SUBTRACT)

    chamfer(encoder_holder.edges().sort_by()[-1], 18)

    ux_face = encoder_holder.faces().sort_by()[-2]
    with Locations(ux_face):
        with Locations((0, 0, -5)):
            add(encoder_stamp, mode=Mode.SUBTRACT)
        with Locations((0, 0, -40)):
            Box(80, 40, 50, mode=Mode.SUBTRACT)

    for i in [0, -1]:
        f = faces().sort_by(Axis.Y)[i]
        e = f.edges().sort_by(SortBy.LENGTH)[0:-2]
        fillet(e, 15)

show_object(encoder_holder)
