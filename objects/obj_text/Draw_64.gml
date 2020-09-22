nine_slice_box_stretched(spr_textbox_bg, x1, y1, x2, y2, bg_index)

draw_set_text(c_black, fnt_textbox, fa_center, fa_top)
var _print = string_copy(msg, 1, text_progress)

if ((responses[0] != -1) && (text_progress >= string_length(msg))){
	for (var _i = 0; _i < array_length(responses); _i++){
		_print += "\n"
		
		if (_i == response_selected) _print += "> "
		_print += responses[_i]
		if (_i == response_selected) _print += " <"
		
		_print = string_wrap(_print, text_max_width)
	}
}

draw_text((x1 + x2) / 2, y1 + text_buffer_from_top, _print)

draw_set_colour(c_white)
draw_text((x1 + x2) / 2, y1 + text_buffer_from_top - 1, _print)




