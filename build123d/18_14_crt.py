import cadquery as cq

crt = (
    cq.importers.importDXF("18-14.dxf")
    .translate((-90, -270, 0))
    .revolve()
    .rotate((0, 0, 0), (1, 0, 0), 11)
    .translate((0, 0, 90))
)

block = (
    cq.Workplane("XY")
    .box(150, 250, 45, centered=True)
    .translate((0, -75, 22.5))
    .edges("|Z")
    .fillet(50)
)
block = block.union(block.translate((0, 28, 110)).rotate((0, 0, 0), (1, 0, 0), 20))
block = block.cut(crt)

# show_object(block)
