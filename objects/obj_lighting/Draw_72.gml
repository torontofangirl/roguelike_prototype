/// @desc init surface
if (!surface_exists(surf)){
	surf = surface_create(CAM_W, CAM_H)
	surface_set_target(surf)
	draw_clear_alpha(0, 0)
	surface_reset_target()
}

