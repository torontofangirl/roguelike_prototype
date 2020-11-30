if (live_call()) return live_result

depth = -bbox_bottom

if (!global.game_paused){
	controls = {
		left: keyboard_check(ord("A")),
		right: keyboard_check(ord("D")),
		up: keyboard_check(ord("W")),
		down: keyboard_check(ord("S")),
		interact: keyboard_check_pressed(ord("E")),
		dash: keyboard_check_pressed(vk_space),
		phase: keyboard_check_pressed(vk_space),
		
		select_up: keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")),
		select_down: keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))
	}

	input_direction = point_direction(0, 0, controls.right - controls.left, controls.down - controls.up)
	input_magnitude = (controls.right - controls.left != 0) || (controls.down - controls.up != 0)
	
	state.step()
}




