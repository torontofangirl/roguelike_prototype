surf = -1

///@func create_light(x, y, flicker)
///@param {real} x			x coordinate to create light source
///@param {real} y			y coordinate to create light source
///@param {bool} flicker	whether or not to create flicker effect
///@returns N/A
create_light = function(_x, _y, _flicker){
	//run in draw gui event
	x = _x
	y = _y
	flicker = _flicker
	
	if (!surface_exists(surf)){
		surf = surface_create(VIEW_W, VIEW_H)
	}
	else{
		var _cx = camera_get_view_x(view_camera[0])
		var _cy = camera_get_view_y(view_camera[0])
		
		surface_set_target(surf)
		gpu_set_blendmode(bm_subtract)
		
		if (flicker) draw_sprite_ext(spr_light, 0, x - _cx, y - _cy, 1 + random(0.05), 1 + random(0.05), 0, c_white, 1)
		else draw_sprite_ext(spr_light, 0, x - _cx, y - _cy, 1, 1, 0, c_white, 1)
		
		gpu_set_blendmode(bm_add)
		draw_sprite_ext(spr_light, 0, x - _cx, y - _cy, 1 + random(0.05), 1 + random(0.05), 0, c_yellow, 0.3)
	
		gpu_set_blendmode(bm_normal)
		draw_set_alpha(1)
	
		surface_reset_target()
	}
}


