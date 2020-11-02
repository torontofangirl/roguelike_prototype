if (room == rm_game){
	instance_create_layer(room_width / 2, room_height / 2, "Player", obj_player)
	instance_create_layer(0, 0, "Level", obj_level)
	instance_create_layer(0, 0, "Managers", obj_camera)
	instance_create_layer(0, 0, "Lighting", obj_lighting)
}
