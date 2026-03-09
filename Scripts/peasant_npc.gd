extends CharacterBody2D

@onready var walk_animation_timer = $walk_animation_timer
@onready var panic_sprite = $sprite/panic_animation_sprite
@onready var panic_animation_timer = $panic_animation_timer

@onready var stuck_check = $stuck_check

@onready var sprite = $sprite
@export var x_int: float = 1.1
@export var y_int: float = 0.9
@export var sine_multi: float = 0.1

var panic_speed: int = 300
var panic_timer: float = 0.15
var walk_anim_timer: float = 0.4

var walking_rotation: float = 15.0

var speed: int = 150
var count: float = 0.0

var current_velocity: Vector2

func _ready() -> void:
	panic_sprite.visible = false	
	var init_speed: Array = [-1.0, 1.0]
	#current_velocity = Vector2(init_speed.pick_random(),init_speed.pick_random())
	current_velocity = Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))

func _physics_process(_delta: float) -> void:
	velocity = current_velocity.normalized() * speed
	# possibly add a timer in a non paniced stated to have them lerp and slow down before stopping for a breif moment to add some sort of natural/individual movment to everyone
	if velocity != Vector2(0.0,0.0):
		walking_movements()
	else:
		sprite.rotation = 0.0
		walk_animation_timer.stop()
	move_and_slide()
	squash_movement()
	count += 0.1
	if count == 10.0:
		count = 0
	# panic movement has them running in stright lines in a somewhat fast speed and bouncing off the level boundries randomly
	# default movement has them moving in a slower pace than the paniced state
	# panic starts when the npc recieves a signal and then simply swaps the speed with a new one

func squash_movement():
	sprite.scale.x = (sin(count) * sine_multi) + x_int
	sprite.scale.y = (sin(count+3) * sine_multi) + y_int

func walking_movements():
	if sprite.rotation_degrees == 0.0:
		sprite.rotation_degrees = walking_rotation
	if walk_animation_timer.time_left != 0:
		return
	walk_animation_timer.start(walk_anim_timer)

func randomise_direction():
	#current_velocity = Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))
	#current_velocity = current_velocity * -1
	if current_velocity[0] > 0:
		current_velocity[0] = randf_range(-1.0,0)
	else:
		current_velocity[0] = randf_range(0,1.0)
	if current_velocity[1] > 0:
		current_velocity[1] = randf_range(-1.0,0)
	else:
		current_velocity[1] = randf_range(0,1.0)
	stuck_check.start()

func _on_walk_animation_timer_timeout() -> void:
	sprite.rotation_degrees = sprite.rotation_degrees * -1

func _on_panic_animation_timer_timeout() -> void:
	panic_sprite.visible = !panic_sprite.visible
	panic_animation_timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "floor_wall":
		randomise_direction()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "floor_wall":
		stuck_check.stop()

func _on_stuck_check_timeout() -> void:
	randomise_direction()
