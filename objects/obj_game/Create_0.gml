randomize()

global.game_paused = false
global.text_speed = 0.75
global.camera_id = instance_create_layer(0, 0, "Managers", obj_camera)

display_set_gui_size(WIN_W, WIN_H)

room_goto(ROOM_START)




