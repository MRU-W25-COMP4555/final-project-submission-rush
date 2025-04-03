
extends player_state


func enter_state(player_node, animation_player):
	super(player_node, animation_player)
	player.jump_buffer = 0
	player.velocity.y = player.JUMP_VELOCITY
	animation.play("jump")
	player.jumps -= 1

func handle_input(_delta):
	player.jump_buffer += _delta

	if player.stun == true:
		player.change_state("damage_state", animation)
	elif player.is_on_floor():
		player.change_state("idle_state", animation)
	elif Input.is_action_just_pressed("ui_q"):
		player.change_state("dashing_state", animation)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		player.change_state("attack_state", player.animation_player) 
	elif Input.is_action_just_pressed("ui_accept") && player.jumps > 0 && player.jump_buffer >= 0.25:
		player.change_state("jumping_state", animation)
	elif ! player.is_on_floor() && Input.get_axis("ui_left", "ui_right") == 0:
		#await animation.animation_finished
		player.change_state("falling_state", animation)
	
