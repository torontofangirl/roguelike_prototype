/// @desc Update cam

//update destination
if (instance_exists(follow)){
	xTo = follow.x
	yTo = follow.y
}

/*x = lerp(x, xTo, 0.15);
y = lerp(y, yTo, 0.15);*/

x += xTo - x
y += yTo - y

//clamp camera in room
x = clamp(x, view_w_half + TILE_SIZE, room_width - view_w_half - TILE_SIZE)
y = clamp(y, view_h_half + TILE_SIZE, room_height - view_h_half - TILE_SIZE)

//screenshake
x += random_range(-shake_remain, shake_remain)
y += random_range(-shake_remain, shake_remain)

shake_remain = max(0, shake_remain - ((1/shake_length) * shake_magnitude)) // remove 1/10 of screenshake every step

camera_set_view_pos(cam, x - view_w_half, y - view_h_half)


