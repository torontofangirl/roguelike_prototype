if (keyboard_check(ord("C"))) create_room(obj_player.x div TILE_SIZE, obj_player.y div TILE_SIZE, 10, 10)

#region tile level
// 1 buffer on each side so that we can check tiles "outside" the grid
for (var _y = 1; _y < grid_h - 1; _y++){
	for (var _x = 1; _x < grid_w - 1; _x++){
		if (level_data[_x][_y].type != FLOOR){
			var _north_tile = level_data[_x][_y - 1].type == VOID //returns true if void else return false
			var _west_tile = level_data[_x - 1][_y].type == VOID
			var _east_tile = level_data[_x + 1][_y].type == VOID
			var _south_tile = level_data[_x][_y + 1].type == VOID
			
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


