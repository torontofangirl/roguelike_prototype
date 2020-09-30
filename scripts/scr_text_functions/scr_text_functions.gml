function draw_set_text(_colour, _font, _halign, _valign){
	draw_set_colour(_colour)
	draw_set_font(_font)
	draw_set_halign(_halign)
	draw_set_valign(_valign)
}

function string_wrap(_str, _max_width){
	//inserts \n
	var _str_len = string_length(_str)
	var _last_space = 1
	
	var _count = 1
	var _sub_str
	
	repeat (_str_len){
		_sub_str = string_copy(_str, 1, _count)
		if (string_char_at(_str, _count) == " ") _last_space = _count
		
		if (string_width(_sub_str) > _max_width){
			_str = string_delete(_str, _last_space, 1)
			_str = string_insert("\n", _str, _last_space)
			_count++ //insert \n increases 1 char (backslash ignored)
		}
		_count++
	}
	return _str
}

function new_textbox(_msg, _opt_bg_index, _opt_responses){
	if (0) return argument[0] //hacky way for no wrong argument error
	var _obj
	
	if (instance_exists(obj_text)) _obj = obj_text_queued else _obj = obj_text
	with (instance_create_layer(0, 0, "Managers", _obj)){
		msg = _msg
		
		if (instance_exists(other)) origin_instance = other.id else origin_instance = noone
		
		if (_opt_bg_index != undefined) bg_index = _opt_bg_index else bg_index = 0
		
		if (_opt_responses != undefined){
			//trim markers
			responses = _opt_responses
			for (var _i = 0; _i < array_length(responses); _i++){
				var _marker_pos = string_pos(":", responses[_i])
				response_scripts[_i] = string_copy(responses[_i], 1, _marker_pos - 1)
				response_scripts[_i] = real(response_scripts[_i])
				
				responses[_i] = string_delete(responses[_i], 1, _marker_pos)
			}
		}
		else{
			responses = [-1]
			response_scripts = [-1]
		}
	}
	
	with (obj_player){
		if (state != playerstate_locked){
			previous_state = state
			state = playerstate_locked
		}
	}
}

function dialogue_responses(_response){
	//GIANT SWITCH STATEMENT HOORAY
	switch (_response){
		case 0: break //end conversation
		case 1: new_textbox("you gave response a!", 0) break
		case 2: new_textbox("you gave response b! any further response?", 0, ["3:Yes", "0:No"]) break
		case 3: new_textbox("thanks for giving responses", 0) break
		
		default: show_debug_message("dialogue_responses switch statement: something's gone wrong") break
	}
}


