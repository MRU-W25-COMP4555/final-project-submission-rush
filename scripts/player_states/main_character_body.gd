extends CharacterBody2D

@export var SPEED = 900.0
@export var JUMP_VELOCITY = -2500.0
@export var AIR_ACC = 100.0



var current_state
var last_facing_direction = 1
var health = 100
var stun = false
var jumps = 2
var jump_buffer = 0.0
var playerinvul = 0.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_sprite: Sprite2D = $Sprite2D
@onready var attack_dir = get_node("Attack");

#handling player interaction
@onready var actionable_finder: Area2D = $ActionableFinder
@onready var interaction_collision: CollisionShape2D = $ActionableFinder/CollisionShape2D

func _ready():
	change_state("idle_state", animation_player)  # ✅ No shadowing issue

func change_state(new_state_name: String, anim_player: AnimationPlayer):  # Renamed parameter
	#print(new_state_name)
	if current_state:
		current_state.exit_state()

	current_state = get_node(new_state_name)

	if current_state:
		current_state.enter_state(self, anim_player)  # Use renamed parameter

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		last_facing_direction = direction

	if not is_on_floor():
		velocity += get_gravity() * 4 * delta
	else:
		jumps = 2

	if current_state:
		current_state.handle_input(delta)
	
	move_and_slide()

	if direction >= 1:
		#going right
		player_sprite.flip_h = false
		attack_dir.scale.x = 1
		interaction_collision.position.x = 150
	elif direction <= -1:
		#going left
		player_sprite.flip_h = true
		attack_dir.scale.x = -1
		interaction_collision.position.x = -150


func _on_boss_hurt(damage) -> void:
	
	health = health - damage
	#current_state.enter_state("damage_state", animation_player)
	print(health)
	interaction_collision.position.x = -150
		

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return


func _on_world_boundary_hurt(damage) -> void:
	health = health - damage
	#current_state.enter_state("damage_state", animation_player)
	print(health)
	interaction_collision.position.x = -150
