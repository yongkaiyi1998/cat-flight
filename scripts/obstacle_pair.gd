extends Node2D

@export var move_speed: float = 180.0
@export var obstacle_width: float = 70.0
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
	# Match the collision rectangles to the visible placeholder obstacles.
	$TopCollision/CollisionShape2D.shape.size = $TopObstacle.size
	$TopCollision.position = $TopObstacle.size / 2.0
	$BottomCollision/CollisionShape2D.shape.size = $BottomObstacle.size
	$BottomCollision.position = $BottomObstacle.position + $BottomObstacle.size / 2.0


func _physics_process(delta: float) -> void:
	position.x -= move_speed * delta
	# Wait until the entire pair has passed the left edge.
	if position.x + obstacle_width < 0.0:
		queue_free()
