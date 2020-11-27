global.game_paused = false

///@func grid_meeting(object, grid)
///@param {real} object			id of the object to check
///@param {real} grid			ds_grid to check collision with
///@returns {bool} collision	whether there is a collision or not
function grid_meeting(_object, _grid){
	var _top_right = _grid[(_object.bbox_right - 1) / TILE_SIZE][_object.bbox_top / TILE_SIZE].type == VOID
	var _top_left = _grid[_object.bbox_left / TILE_SIZE][_object.bbox_top / TILE_SIZE].type == VOID
	var _bottom_right = _grid[(_object.bbox_right - 1) / TILE_SIZE][(_object.bbox_bottom - 1) / TILE_SIZE].type == VOID
	var _bottom_left = _grid[_object.bbox_left / TILE_SIZE][(_object.bbox_bottom - 1) / TILE_SIZE].type == VOID

	return _top_right || _top_left || _bottom_right || _bottom_left
}

///@func fourlimit_set_colors(colA, colB, colC, colD, random_)
///@param color1
///@param color2
///@param color3
///@param color4
///@author @Trixelized
function fourlimit_set_colors(colA, colB, colC, colD, random_) {
	// This script sets (or changes) the colors to use for the shdFourLimit shader
	// You can run this more than once!
	
	// The shader to use
	var _shd_ = shd_four_limit;
	
	// Get the uniforms the shader uses. This isn't intensive
	var unif_col_a = shader_get_uniform(_shd_, "col_a");
	var unif_col_b = shader_get_uniform(_shd_, "col_b");
	var unif_col_c = shader_get_uniform(_shd_, "col_c");
	var unif_col_d = shader_get_uniform(_shd_, "col_d");
	var randomness = shader_get_uniform(_shd_, "rando");
	if (random_ == true) var rand_ = random_range(2000, 80000)
	else  var rand_ = 8468.648;
	
	shader_set(_shd_);
	
	// Now we simply set the uniforms to the correct values!
	shader_set_uniform_f(unif_col_a,
		color_get_red(colA)/255, color_get_green(colA)/255, color_get_blue(colA)/255);
	shader_set_uniform_f(unif_col_b,
		color_get_red(colB)/255, color_get_green(colB)/255, color_get_blue(colB)/255);
	shader_set_uniform_f(unif_col_c,
		color_get_red(colC)/255, color_get_green(colC)/255, color_get_blue(colC)/255);
	shader_set_uniform_f(unif_col_d,
		color_get_red(colD)/255, color_get_green(colD)/255, color_get_blue(colD)/255);
	shader_set_uniform_f(randomness, rand_);
	
	
	shader_reset();
	
}


///@func new_textbox(message, opt_bg_index, [opt_responses])
///@param {string} [message]		array of message to display
///@param {real} opt_bg_index		image_index of bg sprite
///@param {string} [opt_responses]	array of responses
///@returns N/A
function new_textbox(_msg, _bg_index){
	var _tbox = instance_create_layer(0, 0, "Managers", obj_text)
	with (_tbox){
		msg = _msg
		if (instance_exists(other)) origin_instance = other.id
		else origin_instance = noone
		bg_index = _bg_index
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
		case 2: new_textbox("you gave response b! any further response?", 0) break
		case 3: new_textbox("thanks for giving responses", 0) break
		
		default: show_error("dialogue_responses switch statement: something's gone wrong", false) break
	}
}


	

