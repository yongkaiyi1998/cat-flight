extends Node2D

const OBSTACLE_PAIR = preload("res://scenes/obstacle_pair.tscn")
const HIGH_SCORE_PATH = "user://high_score.cfg"
const DEATH_QUOTES: Array[String] = [
	"Gravity wins again.",
	"That wall moved. Probably.",
	"One more try, one more meow.",
	"Paws need a pilot license.",
	"I meant to land there.",
	"Nine lives. Zero brakes.",
	"The floor wanted a hug.",
	"Ceiling: 1. Cat: 0.",
	"Too much flap, not enough map.",
	"Whiskers missed the memo.",
	"Nap time came early.",
	"My paws slipped.",
	"That gap looked bigger.",
	"Flying is a work in pawgress.",
	"Meow. Let's try again.",
]
const BACKGROUND_TEXTURES: Array[Texture2D] = [
	preload("res://assets/backgrounds/v1/background_sunny_room.png"),
	preload("res://assets/backgrounds/v1/background_living_room.png"),
	preload("res://assets/backgrounds/v1/background_bedroom.png"),
	preload("res://assets/backgrounds/v1/background_cat_corner.png"),
]

# A script static variable survives scene reloads without an extra singleton.
static var previous_background: int = -1

@export_range(0.1, 10.0, 0.1) var spawn_interval: float = 2.0
@export_range(1.0, 600.0, 1.0) var obstacle_speed: float = 170.0
@export_range(40.0, 600.0, 1.0) var gap_size: float = 240.0

var is_game_over: bool = false
var death_reason: String = ""
var score: int = 0
var best_score: int = 0


func _ready() -> void:
	_choose_background()
	_load_high_score()
	$Player.died.connect(_on_player_died)
	$SpawnTimer.start(spawn_interval)
	$UI/ScoreLabel.text = "Score: 0"
	$UI/BestScoreLabel.text = "Best: %d" % best_score
	$UI/GameOverPanel.hide()
	$UI/GameOverPanel/Content/DeathQuoteLabel.text = ""


func _choose_background() -> void:
	var background_index := randi_range(0, BACKGROUND_TEXTURES.size() - 1)
	if BACKGROUND_TEXTURES.size() > 1 and previous_background >= 0:
		# Pick from all entries except the previous run's background.
		background_index = randi_range(0, BACKGROUND_TEXTURES.size() - 2)
		if background_index >= previous_background:
			background_index += 1
	$Background/Image.texture = BACKGROUND_TEXTURES[background_index]
	previous_background = background_index


func _process(_delta: float) -> void:
	if is_game_over:
		return
	var player_left: float = $Player.position.x - $Player/CollisionShape2D.shape.size.x / 2.0
	for pair in $Obstacles.get_children():
		# Award a point only after the whole pair clears the player.
		if not pair.has_scored and pair.position.x + pair.obstacle_width < player_left:
			pair.has_scored = true
			score += 1
			if $ScoreSound.stream != null:
				$ScoreSound.play()
			$UI/ScoreLabel.text = "Score: %d" % score
			if score > best_score:
				best_score = score
				$UI/BestScoreLabel.text = "Best: %d" % best_score
				_save_high_score()


func _load_high_score() -> void:
	var save_data := ConfigFile.new()
	if save_data.load(HIGH_SCORE_PATH) != OK:
		return
	var saved_score: Variant = save_data.get_value("scores", "best", 0)
	if saved_score is int and saved_score >= 0:
		best_score = saved_score


func _save_high_score() -> void:
	var save_data := ConfigFile.new()
	save_data.set_value("scores", "best", best_score)
	if save_data.save(HIGH_SCORE_PATH) != OK:
		push_warning("Could not save the high score.")


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
	$ScoreSound.stop()
	if $DeathSound.stream != null:
		$DeathSound.play()
	$SpawnTimer.stop()
	for pair in $Obstacles.get_children():
		pair.set_physics_process(false)
	$UI/GameOverPanel/Content/DeathQuoteLabel.text = DEATH_QUOTES.pick_random()
	$UI/GameOverPanel.show()
	$UI/GameOverPanel/Content/RestartButton.grab_focus()


func _restart_run() -> void:
	# Reloading recreates the player, obstacles, timer, score, and game-over state.
	get_tree().reload_current_scene()
