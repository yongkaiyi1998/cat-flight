extends Node2D

@export var move_speed: float = 180.0
@export var obstacle_width: float = 80.0
@export var gap_size: float = 220.0
@export var gap_center: float = 360.0

var has_scored: bool = false


func _ready() -> void:
	var screen_height := get_viewport_rect().size.y
	var gap_top := gap_center - gap_size / 2.0
	var gap_bottom := gap_center + gap_size / 2.0
	$TopObstacle.size = Vector2(obstacle_width, gap_top)
	$BottomObstacle.position.y = gap_bottom
	$BottomObstacle.size = Vector2(obstacle_width, screen_height - gap_bottom)
	_layout_tiles($TopObstacle, true)
	_layout_tiles($BottomObstacle, false)
	# Collision stays independent of the repeated visual tiles.
	$TopCollision/CollisionShape2D.shape.size = $TopObstacle.size
	$TopCollision.position = $TopObstacle.size / 2.0
	$BottomCollision/CollisionShape2D.shape.size = $BottomObstacle.size
	$BottomCollision.position = $BottomObstacle.position + $BottomObstacle.size / 2.0


func _layout_tiles(visual: Control, cap_at_bottom: bool) -> void:
	var body_height := maxf(visual.size.y - 32.0, 0.0)
	var tiled_height := ceilf(body_height / 32.0) * 32.0
	var body: TextureRect = visual.get_node("Body")
	var cap: TextureRect = visual.get_node("Cap")
	body.size = Vector2(80.0, tiled_height)
	body.visible = body_height > 0.0
	if cap_at_bottom:
		cap.position.y = visual.size.y - 32.0
		body.position.y = body_height - tiled_height
	else:
		cap.position.y = 0.0
		body.position.y = 32.0
	# The visual Control clips the excess body tile at the screen-facing end.


func _physics_process(delta: float) -> void:
	position.x -= move_speed * delta
	# Wait until the entire pair has passed the left edge.
	if position.x + obstacle_width < 0.0:
		queue_free()
