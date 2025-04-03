
extends  player_state

# Enter state knocks player back, resets speed and Jump velocity and plays damage animation
# then changes state to idle
func enter_state(player_node, animation_player):
	super(player_node, animation_player)
	if player.health > 0:
		if(player.SPEED <= 1800.0): player.SPEED = 900.0
		else: player.SPEED = player.SPEED/2
		if(player.JUMP_VELOCITY >= -1200.0): player.JUMP_VELOCITY = -600.0
		else: player.JUMP_VELOCITY = player.JUMP_VELOCITY/2
		player.velocity.x = player.last_facing_direction * -300
		animation.play("damage")
	#                                                        await animation.animation_finished
		player.stun = false
		player.change_state("idle_state", animation)
	else:
		animation.play("dead")
		await animation.animation_finished
		get_tree().reload_current_scene()
		#end everything here
		pass
