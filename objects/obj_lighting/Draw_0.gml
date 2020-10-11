if (!surface_exists(surf)){
	surf = surface_create(VIEW_W, VIEW_H)
}
else{
	var _cx = camera_get_view_x(view_camera[0])
	var _cy = camera_get_view_y(view_camera[0])
	surface_set_target(surf)
	
	draw_set_colour(c_black)
	draw_set_alpha(0.4)
	draw_rectangle(0, 0, VIEW_W, VIEW_H, 0)
	draw_set_alpha(1)
	
	surface_reset_target()
	draw_surface(surf, _cx, _cy)
}


