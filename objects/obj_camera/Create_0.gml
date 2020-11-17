/// @desc setup camera
cam = view_camera[0]
follow = obj_player
view_w_half = camera_get_view_width(cam) * 0.5
view_h_half = camera_get_view_height(cam) * 0.5
xTo = xstart
yTo = ystart

x = follow.x
y = follow.y

//screenshake
shake_length = 0
shake_magnitude = 0
shake_remain = 0

///@func screen_shake(magnitude, frames)
///@param {real} magnitude			how many pixels to screenshake
///@param {real} frames				how long in frames the screenshake lasts
screen_shake = function(_magnitude, _frames){
	if (_magnitude > shake_remain){
		shake_magnitude = _magnitude
		shake_remain = shake_magnitude
		shake_length = _frames
	}
}


