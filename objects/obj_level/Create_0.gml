grid_w = room_width / TILE_SIZE
grid_h = room_height / TILE_SIZE
grid = ds_grid_create(grid_w, grid_h)
rooms = ds_list_create() //ds_list containing structs with room info

wall_map = layer_tilemap_get_id(layer_get_id("Walls_Tile"))

var _walkers = []
var _walkers_amount = 2

///@func WallTile(type)
///@param {real} type			type of tile wall/floor
WallTile = function(_type) constructor{
	type = _type
}

///@func create_room(x_pos, y_pos, x_size, y_size)
///@param {real} x_pos			x_pos of the point to create the room around (GRID COORDS!)
///@param {real} y_pos			y_pos of the point to create the room around (GRID COORDS!)
///@param {real} x_pos			x_size of the room
///@param {real} y_pos			y_size of the room
///@returns N/A
create_room = function(_x_pos, _y_pos, _x_size, _y_size){
	ds_list_add(rooms, {x_pos: _x_pos, y_pos: _y_pos, x_size: _x_size, y_size: _y_size})
	
	var _top_left_x = round(_x_pos - (_x_size / 2))
	var _top_left_y = round(_y_pos - (_y_size / 2))
	
	for (var _y = 0; _y < _y_size; _y++){
		for (var _x = 0; _x < _x_size; _x++){
			var _new_step_x = _top_left_x + _x
			var _new_step_y = _top_left_y + _y
			
			//if inside border
			if ((_new_step_x > 3) && (_new_step_x <= grid_w - 3)){
				if ((_new_step_y > 3) && (_new_step_y <= grid_h - 3)){
					grid[# _new_step_x, _new_step_y].type = FLOOR
				}
			}
		}
	}
	
	static amount = 0
	amount++
	show_debug_message(amount)
}

///@func get_end_room()
///@returns
///Gets room furthest away from beginning location
get_end_room = function(){
	var _end_room = rooms[| 1]
	
	for (var _i = 0; _i < ds_list_size(rooms); _i++){
		var _room = rooms[| _i]
		if (point_distance(grid_w / 2, grid_h / 2, _room.x_pos, _room.y_pos) > point_distance(grid_w / 2, grid_h / 2, _end_room.x_pos, _end_room.y_pos)){
			_end_room = _room
		}
	}
	
	return _end_room
}

for (var _y = 0; _y < grid_h; _y++){
	for (var _x = 0; _x < grid_w; _x++){
		grid[# _x, _y] = new WallTile(VOID, 120)
	}
}

for (var _i = 0; _i < _walkers_amount; _i++){
	_walkers[_i] = {
		x: grid_w / 2,
		y: grid_h / 2,
		dir: irandom(3),
		steps: irandom_range(75, 100),
		change_dir_chance: 0.4,
		steps_since_turn: 0
	}
	randomize()
}

for (var _i = 0; _i < _walkers_amount; _i++){
	create_room(_walkers[_i].x, _walkers[_i].y, 3, 3)

	repeat (_walkers[_i].steps){
		grid[# _walkers[_i].x, _walkers[_i].y].type = FLOOR
		
		_walkers[_i].steps_since_turn++
	
		//random dir
		if (chance(_walkers[_i].change_dir_chance) && (_walkers[_i].steps_since_turn >= 4) && chance(0.4)){
			_walkers[_i].dir = irandom(3)
			create_room(_walkers[_i].x, _walkers[_i].y, 3, 3)
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
		if (grid[# _x, _y].type != FLOOR){
			var _north_tile = grid[# _x, _y - 1].type == VOID //returns true if void else return false
			var _west_tile = grid[# _x - 1, _y].type == VOID
			var _east_tile = grid[# _x + 1, _y].type == VOID
			var _south_tile = grid[# _x, _y + 1].type == VOID
			
			//+1 because tiles are not 0-indexed
			var _tile_index = NORTH * _north_tile + WEST * _west_tile + EAST * _east_tile + SOUTH * _south_tile + 1		
			
			if (_tile_index == 1){ //if no tiles beside me (read the line above)
				grid[# _x, _y].type = FLOOR
			}
		}
	}
}
#endregion

instance_create_layer(get_end_room().x_pos * TILE_SIZE, get_end_room().y_pos * TILE_SIZE, "Entities", obj_exit_door)




