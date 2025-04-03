extends player_state

const DASH_SPEED = 2500.0
const DASH_DURATION = 0.2
const COOLDOWN = 0.5
var dash_timer = 0.0
var cooldown = 0.0
var direction = 0

# Enters dash state and plays dash animation
func enter_state(player_node, animation_player):
	super(player_node, animation_player)
	direction = Input.get_axis("ui_left", "ui_right")

	#if direction == 0:
	direction = player.last_facing_direction
		
		# Each dash increases player speed slightly
	player.velocity = player.velocity + Vector2(direction * DASH_SPEED, 0)
	#player.velocity.y = 
	player.SPEED = clamp(player.SPEED + (DASH_SPEED / 20), player.SPEED, 5 * player.SPEED)
	player.JUMP_VELOCITY = clamp(player.JUMP_VELOCITY - (DASH_SPEED / 50), 5 * player.JUMP_VELOCITY, player.JUMP_VELOCITY)

	dash_timer = DASH_DURATION
	animation.play("dash")

# handles state transitions
func handle_input(_delta):
	await animation.animation_finished
	var vel = Vector2(0,0)
	dash_timer -= _delta
	if player.stun == true:
		player.change_state("damage_state", animation)
	#elif dash_timer <= 0.01 && dash_timer >= 0:
	#	vel = player.get_real_velocity
	elif dash_timer <= 0:

		if Input.get_axis("ui_left", "ui_right") != 0:
			player.change_state("moving_state", animation)
		else:
			if player.is_on_floor():
				player.change_state("idle_state", animation)
			else:
				player.change_state("falling_state", animation)
	
