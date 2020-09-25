lerp_progress += (1 - lerp_progress) / 50
text_progress += global.text_speed

var _key_up = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)
var _key_down = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)
response_selected += (_key_down - _key_up)

//wrap responses
var _max = array_length(responses) - 1
var _min = 0
if (response_selected > _max) response_selected = _min
if (response_selected < _min) response_selected = _max

x1 = lerp(x1, target_x1, lerp_progress)
x2 = lerp(x2, target_x2, lerp_progress)

msg = string_wrap(msg, text_max_width)

if (obj_player.key_activate){
	var _message_length = string_length(msg)
	
	if (text_progress >= _message_length){
		if (responses[0] != -1){
			//call from origin instance so that we can do stuff to the instance
			with (origin_instance) dialogue_responses(other.response_scripts[other.response_selected])
		}
		
		instance_destroy()
		if (instance_exists(obj_text_queued)){
			with (obj_text_queued) ticket--	
		}
		else{
			with (obj_player) state = previous_state	
		}
	}
	
	else{
		if (text_progress >= 10){ //allow skip
			text_progress = _message_length
		}
	}
}



