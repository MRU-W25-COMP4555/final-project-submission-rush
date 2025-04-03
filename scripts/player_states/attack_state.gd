
extends  player_state

signal did_an_attack

var attacking = false
# Plays attack animation and stops player movement
func enter_state(player_node, animation_player):
	super(player_node, animation_player)
	attacking = true
	var attack_speed = sqrt((player.velocity.x * player.velocity.x) + (player.velocity.y * player.velocity.y))/200 + 10
	print(player.get_node("Attack/Player").get_overlapping_areas())
	
	
	did_an_attack.emit(attack_speed)
	animation.play("attack")
# handles state transitions
func handle_input(_delta):
	await animation.animation_finished
	attacking = false
	if player.stun == true:
		player.change_state("damage_state", animation)
	elif Input.is_action_just_pressed("ui_accept"):
		player.change_state("jumping_state", animation)
	else:
		player.change_state("idle_state", animation)
