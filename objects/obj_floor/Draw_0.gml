shader_set(shd_four_limit); // Set the shader
gpu_set_tex_filter(false); // Set the interpolation to 0      (remove the blur)
//surface_set_target(surf); // Begin to draw

/*
	How it works :
	-it takes a tile map
	-multiply it by 2
	-substract a noise layer
	-use color limiting
	and that's it
	
	method by     Scott Slucher     ->  https://twitter.com/skslucher
	Noise     by     Xor Dev                ->  https://twitter.com/XorDev
	color      by     Trixelized             ->  https://trixelized.itch.io/gbshader
*/

var tilemap = layer_tilemap_get_id("Floor_Tile");    // Get the tile to change
draw_tilemap(tilemap, 0, 0); // Draw the tile map (can be more optimized)



// Reset
//surface_reset_target();
shader_reset();

//draw_surface(surf, CAM_W, CAM_H);  // Draw the final result
//gpu_set_tex_filter(false); // remove the interpolation to make it normal