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
	set_deferred("monitoring", false)
	died.emit(reason)
	_play_death_reaction(reason)


func _play_death_reaction(reason: String) -> void:
	# Animate only the placeholder art; normal flight stays disabled.
	var reaction := create_tween()
	match reason:
		"obstacle":
			reaction.tween_property($Placeholder, "scale", Vector2(0.7, 1.2), 0.1)
			reaction.parallel().tween_property($Placeholder, "rotation", -0.3, 0.1)
			reaction.parallel().tween_property($Placeholder, "position:x", -8.0, 0.1)
			_fall_after_hit(reaction)
		"ceiling":
			reaction.tween_property($Placeholder, "scale", Vector2(1.3, 0.65), 0.1)
			reaction.parallel().tween_property($Placeholder, "position:y", -6.0, 0.1)
			_fall_after_hit(reaction)
		"ground":
			reaction.tween_property($Placeholder, "scale", Vector2(1.5, 0.35), 0.15)
			# Keep the bottom of the squashed shape on the ground.
			var half_height: float = $CollisionShape2D.shape.size.y / 2.0
			reaction.parallel().tween_property(
				$Placeholder, "position:y", half_height * (1.0 - 0.35), 0.15
			)


func _fall_after_hit(reaction: Tween) -> void:
	reaction.tween_property($Placeholder, "scale", Vector2.ONE, 0.1)
	reaction.parallel().tween_property($Placeholder, "position", Vector2.ZERO, 0.1)
	var half_height: float = $CollisionShape2D.shape.size.y / 2.0
	var ground_y := get_viewport_rect().size.y - half_height
	reaction.tween_property(self, "position:y", ground_y, 0.65).set_trans(
		Tween.TRANS_QUAD
	).set_ease(Tween.EASE_IN)
	reaction.parallel().tween_property($Placeholder, "rotation", PI / 2.0, 0.65)
