extends Node

@export var bgm_volume_db: float = -5.0
@export_range(0.0, 1.0, 0.05) var death_fade_duration: float = 0.2

var fade_out: Tween


func start_run() -> void:
	if fade_out != null:
		fade_out.kill()
	$Music.stop()
	$Music.volume_db = bgm_volume_db
	$Music.play(0.0)


func stop_on_death() -> void:
	if fade_out != null:
		fade_out.kill()
	fade_out = create_tween()
	fade_out.tween_property($Music, "volume_db", -80.0, death_fade_duration)
	fade_out.tween_callback($Music.stop)
