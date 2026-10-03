extends Node2D

const OBSTACLE_PAIR = preload("res://scenes/obstacle_pair.tscn")

@export_range(0.1, 10.0, 0.1) var spawn_interval: float = 2.0
@export_range(1.0, 600.0, 1.0) var obstacle_speed: float = 180.0
@export_range(40.0, 600.0, 1.0) var gap_size: float = 220.0

var is_game_over: bool = false
var death_reason: String = ""


func _ready() -> void:
	$Player.died.connect(_on_player_died)
	$SpawnTimer.start(spawn_interval)


func _spawn_obstacle_pair() -> void:
	if is_game_over:
		return
	var screen_size := get_viewport_rect().size
	var edge_margin := screen_size.y * 0.1
	var pair := OBSTACLE_PAIR.instantiate()
	# Keep both obstacles visible even if the configured gap is too large.
	pair.gap_size = minf(gap_size, screen_size.y - edge_margin * 2.0)
	var half_gap: float = pair.gap_size / 2.0
	pair.gap_center = randf_range(
		edge_margin + half_gap, screen_size.y - edge_margin - half_gap
	)
	pair.move_speed = obstacle_speed
	pair.position.x = screen_size.x
	$Obstacles.add_child(pair)


func _on_player_died(reason: String) -> void:
	if is_game_over:
		return
	is_game_over = true
	death_reason = reason
	$SpawnTimer.stop()
	for pair in $Obstacles.get_children():
		pair.set_physics_process(false)
