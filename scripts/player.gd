extends Node2D

@export var gravity: float = 1000.0
@export var flap_strength: float = 350.0

var vertical_velocity: float = 0.0


func _physics_process(delta: float) -> void:
	vertical_velocity += gravity * delta
	if Input.is_action_just_pressed("flap"):
		vertical_velocity = -flap_strength
	position.y += vertical_velocity * delta
