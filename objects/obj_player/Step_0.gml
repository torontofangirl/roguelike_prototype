#region//vars
key_left = keyboard_check(ord("A")) || keyboard_check(vk_left)
key_right = keyboard_check(ord("D")) || keyboard_check(vk_right)
key_up = keyboard_check(ord("W")) || keyboard_check(vk_up)
key_down = keyboard_check(ord("S")) || keyboard_check(vk_down)
key_activate = keyboard_check_pressed(vk_space)

input_direction = point_direction(0, 0, key_right - key_left, key_down - key_up)
input_magnitude = (key_right - key_left != 0) || (key_down - key_up != 0)
#endregion

if (!global.game_paused) state()

depth = -bbox_bottom


