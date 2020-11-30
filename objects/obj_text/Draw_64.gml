nine_slice_box_stretched(spr_textbox_bg, x1, y1, x2, y2, bg_index)

#region draw text
draw_set_text(c_black, fnt_textbox, fa_center, fa_top)

var _print = string_copy(string_wrap(msg[page], text_max_width), 1, text_progress)

draw_text((x1 + x2) / 2, y1 + text_buffer_from_top, _print)
draw_set_colour(c_white)
draw_text((x1 + x2) / 2, y1 + text_buffer_from_top - 1, _print)
#endregion



