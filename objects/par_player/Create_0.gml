image_speed = 0
sprite_index = spr_player

hsp = 0
vsp = 0
walksp = 2
rollsp = 3
roll_distance = 96

spr_walk = spr_player_walk
spr_idle = spr_player
spr_roll = spr_player_roll

//image index, but for our direction
local_frame = 0

///@func check_entity()
///@returns N/A
check_entity = function(){
	var _inst = instance_place(x, y, par_entity)
	with (_inst) state_switch("interact")
}

///@func move_and_collide()
///@returns N/A
move_and_collide = function(){
	var _collision = false

	x += hsp;

	// Horizontal collisions
	if hsp > 0 {
		if (grid_meeting(id, obj_level.level_data)) {
			_collision = true
			//x = bbox_right&~(TILE_SIZE-1);
			x = (bbox_right div TILE_SIZE) * TILE_SIZE
			x -= bbox_right-x;
			hsp = 0;
		}
	} else if hsp < 0 {
		// Left collisions
		if (grid_meeting(id, obj_level.level_data)) {
			_collision = true
			//x = bbox_left&~(TILE_SIZE-1);
			x = (bbox_left div TILE_SIZE) * TILE_SIZE
			x += x-bbox_left + TILE_SIZE;
			hsp = 0;
		}
	}

	// Move vertically
	y += vsp;

	// Vertical collisions
	if vsp > 0 {
		// Bottom collisions
		if (grid_meeting(id, obj_level.level_data)) {
			_collision = true
			y = (bbox_bottom div TILE_SIZE) * TILE_SIZE
			y -= bbox_bottom-y;
			vsp = 0;
		}
	} else if vsp < 0 {
		// Top collisions
		if (grid_meeting(id, obj_level.level_data)) {
			_collision = true
			y = (bbox_top div TILE_SIZE) * TILE_SIZE
			y += TILE_SIZE+y-bbox_top;
			vsp = 0;
		}
	}

	return _collision
}

///@func animate()
///@returns N/A
animate = function() {
	var _total_frames = sprite_get_number(sprite_index) / 4
	image_index = local_frame + (CARDINAL_DIR * _total_frames)

	local_frame += sprite_get_speed(sprite_index) / FPS

	//if animation would loop
	if (local_frame >= _total_frames){
		animation_end = true
		local_frame -= _total_frames
	}
	else animation_end = false
}

state = new StateMachine("idle")

state.add("locked", {
	//complicated ik
})
state.add("idle", {
	enter: function() {
		sprite_index = spr_idle
	},
	step: function() {
		if (input_magnitude != 0) state_switch("walk")
			
		if (controls.interact && !instance_exists(obj_text) && get_current_state(id) != "locked") check_entity()
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
	}
})
