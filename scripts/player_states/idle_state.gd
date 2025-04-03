
extends player_state



# function stops player and plays the idle animation
func enter_state(player_node, animation_player):
	super(player_node, animation_player)

	animation.play("idle")
	
# Idle event handling
# allows for jumping, moving, dashing, falling and attacking from idle. 
func handle_input(_delta):
	player.playerinvul += _delta
	if player.is_on_floor:
		player.velocity.x = clamp(player.velocity.x - player.velocity.x * 5 * _delta , -9000, 9000)
		if player.velocity.x > 100: animation.play("stop")
		else: animation.play("idle")
	elif not player.is_on_floor:
		player.velocity.x = clamp(player.velocity.x - player.velocity.x * 2 * _delta, -9000, 9000)
	if player.stun == true:
		player.change_state("damage_state", player.animation_player)
	elif Input.is_action_just_pressed("ui_q"):
		player.change_state("dashing_state", animation)
	elif Input.is_action_just_pressed("ui_accept") && player.jumps > 0:
		player.change_state("jumping_state", player.animation_player) 
	elif Input.get_axis("ui_left", "ui_right") != 0:
		player.change_state("moving_state", player.animation_player)  
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		player.change_state("attack_state", player.animation_player) 
	elif !player.is_on_floor():
		player.change_state("falling_state", player.animation_player)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		player.get_node("Camera2D").zoom.x += 0.1
		player.get_node("Camera2D").zoom.y += 0.1
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
		player.get_node("Camera2D").zoom.x -= 0.1
		player.get_node("Camera2D").zoom.y -= 0.1


func _on_boss_hurt(damage) -> void:
	player.health = clamp(player.health - damage, 0, 100)
	player.stun = true
	print(player.health)
	
func _on_world_boundary_hurt(damage) -> void:
	player.health = clamp(player.health - damage, 0, 100)
	player.stun = true
	print(player.health)
