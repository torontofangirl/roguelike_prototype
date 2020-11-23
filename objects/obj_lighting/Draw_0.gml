surface_set_target(surf)

draw_set_colour(c_black)
draw_set_alpha(0.4)
draw_rectangle(0, 0, CAM_W, CAM_H, 0)
draw_set_alpha(1)
	
surface_reset_target()
draw_surface(surf, CAM_X, CAM_Y)
