// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function grid_place_meeting(_object, _grid) {

	var _top_right = _grid[# (_object.bbox_right - 1) / TILE_SIZE, _object.bbox_top / TILE_SIZE] == VOID
	var _top_left = _grid[# _object.bbox_left / TILE_SIZE, _object.bbox_top / TILE_SIZE] == VOID
	var _bottom_right = _grid[# (_object.bbox_right - 1) / TILE_SIZE, (_object.bbox_bottom - 1) / TILE_SIZE] == VOID
	var _bottom_left = _grid[# _object.bbox_left / TILE_SIZE, (_object.bbox_bottom - 1) / TILE_SIZE] == VOID

	return _top_right || _top_left || _bottom_right || _bottom_left
}


function player_collision() {
	var _collision = false


	x += hsp;

	// Horizontal collisions
	if hsp > 0 {
		if (grid_place_meeting(id, obj_level.grid)) {
			_collision = true
			x = bbox_right&~(TILE_SIZE-1);
			x -= bbox_right-x;
			hsp = 0;
		}
	} else if hsp < 0 {
		// Left collisions
		if (grid_place_meeting(id, obj_level.grid)) {
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
		if (grid_place_meeting(id, obj_level.grid)) {
			_collision = true
			y = bbox_bottom&~(TILE_SIZE-1);
			y -= bbox_bottom-y;
			vsp = 0;
		}
	} else if vsp < 0 {
		// Top collisions
		if (grid_place_meeting(id, obj_level.grid)) {
			_collision = true
			y = bbox_top&~(TILE_SIZE-1);
			y += TILE_SIZE+y-bbox_top;
			vsp = 0;
		}
	}

	return _collision



}