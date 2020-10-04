function script_execute_array(_script, _args){
	switch (array_length(_args)) {
 
		case 1: return script_execute(_script, _args[0]);
 
		case 2: return script_execute(_script, _args[0], _args[1]);
 
		case 3: return script_execute(_script, _args[0], _args[1], _args[2]);
 
		case 4: return script_execute(_script, _args[0], _args[1], _args[2], _args[3]);
 
		case 5: return script_execute(_script, _args[0], _args[1], _args[2], _args[3], _args[4]);
 
		case 6: return script_execute(_script, _args[0], _args[1], _args[2], _args[3], _args[4], _args[5]);
 
		case 7: return script_execute(_script, _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6]);
 
		case 8: return script_execute(_script, _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7]);
 
		default: show_error("script_execute_array: argument count not supported!", false);
	}
}

/// @func		approach(val1, val2, amount)
/// @param		{real}	 val1				Initial value
/// @param		{real}	 val2				Target value
/// @param		{real}	 amount				Increment (or Decrement)
/// @returns	{real}						Changed value
/// @author		Meseta
function approach(_val1, _val2, _inc) {
	return (_val1 + clamp(_val2-_val1, -_inc, _inc));
}

function chance(_percent){
	//chance(0.7) returns true 70% of time
	return _percent > random(1)
}

/// @func		animation_end()
/// @returns	{bool}						Whether sprite_index has finished animating or not
/// @author		Minty Python
function animation_end() {
	return (image_index + image_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe? 1 : game_get_speed(gamespeed_fps)) >= image_number);	
}

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

function screen_shake(_magnitude, _frames){
	with (global.camera_id){
		if (_magnitude > shake_remain){
			shake_magnitude = _magnitude
			shake_remain = shake_magnitude
			shake_length = _frames
		}
	}
}
