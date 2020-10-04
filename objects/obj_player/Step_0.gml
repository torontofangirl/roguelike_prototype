controls = {
	left: keyboard_check(vk_left),
	right: keyboard_check(vk_right),
	up: keyboard_check(vk_up),
	down: keyboard_check(vk_down),
	interact: keyboard_check_pressed(ord("X")),
	dash: keyboard_check_pressed(ord("Z"))
}

input_direction = point_direction(0, 0, controls.right - controls.left, controls.down - controls.up)
input_magnitude = (controls.right - controls.left != 0) || (controls.down - controls.up != 0)

if (!global.game_paused){
	state.step()
	depth = -bbox_bottom
}



