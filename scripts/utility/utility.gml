///@func script_execute_array(function, params)
///@param {real} function			The function to execute
///@param [params]					Array of params
///@returns N/A
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

///@func chance(percent)
///@param {real} percent			percentage on scale 0-1
///@returns {bool} chance			i can't think of what to write here
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

///@func draw_set_text(colour, font, halign, valign)
///@param {real}			colour
///@param {real}			font
///@param {real}			halign
///@param {real}			valign
///@returns					N/A
function draw_set_text(_colour, _font, _halign, _valign){
	draw_set_colour(_colour)
	draw_set_font(_font)
	draw_set_halign(_halign)
	draw_set_valign(_valign)
}

///@func string_wrap(string, max_width)
///@param {string}			string to be wrapped
///@param {real}			string WIDTH (not length) to wrap after
///@returns {string}		wrapped string
function string_wrap(_str, _max_width){
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

///@func nine_slice_box_stretched(sprite, x1, y1, x2, y2, index)
///@arg sprite
///@arg x1 left
///@arg y1 top
///@arg x2 rigt
///@arg y2 bottom
///@arg index image index
function nine_slice_box_stretched(sprite, x1, y1, x2, y2, index){
	var _size = sprite_get_width(argument0) / 3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _index = argument5;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1

	//MIDDLE
	draw_sprite_part_ext(argument0, _index, _size, _size, 1, 1, _x1 + _size,_y1 + _size, _w - (_size * 2), _h - (_size * 2), c_white,1);

	//CORNERS
	//TOP LEFT
	draw_sprite_part(argument0, _index, 0, 0, _size, _size, _x1, _y1);
	//TOP RIGHT
	draw_sprite_part(argument0, _index, _size * 2, 0, _size, _size, _x1 + _w - _size, _y1);
	//BOTTOM LEFT
	draw_sprite_part(argument0, _index, 0, _size * 2, _size, _size, _x1, _y1 + _h - _size);
	//BOTTOM RIGHT
	draw_sprite_part(argument0, _index, _size * 2, _size * 2, _size, _size, _x1 + _w - _size, _y1 + _h - _size);

	//EDGES
	//LEFT
	draw_sprite_part_ext(argument0, _index, 0, _size, _size, 1, _x1, _y1 + _size, 1, _h - (_size * 2), c_white, 1);
	//RIGHT
	draw_sprite_part_ext(argument0, _index, _size * 2, _size, _size, 1, _x1 + _w - _size, _y1 + _size, 1, _h - (_size * 2), c_white, 1);
	//TOP
	draw_sprite_part_ext(argument0, _index, _size, 0, 1, _size, _x1 + _size, _y1, _w - (_size * 2), 1, c_white, 1);
	//BOTTOM
	draw_sprite_part_ext(argument0, _index, _size, _size * 2, 1, _size, _x1 + _size, _y1 + _h - (_size), _w - (_size * 2), 1, c_white,1);
}




