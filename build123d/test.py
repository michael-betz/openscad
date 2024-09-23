# import build123d as b1
from build123d import *

# Create a simple object
with BuildPart() as example:
    Box(10, 10, 10)
    Sphere(6.5, mode=Mode.SUBTRACT)
    s = Sphere(6)
    debug(s)

show_object(example)
