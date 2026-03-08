extends CharacterBody2D

class_name player

@onready var animation_timer = $animation_timer

@onready var wizard_sprite = $wizard_sprite
@export var x_int: float = 1.1
@export var y_int: float = 0.9
@export var sine_multi: float = 0.1

var walking_rotation: float = 15.0

var speed: int = 200
var count: float = 0.0

func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	if velocity != Vector2(0.0,0.0):
		walking_movements()
	else:
		wizard_sprite.rotation = 0.0
		animation_timer.stop()
	move_and_slide()
	squash_movement()
	count += 0.1
	if count == 10.0:
		count = 0

func squash_movement():
	wizard_sprite.scale.x = (sin(count) * sine_multi) + x_int
	wizard_sprite.scale.y = (sin(count+3) * sine_multi) + y_int

func walking_movements():
	if wizard_sprite.rotation_degrees == 0.0:
		wizard_sprite.rotation_degrees = walking_rotation
	if animation_timer.time_left != 0:
		return
	animation_timer.start()

func _on_animation_timer_timeout() -> void:
	wizard_sprite.rotation_degrees = wizard_sprite.rotation_degrees * -1
	
