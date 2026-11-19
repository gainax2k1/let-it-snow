extends Node2D

@export var locked = false
@export var snowHP = 10 # starts at 10, 10xsnowhp per "level"
@export var snowlvl = 1 # starts at 1, 10 hp/level
@export var start_snow_HP = 10 # snowhp when shoveling begins, resets each day
@export var digging : bool = false # true when hp being reduced.
var delta_bucket = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	print("delta", delta)
	if digging:
		delta_bucket += delta
		if int(delta_bucket) % 60 == 0:
			delta_bucket = 0
			sub_snow_hp()
	update_snow_hp()
func update_snow_hp() -> void:
	if locked:
		return
		
	if snowHP == 0:
		lock_snow()
		hide_snow()
		%SnowUnit.frame = 0 ## sets to 0 frame, which is "empty"
		GameManager.player_cash += 69 ## to be updated. will be decided by size of snow started with? or maybe just each lvl worth the same ammount. 
		return
	
	var frame_number = snow_level() 
	%SnowUnit.frame = frame_number
	

func add_snow_hp(amount:int = 1) -> void: ## increases snowhp by (int), default 1
	print("add_snow_hp: ", amount)
	snowHP += amount
	
func sub_snow_hp(amount:int = 1) -> void: ## reduces snowhp by (int), default 1
	print("sub_snow_hp", amount)
	snowHP -= amount
	if snowHP < 0:
		snowHP = 0
		
	
func lock_snow() -> void: ## locks snow so it cannot be modified
	locked = true

func unlock_snow() -> void: ## unlocks snow so it can be modified
	locked = false
	
func hide_snow() -> void: ## makes snowunit invisible
	%SnowUnit.visible = false
	lock_snow()
	queue_free()
	
func show_snow() -> void: ## makes snowunit visible
	%SnowUnit.visible = true
	
func reset_snow() -> void: ## resets snow to begin day
	start_snow_HP = snowHP
	unlock_snow()
	show_snow()

func snow_level() -> int: ## returns the lvl of snow for animation and ...?
	var dividend = ceili(snowHP/10) ## ceili to keep on frame 1 until actually zero
	if dividend >= GameManager.MAX_SNOW_LEVEL:
		dividend == GameManager.MAX_SNOW_LEVEL
		
	return dividend
			


func _on_snow_timer_timeout() -> void: ## triggers when it's time to increment snow.
	print("_on_Snow_timer_timeout hit")
	add_snow_hp()
	


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("snoblock area2d body shape entered: ", body_rid, body.name)
	if body.name == "HeroCat":
		digging = true
		print("digging set TRUE")
	pass # Replace with function body.


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "HeroCat":
		digging = false
		print("Digging set FALSE")
	pass # Replace with function body.
