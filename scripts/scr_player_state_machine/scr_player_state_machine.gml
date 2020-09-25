// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function playerstate_free(){
	hsp = lengthdir_x(input_magnitude * movesp, input_direction)
	vsp = lengthdir_y(input_magnitude * movesp, input_direction)

	player_collision()

	depth = -bbox_bottom


	var _old_sprite = sprite_index

	if (input_magnitude != 0){
		direction = input_direction
		sprite_index = spr_run
	}
	else sprite_index = spr_idle

	if (_old_sprite != sprite_index) local_frame = 0

	player_animate_sprite()
	

	if (key_activate){
		//check for entity	
		var _entity_radius = 30
		activate = collision_rectangle(x - _entity_radius,
									   y - _entity_radius,
									   x + _entity_radius,
									   y + _entity_radius,
									   par_entity,
									   false,
									   true
									   )
		
		//if nothing to execute/nothing
		if ((activate == noone) || (activate.entity_activate_script == -1)){
			state = playerstate_roll
			move_distance_remaining = roll_distance
		}
		else{ //activate
			script_execute_array(activate.entity_activate_script, activate.entity_activate_args)
		
			//face player cuz npc
			if (activate.entity_npc){
				with (activate){
					direction = point_direction(x, y, other.x, other.y)
					image_index = CARDINAL_DIR
				}
			}
		}
	}
}

function playerstate_roll(){
	#region //movement
	hsp = lengthdir_x(rollsp, direction)
	vsp = lengthdir_y(rollsp, direction)

	move_distance_remaining = max(0, move_distance_remaining - rollsp)

	var _collided = player_collision()
	#endregion

	#region //update sprite
	sprite_index = spr_roll
	var _total_frames = sprite_get_number(sprite_index) / 4
	image_index = (CARDINAL_DIR * _total_frames) + min(((1 - (move_distance_remaining / roll_distance)) * _total_frames), _total_frames - 1)
	#endregion

	//change state
	if (move_distance_remaining <= 0){
		state = playerstate_free	
	}
	
	if (_collided){
		state = playerstate_bonk
		move_distance_remaining = bonk_distance
		screen_shake(8, 30)
	}
}

function playerstate_locked(){
	//most complicated state	
}

