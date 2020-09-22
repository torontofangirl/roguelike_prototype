if (keyboard_check_pressed(vk_escape)){
	global.game_paused = !global.game_paused
	
	if (global.game_paused){
		with (all){
			image_speed_paused = image_speed
			image_speed = 0
		}
	}
	else{
		with (all){
			image_speed = image_speed_paused	
		}
	}
}
	
