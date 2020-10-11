image_speed = 0

hsp = 0
vsp = 0
walksp = 2
dash_distance = 128

spr_walk = spr_player_walk
spr_idle = spr_player
spr_dash = spr_player_dash

//image index, but for our direction
local_frame = 0

check_entity = function(){
	var _inst = instance_place(x, y, par_entity)
	with (_inst) state_switch("interact")
}

move_and_collide = function(){
	var _collision = false

	x += hsp;

	// Horizontal collisions
	if hsp > 0 {
		if (obj_level.grid_place_meeting(id, obj_level.grid)) {
			_collision = true
			x = bbox_right&~(TILE_SIZE-1);
			x -= bbox_right-x;
			hsp = 0;
		}
	} else if hsp < 0 {
		// Left collisions
		if (obj_level.grid_place_meeting(id, obj_level.grid)) {
			_collision = true
			x = bbox_left&~(TILE_SIZE-1);
			x += TILE_SIZE+x-bbox_left;
			hsp = 0;
		}
	}

	// Move vertically
	y += vsp;

	// Vertical collisions
	if vsp > 0 {
		// Bottom collisions
		if (obj_level.grid_place_meeting(id, obj_level.grid)) {
			_collision = true
			y = bbox_bottom&~(TILE_SIZE-1);
			y -= bbox_bottom-y;
			vsp = 0;
		}
	} else if vsp < 0 {
		// Top collisions
		if (obj_level.grid_place_meeting(id, obj_level.grid)) {
			_collision = true
			y = bbox_top&~(TILE_SIZE-1);
			y += TILE_SIZE+y-bbox_top;
			vsp = 0;
		}
	}

	return _collision
}

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

#region statemachine example
/*state = new StateMachine("idle",
	//idle state
	"closed", {
		enter: function() {
			sprite_index = spr_idle
			image_index = 0;
			hsp = 0
			vsp = 0
		},
		
		draw: function() {
		
		}
	},

	//Opened state
	"opened", {
		enter: function() {
			image_index = 1;	
		},
		
		draw: function() {
		
		}
	},

	// Empty state
	"empty", {
		enter: function() {

		}
	}
)*/
#endregion

state = new StateMachine("idle",
	//idle state
	"idle", {
		enter: function() {
			sprite_index = spr_idle
			hsp = 0
			vsp = 0
		},
		
		step: function() {
			if (input_magnitude != 0) state_switch("walk")
			
			if (controls.interact && !instance_exists(obj_text) && (get_current_state(id) != "locked")) check_entity()
			
			if (controls.dash && (get_current_state(id) != "locked")){
				state_switch("dash")
				move_distance_remaining = dash_distance
			}
		}
	},

	//run state
	"walk", {
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
			
			if (controls.interact && !instance_exists(obj_text) && (get_current_state(id) != "locked")) check_entity()
			
			if (controls.dash && (get_current_state(id) != "locked")){
				state_switch("dash")
				move_distance_remaining = dash_distance
			}
		}
	},
	
	//locked state
	"locked", {
		//so complicated	
	},
	
	"dash", {
		
	}
)

