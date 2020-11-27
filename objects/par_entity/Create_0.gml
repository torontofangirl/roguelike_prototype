image_speed = 0

entity_function = -1
entity_function_args = [-1]
entity_collision = false
entity_npc = false

state = new StateMachine("idle",
	//idle state
	"idle", {
		enter: function() {
			
		},
		
		step: function(){
			
		}
	},

	//Opened state
	"interact", {
		enter: function() {
			image_index = 0
			
			if (entity_function != -1){
				script_execute_ext(entity_function, entity_function_args)

				if (entity_npc){
					direction = point_direction(x, y, obj_player.x, obj_player.y)
					image_index = CARDINAL_DIR
				}
			}
			
			state_switch("idle")
		}
	}
)


