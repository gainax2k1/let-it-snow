extends Node2D

#timer
var timer_max : float = 10.0 ## amount of time on the clock for the round, to be determined by player lvl...?


# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	set_timer()
	start_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	%TimerLabel.text = "Timer: " +  str(floori(%Timer.time_left))
	pass
	
func _on_timer_timeout(): ## need to add the daily reset shtuff here
	%Timer.stop()
	print("Time's up for the day!")
	%DialogBox.visible = true
	%HeroCat.stop_hero()

func set_timer() -> void:
	%Timer.wait_time = timer_max

func start_timer() -> void:
	%TimerLabel.visible = true
	set_timer()
	%Timer.start()

func shovel_snow() -> void:
	
	return
