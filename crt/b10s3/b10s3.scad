module crt()
	translate([128, 0, 0])
		rotate([90, 0, -90])
			color("white")
				rotate_extrude()
					rotate([0, 0, 90])
						translate([-35, -250, 0])
							polygon(points=[
								[35.0, 250.0],
								[35.0, 301.5],
								[77.1, 300.5],
								[98.4, 296.3],
								[116.4, 290.8],
								[133.0, 284.2],
								[153.8, 274.7],
								[163.7, 271.4],
								[174.6, 271.2],
								[214.1, 271.0],
								[279.6, 271.4],
								[280.4, 274.7],
								[284.9, 275.5],
								[291.5, 275.5],
								[291.0, 250.0],
							]);
