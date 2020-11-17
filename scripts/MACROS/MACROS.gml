#macro CAM view_camera[0]
#macro CAM_X camera_get_view_x(CAM)
#macro CAM_Y camera_get_view_y(CAM)
#macro CAM_W camera_get_view_width(CAM)
#macro CAM_H camera_get_view_height(CAM)
#macro CAM_CX (camera_get_view_x(CAM) + camera_get_view_width(CAM) / 2)
#macro CAM_CY (camera_get_view_y(CAM) + camera_get_view_height(CAM) / 2)

#macro FPS 60
#macro TILE_SIZE 32
#macro CARDINAL_DIR round(direction / 90)

#macro ROOM_START rm_game

//random generation
#macro FLOOR -5
#macro VOID -6

#macro NORTH 1
#macro WEST 2
#macro EAST 4
#macro SOUTH 8





