function draw_set_text(_colour, _font, _halign, _valign){
	draw_set_colour(_colour)
	draw_set_font(_font)
	draw_set_halign(_halign)
	draw_set_valign(_valign)
}

function new_textbox(_msg, _opt_bg_index, _opt_responses){
	var _obj
	
	if (instance_exists(obj_text)) _obj = obj_text_queued else _obj = obj_text
	with (instance_create_layer(0, 0, "Managers", _obj)){
		msg = _msg
		
		if (instance_exists(other)) origin_instance = other.id else origin_instance = noone
		
		if (_opt_bg_index != undefined) bg_index = _opt_bg_index else bg_index = 0
	}
	
	with (obj_player){
		if (state != playerstate_locked){
			previous_state = state
			state = playerstate_locked
		}
	}
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


