if (keyboard_check_pressed(ord("C"))){
	create_room(obj_player.x / TILE_SIZE, obj_player.y / TILE_SIZE, 3, 3)
}

#region //tile level
for (var _y = 1; _y < grid_h - 1; _y++){
	for (var _x = 1; _x < grid_w - 1; _x++){
		if (grid[# _x, _y].type != FLOOR){
			var _north_tile = grid[# _x, _y - 1].type == VOID //returns true if void else return false
			var _west_tile = grid[# _x - 1, _y].type == VOID
			var _east_tile = grid[# _x + 1, _y].type == VOID
			var _south_tile = grid[# _x, _y + 1].type == VOID
			
			//+1 because tiles are not 0-indexed
			var _tile_index = NORTH * _north_tile + WEST * _west_tile + EAST * _east_tile + SOUTH * _south_tile + 1
			
			tilemap_set(wall_map, _tile_index, _x, _y)
		}
		else{
			tilemap_set(wall_map, 0, _x, _y)
		}
	}
}
#endregion


