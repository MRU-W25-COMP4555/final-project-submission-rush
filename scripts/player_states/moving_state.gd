extends player_state


# Handles input within movement state. allows dashing, jumping, running, and idle
# Add to if block if more behaviour is desired
func handle_input(_delta):
	var direction := Input.get_axis("ui_left", "ui_right")
		
	if player.stun == true:
		player.change_state("damage_state", animation)
	elif Input.is_action_just_pressed("ui_accept") && player.jumps > 0:
		player.change_state("idle_state", animation)
		player.change_state("jumping_state", animation)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		player.change_state("attack_state", player.animation_player) 
	elif Input.is_action_just_pressed("ui_q"):
		player.change_state("dashing_state", animation)
	elif direction != 0:
		
		if player.is_on_floor():
			player.velocity.x = direction * player.SPEED
			animation.play("run")
		else:
			player.velocity.x = player.velocity.x + direction * player.SPEED * 0.8 * _delta
			animation.play("fall")
			
	else:
		player.change_state("idle_state", animation)
	 	

	
	
