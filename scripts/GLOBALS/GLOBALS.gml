global.game_paused = false

///@func new_textbox(message, opt_bg_index, [opt_responses])
///@param {string} message			the message to display
///@param {real} opt_bg_index		image_index of bg sprite
///@param {string} [opt_responses]	array of responses
///@returns N/A
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
		if (get_current_state(id) != "locked"){
			state_switch("locked")
		}
	}
}

///@func dialogue_responses(response)
///@param {real} response			index of response to select
///@returns N/A
function dialogue_responses(_response){
	//GIANT SWITCH STATEMENT HOORAY
	switch (_response){
		case 0: break //end conversation
		case 1: new_textbox("you gave response a!", 0) break
		case 2: new_textbox("you gave response b! any further response?", 0, ["3:Yes", "0:No"]) break
		case 3: new_textbox("thanks for giving responses", 0) break
		
		default: show_error("dialogue_responses switch statement: something's gone wrong", false) break
	}
}


	

