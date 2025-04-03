extends Node2D

signal hurt

@export var player : CharacterBody2D
@export var player_track:bool
@export var elbow_track:bool
@export var attack:bool
@export var fliptrack:bool
@onready var arm = get_node("Skeleton2D/Hip/Spine/RShoulder/RElbow/ARForearm/Arm")
@onready var anim = get_node("AnimationPlayer")

var ready_attack = false
var move_speed = 25000
var hit_player = false
var health = 1000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_handler(anim);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = get_node("RightHandTarget")
	var player_pos = target.global_position
	var elbow = get_node("RightElbowTarget");
	if(player_track == true):
		player_pos = player.global_position
		target.global_position = player_pos
		#print(player_pos)
	if(elbow_track == true):
		elbow.global_position = elbow.global_position.move_toward(target.global_position, delta*move_speed)
	if(player.global_position.x > self.global_position.x && fliptrack==true):
		self.scale.x = 2
		get_node("Skeleton2D/Hip/Base").scale.x = 0.705
	elif(fliptrack==true):
		self.scale.x = -2
		get_node("Skeleton2D/Hip/Base").scale.x = -0.705

func animation_handler(anim: AnimationMixer) -> void:
	var attacks = anim.get_animation_list()
	#print(attacks)
	var loop = true
	while(loop==true):
		if(health <= 0):
			loop = false
		if(ready_attack == false && loop == true):
			for i in range(randi_range(0, 3)):
				#print(i)
				anim.play("BossIdle")
				await anim.animation_finished
				
			ready_attack = true
		elif(ready_attack == true && loop == true):
			var attack = randi_range(1,2)
			if(self.global_position.distance_to(player.global_position) < 3500):
				if(attack == 1):
					anim.play("BossAttack1")
				elif(attack == 2):
					anim.play("BossAttack2")
				await anim.animation_finished
				ready_attack = false
				hit_player = false
			else:
				anim.play("BossIdle")
				await anim.animation_finished
	anim.play("BossDeath")
	await anim.animation_finished
	anim.play("BossDead")
		

func attacking(body) -> void:
	print(body.name)
	if(attack == true && hit_player == false):
		#insert attack code here when health is ready
		
		#if(arm == player):
		print("weeee")
	#var arm = get_node("Skeleton2D/Hip/Spine/RShoulder/RElbow/ARForearm/Area2D")
	#print(arm.name)
	
	pass


func _on_arm_body_entered(body: Node2D) -> void:

	if(attack == true && hit_player == false && body.name == "MainCharacterBody"):
		print("hurt")
		hurt.emit(34)


func _on_attack_state_did_an_attack(in_damage) -> void:
	health -= in_damage
	print(health)
	pass # Replace with function body.
