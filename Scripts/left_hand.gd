extends Sprite2D

@export var x_int: float = 1.1
@export var y_int: float = 0.9
@export var sine_multi: float = 0.04
@export var sin_speed: float = 1

var count: float = 0.0

func _physics_process(_delta: float) -> void:
	squash_and_stretch()
	count += 0.1
	if count == 10.0:
		count = 0

func squash_and_stretch():
	self.scale.x = (sin(count * sin_speed) * sine_multi) + x_int
	self.scale.y = (sin((count+3) * sin_speed) * sine_multi) + y_int
