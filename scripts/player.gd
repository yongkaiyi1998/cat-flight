extends Area2D

signal died(reason: String)

@export var fall_gravity: float = 1000.0
@export var flap_strength: float = 350.0

var vertical_velocity: float = 0.0
var is_dead: bool = false


func _ready() -> void:
	area_entered.connect(_on_obstacle_entered)


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	vertical_velocity += fall_gravity * delta
	if Input.is_action_just_pressed("flap"):
		vertical_velocity = -flap_strength
	position.y += vertical_velocity * delta
	var half_height: float = $CollisionShape2D.shape.size.y / 2.0
	if position.y - half_height <= 0.0:
		position.y = half_height
		_die("ceiling")
	elif position.y + half_height >= get_viewport_rect().size.y:
		position.y = get_viewport_rect().size.y - half_height
		_die("ground")


func _on_obstacle_entered(_area: Area2D) -> void:
	_die("obstacle")


func _die(reason: String) -> void:
	if is_dead:
		return
	is_dead = true
	vertical_velocity = 0.0
	set_physics_process(false)
	died.emit(reason)
