extends player_state

#var jump_count = 0

# plays falling animation and sets up the double jump counter
func enter_state(player_node, animation_player):
	super(player_node, animation_player)
	#jump_count = 0;
	animation.play("fall")

# Handles transitions to other states 
func handle_input(_delta):


	if player.stun == true:
		player.change_state("damage_state", animation)
	elif Input.is_action_just_pressed("ui_accept") && player.jumps > 0:
		player.change_state("jumping_state", animation)
	elif Input.is_action_just_pressed("ui_q"):
		player.change_state("dashing_state", animation)
	elif Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right"):
		player.change_state("moving_state", animation);
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		player.change_state("attack_state", player.animation_player) 
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		player.change_state("attack_state", player.animation_player) 
		#jump_count += 1 # Double jump increment
	elif player.is_on_floor():
		player.jumps = 2
		player.change_state("idle_state", animation)
	else:
		player.change_state("falling_state", animation)
