lerp_progress += (1 - lerp_progress) / 50
x1 = lerp(x1, target_x1, lerp_progress)
x2 = lerp(x2, target_x2, lerp_progress)

var _wrapped_string = string_wrap(msg[page], text_max_width)
var _wrapped_string_length = string_length(_wrapped_string)

#region progress text
if (text_progress < _wrapped_string_length && !pause){
	text_progress += text_speed
	
	switch (string_char_at(_wrapped_string, text_progress)){
		case ",": 
			pause = true 
			alarm[1] = 8
			break
		case ".":
		case "?":
		case "!": 
			pause = true
			alarm[1] = 15
			break
	}
}
#endregion

#region increase page
if (obj_player.controls.interact && alarm[0] < 0){
	if (text_progress < string_length(string_wrap(msg[page], text_max_width))){
		text_progress = string_length(string_wrap(msg[page], text_max_width))	
	}
	
	else if (page < array_length(msg) - 1){ //-1 since array_length([1, 2]) is 2
		page++
		text_progress = 0
	}
	else{
		with (obj_player) state_switch(get_previous_state(id))
		instance_destroy()
	}
}
#endregion