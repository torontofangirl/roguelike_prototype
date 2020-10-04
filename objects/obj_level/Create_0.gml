grid_w = room_width / TILE_SIZE
grid_h = room_height / TILE_SIZE
grid = ds_grid_create(grid_w, grid_h)

function grid_place_meeting(_object, _grid){
	var _top_right = _grid[# (_object.bbox_right - 1) / TILE_SIZE, _object.bbox_top / TILE_SIZE] == VOID
	var _top_left = _grid[# _object.bbox_left / TILE_SIZE, _object.bbox_top / TILE_SIZE] == VOID
	var _bottom_right = _grid[# (_object.bbox_right - 1) / TILE_SIZE, (_object.bbox_bottom - 1) / TILE_SIZE] == VOID
	var _bottom_left = _grid[# _object.bbox_left / TILE_SIZE, (_object.bbox_bottom - 1) / TILE_SIZE] == VOID

	return _top_right || _top_left || _bottom_right || _bottom_left
}


