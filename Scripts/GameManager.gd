extends Node2D

#music settings
var bg_music_playing : bool = true ## Set in menu
var bg_music_track : String = "res://Audio/gloomy_bg.ogg" ## string "res:// ...ogg"

#scene transition
var scene_current: String = "res://Scenes/game.tscn" ## string "res://Scenes/...tcsn"
var scene_previous : String = "res://Scenes/game.tscn" ## string "res://Scenes/...tcsn"

#player info
@export var playerLvl = 1
@export var shovelLvl = 1 ## level of snow removal tool
@export var player_position = 0 ## Player's position on sidewalk 

#SnowTracker
const MAX_SNOW_LEVEL = 8
const MAX_SNOW_BLOCK = 10
@export var current_snow_levels = [1,1,1,1,1,1,1,1,1,1] ## Snow level per square ( Snow#:level )

func increment_snow() -> void: ## goes from current player_position to end of current_snow_levels, incrementing every level
	if player_position >= MAX_SNOW_BLOCK:
		print("No snow left to increment.")
		return
	var start_pos = player_position
	while start_pos < MAX_SNOW_BLOCK: 
		print("start_pos:", start_pos)
		if current_snow_levels[start_pos] < MAX_SNOW_LEVEL-1:
			current_snow_levels[start_pos] += 1
		start_pos += 1
	return
	

#might need reworking depending on how music get's set up...
func bg_music_play(track_name : String) -> void: ## recieves "res://Audio/Music/...ogg"
	if track_name != "":
		bg_music_track = track_name
	if bg_music_playing:
		$AudioStreamPlayer.stream = load(bg_music_track)
		$AudioStreamPlayer.play()

func toggle_bg_music(): ## toggles , loading current "bg_music_track" if playing.
	if bg_music_playing:
		$AudioStreamPlayer.stop()
	else:
		$AudioStreamPlayer.stream = load(bg_music_track)
		$AudioStreamPlayer.play()
		
	bg_music_playing = !bg_music_playing
	
func change_scene(target_scene : String, trans_effect : String = "Fade") -> void: ##handles scene trans, default to "Fade"
	## target_scene = "res://Scenes/...tscn", trans_effect "Fade", etc
	
	scene_previous = scene_current
	scene_current = target_scene
	
	print("Target scene: ", target_scene)
	print("Trans effect: ", trans_effect) #eventually, cool transition?
	print("Take care of preserving player coordinates in player_pos_previous? Not yet!")

	match trans_effect:
		"Fade":
			print("Fade transition")
			%SceneTransitionRect.transition_to(target_scene)
		_:
			print("Wildcard transition, default Fade")
