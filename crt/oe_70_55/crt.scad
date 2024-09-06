module crt()
	translate([0, 0, -85])
		rotate_extrude()
			polygon(points=[
				[0,  0],
				[-70 / 2,  0],
				[-40.3 / 2,  66],
				[-39.5 / 2,  130],
				[-45.0 / 2,  130],
				[-45.0 / 2,  156],
				[0,  156],
			]);

// crt();
