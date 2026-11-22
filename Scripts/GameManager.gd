extends Node2D

#timer
var timer_max : float = 10.0 ## amount of time on the clock for the round, to be determined by player lvl...?
 

#music settings
var bg_music_playing : bool = true ## Set in menu
var bg_music_track : String = "res://Audio/jingle_bells_beat.ogg" ## string "res:// ...ogg"

#scene transition
var scene_current: String = "res://Scenes/game.tscn" ## string "res://Scenes/...tcsn"
var scene_previous : String = "res://Scenes/game.tscn" ## string "res://Scenes/...tcsn"

#player info
@export var pay_rate = 20 ## money per block cleared
@export var playerLvl = 1 ## adjusts timer
@export var playerLvlPrice = 200

@export var shovelLvl = 1 ## level of snow removal tool
@export var shovelLvlPrice = 100

@export var player_spawn_position : Vector2 = Vector2(10,560)
@export var player_cash : int = 0 ## ammount of money player has earned, starting with zero
@export var game_locked : bool = false ## lock to stop progress between rounds

#SnowTracker
const MAX_SNOW_LEVEL = 8 ## Max lvl of snow, coincides with largest available animation frame
const MAX_SNOW_BLOCK = 10 ## Max number of blocks present for shoveling (unneccessary?)
## not needed? @export var current_snow_levels = [1,1,1,1,1,1,1,1,1,1] ## Snow level per square ( Snow#:level)


#might need reworking depending on how music get's set up...
func bg_music_play(track_name : String = "res://Audio/jingle_bells_beat.ogg") -> void: ## recieves "res://Audio/Music/...ogg"
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
