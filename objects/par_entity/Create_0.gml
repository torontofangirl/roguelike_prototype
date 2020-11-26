image_speed = 0

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
			
			if (entity_activate_script != -1){
				script_execute_ext(entity_activate_script, entity_activate_args)

				if (entity_npc){
					direction = point_direction(x, y, obj_player.x, obj_player.y)
					image_index = CARDINAL_DIR
				}
			}
			
			state_switch("idle")
		}
	}
)


