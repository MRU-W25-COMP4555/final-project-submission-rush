extends CharacterBody2D


@export var player: CharacterBody2D
@export var SPEED: int = 400
@export var CHASE_SPEED: int = 600
@export var ACCELERATION: int = 400


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $AnimatedSprite2D/RayCast2D
@onready var timer: Timer = $AnimatedSprite2D/Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var kill_shape: CollisionShape2D = $Killzone/CollisionShape2D



var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2
var right_bounds: Vector2
var left_bounds: Vector2
var health = 100

enum States{
	WANDER,
	CHASE
}

var current_state = States.WANDER


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_bounds = self.position + Vector2(-250, 0)
	right_bounds = self.position + Vector2(250, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()



func look_for_player():
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider == player:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()


func chase_player() -> void:
	timer.stop()
	current_state = States.CHASE

func stop_chase() -> void:
	if timer.time_left <=0:
		timer.start()


func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)

	move_and_slide()

func change_direction() -> void:
	if current_state == States.WANDER && health > 0:
		if animated_sprite_2d.flip_h:
			#moving right
			if self.position.x <= right_bounds.x:
				direction = Vector2(1, 0)
			else:
				# flip to moving left
				animated_sprite_2d.flip_h = false
				ray_cast_2d.target_position = Vector2(-200, 0)
				collision_shape_2d.position.x = 11
				kill_shape.position.x = -50
		else:
			# moving left
			if self.position.x >= left_bounds.x:
				direction = Vector2(-1, 0)
			else:
				#flip to moving right
				animated_sprite_2d.flip_h = true
				ray_cast_2d.target_position = Vector2(200, 0)
				collision_shape_2d.position.x = -11
				kill_shape.position.x = 50
	elif health > 0:
		#following player
		direction = (player.position - self.position).normalized()
		direction = sign(direction)
		if direction.x == 1:
			#flip to moving right
			animated_sprite_2d.flip_h = true
			ray_cast_2d.target_position = Vector2(200, 0)
			collision_shape_2d.position.x = 11
			kill_shape.position.x = 50
		else:
			# flip to moving left
			animated_sprite_2d.flip_h = false
			ray_cast_2d.target_position = Vector2(-200, 0)
			collision_shape_2d.position.x = -11
			kill_shape.position.x = -50
	else:
		pass


func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


func _on_timer_timeout():
	current_state = States.WANDER


func _on_attack_state_did_an_attack(damage) -> void:
	pass
	#health -= damage
	
