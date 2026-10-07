extends Area2D

signal died(reason: String)

const GROUND_TOP_EDGE_HEIGHT: float = 16.0
const FLAP_SOUND: AudioStream = preload("res://assets/audio/sfx/sfx_flap.wav")

@export var fall_gravity: float = 900.0
@export var flap_strength: float = 330.0

# Vertical velocity is negative upward and positive downward (px/s).
@export var rising_pose_velocity: float = -80.0
@export var falling_pose_velocity: float = 80.0

var vertical_velocity: float = 0.0
var is_dead: bool = false
var death_reaction: Tween


func _ready() -> void:
	$FlapSound.stream = FLAP_SOUND
	area_entered.connect(_on_obstacle_entered)
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	$Visual.stop()
	_update_flight_pose()


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	vertical_velocity += fall_gravity * delta
	if Input.is_action_just_pressed("flap"):
		vertical_velocity = -flap_strength
		if $FlapSound.stream != null:
			$FlapSound.play()
	position.y += vertical_velocity * delta
	_update_flight_pose()
	var half_height: float = $CollisionShape2D.shape.size.y / 2.0
	if position.y - half_height <= 0.0:
		position.y = half_height
		_die("ceiling")
	elif position.y + half_height >= _ground_surface_y():
		position.y = _ground_surface_y() - half_height
		_die("ground")


func _update_flight_pose() -> void:
	if is_dead:
		return
	if vertical_velocity <= rising_pose_velocity:
		$Visual.frame = 2 # FLY_03: strong upward flight / just flapped.
	elif vertical_velocity >= falling_pose_velocity:
		$Visual.frame = 0 # FLY_01: falling.
	else:
		$Visual.frame = 1 # FLY_02: near the apex / neutral.


func _on_obstacle_entered(_area: Area2D) -> void:
	_die("obstacle")


func _die(reason: String) -> void:
	if is_dead:
		return
	is_dead = true
	vertical_velocity = 0.0
	$FlapSound.stop()
	set_physics_process(false)
	set_deferred("monitoring", false)
	died.emit(reason)
	_play_death_reaction(reason)


func _play_death_reaction(reason: String) -> void:
	# Select the death pose, then animate only the visual; flight stays disabled.
	death_reaction = create_tween()
	var reaction := death_reaction
	match reason:
		"obstacle":
			$Visual.play("hit")
			reaction.tween_property($Visual, "scale", Vector2(0.7, 1.2), 0.1)
			reaction.parallel().tween_property($Visual, "rotation", -0.3, 0.1)
			reaction.parallel().tween_property($Visual, "position:x", -8.0, 0.1)
			_fall_after_hit(reaction)
		"ceiling":
			$Visual.play("bonk")
			reaction.tween_property($Visual, "scale", Vector2(1.3, 0.65), 0.1)
			reaction.parallel().tween_property($Visual, "position:y", -6.0, 0.1)
			_fall_after_hit(reaction)
		"ground":
			$Visual.play("squash")
			# SQUASH already contains the deformation; align its opaque bottom to the floor.
			var half_height: float = $CollisionShape2D.shape.size.y / 2.0
			var texture: Texture2D = $Visual.sprite_frames.get_frame_texture("squash", 0)
			var visual_bottom: float = texture.get_image().get_used_rect().end.y - texture.get_height() / 2.0
			reaction.tween_property($Visual, "position:y", half_height - visual_bottom, 0.15)
	reaction.tween_callback(_settle_on_ground)


func _settle_on_ground() -> void:
	position.y = _ground_surface_y() - $CollisionShape2D.shape.size.y / 2.0


func _ground_surface_y() -> float:
	return get_viewport_rect().size.y - GROUND_TOP_EDGE_HEIGHT


func _on_viewport_size_changed() -> void:
	if is_dead and death_reaction != null and not death_reaction.is_running():
		_settle_on_ground()


func _fall_after_hit(reaction: Tween) -> void:
	reaction.tween_property($Visual, "scale", Vector2.ONE, 0.1)
	reaction.parallel().tween_property($Visual, "position", Vector2.ZERO, 0.1)
	var half_height: float = $CollisionShape2D.shape.size.y / 2.0
	var ground_y := _ground_surface_y() - half_height
	reaction.tween_property(self, "position:y", ground_y, 0.65).set_trans(
		Tween.TRANS_QUAD
	).set_ease(Tween.EASE_IN)
	reaction.parallel().tween_property($Visual, "rotation", PI / 2.0, 0.65)
