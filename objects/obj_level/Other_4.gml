grid_w = room_width / TILE_SIZE
grid_h = room_height / TILE_SIZE
grid = ds_grid_create(grid_w, grid_h)

var _wall_map = layer_tilemap_get_id(layer_get_id("Walls"))

ds_grid_set_region(grid, 0, 0, grid_w, grid_h, VOID)

var _walkers = []
var _walkers_amount = irandom_range(1, 3)

instance_create_layer(room_width / 2, room_height / 2, "Player", obj_player)

for (var _i = 0; _i < _walkers_amount; _i++){
	_walkers[_i] = {
		x: grid_w / 2,
		y: grid_h / 2,
		dir: irandom(3),
		steps: irandom_range(150, 200),
		change_dir_chance: 0.33,
		steps_since_turn: 0
	}
	randomize()
}

function create_room(_x_pos, _y_pos){
	var _x_size = irandom_range(2, 4)
	var _y_size = irandom_range(2, 4)
	
	var _top_left_x = round(_x_pos - (_x_size / 2))
	var _top_left_y = round(_y_pos - (_y_size / 2))
	
	for (var _y = 0; _y < _y_size; _y++){
		for (var _x = 0; _x < _x_size; _x++){
			var _new_step_x = _top_left_x + _x
			var _new_step_y = _top_left_y + _y
			
			//if inside border
			if ((_new_step_x > 3) && (_new_step_x <= grid_w - 3)){
				if ((_new_step_y > 3) && (_new_step_y <= grid_h - 3)){
					grid[# _new_step_x, _new_step_y] = FLOOR
				}
			}
		}
	}
}

for (var _i = 0; _i < _walkers_amount; _i++){
	create_room(_walkers[_i].x, _walkers[_i].y)
	repeat (_walkers[_i].steps){
		grid[# _walkers[_i].x, _walkers[_i].y] = FLOOR
		
		_walkers[_i].steps_since_turn++
	
		//random dir
		if (chance(_walkers[_i].change_dir_chance) && (_walkers[_i].steps_since_turn >= 6)){
			_walkers[_i].dir = irandom(3)
			create_room(_walkers[_i].x, _walkers[_i].y)
		}
	
		//move walker
		var _x_dir = lengthdir_x(1, _walkers[_i].dir * 90)
		var _y_dir = lengthdir_y(1, _walkers[_i].dir * 90)
	
		_walkers[_i].x += _x_dir
		_walkers[_i].y += _y_dir
	
		//prevent go outside grid
		if (_walkers[_i].x < 3) || (_walkers[_i].x >= grid_w - 3){
			//jump walker back to previous square
			_walkers[_i].x += -_x_dir * 2
		}
	
		if (_walkers[_i].y < 3) || (_walkers[_i].y >= grid_h - 3){
			//jump walker back to previous square
			_walkers[_i].y += -_y_dir * 2
		}
	}
	randomize()
}


#region //remove single tiles
for (var _y = 1; _y < grid_h - 1; _y++){
	for (var _x = 1; _x < grid_w - 1; _x++){
		if (grid[# _x, _y] != FLOOR){
			var _north_tile = grid[# _x, _y - 1] == VOID //returns true if void else return false
			var _west_tile = grid[# _x - 1, _y] == VOID
			var _east_tile = grid[# _x + 1, _y] == VOID
			var _south_tile = grid[# _x, _y + 1] == VOID
			
			//+1 because tiles are not 0-indexed
			var _tile_index = NORTH * _north_tile + WEST * _west_tile + EAST * _east_tile + SOUTH * _south_tile + 1		
			
			if (_tile_index == 1){ //if no tiles beside me (read the line above)
				grid[# _x, _y] = FLOOR
			}
		}
	}
}
#endregion

#region //tile level
for (var _y = 1; _y < grid_h - 1; _y++){
	for (var _x = 1; _x < grid_w - 1; _x++){
		if (grid[# _x, _y] != FLOOR){
			var _north_tile = grid[# _x, _y - 1] == VOID //returns true if void else return false
			var _west_tile = grid[# _x - 1, _y] == VOID
			var _east_tile = grid[# _x + 1, _y] == VOID
			var _south_tile = grid[# _x, _y + 1] == VOID
			
			//+1 because tiles are not 0-indexed
			var _tile_index = NORTH * _north_tile + WEST * _west_tile + EAST * _east_tile + SOUTH * _south_tile + 1
			
			tilemap_set(_wall_map, _tile_index, _x, _y)

		}
	}
}
#endregion






