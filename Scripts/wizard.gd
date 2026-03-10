extends CharacterBody2D

class_name player

@onready var walk_anim_timer = $walk_animation_timer
@onready var shoot_anim_timer = $shoot_animation_timer

@onready var wizard_sprite = $wizard_sprite
@export var x_int: float = 1.1
@export var y_int: float = 0.9
@export var sine_multi: float = 0.1

const walking_rotation: float = 15.0

const speed: int = 200
var count: float = 0.0

var shooting: bool = false

func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	if velocity != Vector2(0.0,0.0):
		walking_movements()
	else:
		wizard_sprite.rotation = 0.0
		walk_anim_timer.stop()
	move_and_slide()
	if Input.is_action_just_pressed("LClick"):
		shoot()
	squash_movement()
	count += 0.1
	if count == 10.0:
		count = 0

func squash_movement():
	if not shooting:
		wizard_sprite.scale.x = (sin(count) * sine_multi) + x_int
		wizard_sprite.scale.y = (sin(count+3) * sine_multi) + y_int
	else:
		wizard_sprite.scale.x = (sin(count+3) * sine_multi) + y_int
		wizard_sprite.scale.y = (sin(count+1.0) * sine_multi) + x_int

func walking_movements():
	if wizard_sprite.rotation_degrees == 0.0:
		wizard_sprite.rotation_degrees = walking_rotation
	if walk_anim_timer.time_left != 0:
		return
	walk_anim_timer.start()

func shoot():
	shooting = true
	shoot_anim_timer.start()

func _on_walk_animation_timer_timeout() -> void:
	wizard_sprite.rotation_degrees = wizard_sprite.rotation_degrees * -1

func _on_shoot_animation_timer_timeout() -> void:
	shooting = false
