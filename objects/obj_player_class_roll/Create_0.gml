event_inherited()

state.add("idle", {
	enter: function() {
		sprite_index = spr_idle
	},
	step: function() {
		if (input_magnitude != 0) state_switch("walk")
			
		if (controls.interact && !instance_exists(obj_text) && get_current_state(id) != "locked") check_entity()
			
		if (controls.dash && get_current_state(id) != "locked") state_switch("roll")
	}
})
state.add("walk", {
	step: function() {
		hsp = lengthdir_x(input_magnitude * walksp, input_direction)
		vsp = lengthdir_y(input_magnitude * walksp, input_direction)
			
		move_and_collide()
			
		var _old_sprite = sprite_index
			
		if (input_magnitude != 0){
			direction = input_direction
			sprite_index = spr_walk
		}
		else state_switch("idle")
			
		if (_old_sprite != sprite_index) local_frame = 0
		animate()
			
		if (controls.dash && get_current_state(id) != "locked") state_switch("roll")
	}
})
state.add("roll", {
	enter: function(){
		roll_distance_remaining = roll_distance
		sprite_index = spr_roll
	},
	step: function(){
		hsp = lengthdir_x(rollsp, direction)
		vsp = lengthdir_y(rollsp, direction)
			
		roll_distance_remaining = max(0, roll_distance_remaining - rollsp)
		var _collided = move_and_collide()
			
		var _total_frames = sprite_get_number(sprite_index) / 4
		image_index = (CARDINAL_DIR * _total_frames) + min(((1 - (roll_distance_remaining / roll_distance)) * _total_frames), _total_frames - 1)
			
		if (roll_distance_remaining <= 0){
			state_switch("idle")
		}
	}
})
