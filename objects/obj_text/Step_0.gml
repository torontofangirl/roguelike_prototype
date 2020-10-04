lerp_progress += (1 - lerp_progress) / 50
text_progress += text_speed

var _control_up = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)
var _control_down = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)
response_selected += (_control_up - _control_down)

//wrap responses
var _max = array_length(responses) - 1
var _min = 0
if (response_selected > _max) response_selected = _min
if (response_selected < _min) response_selected = _max

x1 = lerp(x1, target_x1, lerp_progress)
x2 = lerp(x2, target_x2, lerp_progress)

msg = string_wrap(msg, text_max_width)

if (obj_player.controls.interact){
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
			with (obj_player){
				try{
					state_switch(get_previous_state(id))
				}
				catch(_exception){
					state_switch("idle")
				}
			}
		}
	}
	
	else{
		if (text_progress >= 10){ //allow skip
			text_progress = _message_length
		}
	}
}



