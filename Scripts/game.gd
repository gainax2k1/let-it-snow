extends Node2D

func _ready() -> void:
	set_timer()
	start_timer()

func _process(delta: float) -> void:
	%TimerLabel.text = "Timer: " +  str(floori(%Timer.time_left))
	%CashLabel.text = "Money earned: $" + str(GameManager.player_cash)
	pass
	
func _on_timer_timeout(): ## need to add the daily reset shtuff here
	GameManager.game_locked = true
	%Timer.stop()
	print("Time's up for the day!")
	%DialogBox.visible = true
	refresh_shop()
	%ShopWindow.visible = true
	%HeroCat.stop_hero()

func set_timer() -> void: ## set's timer to max timer
	%Timer.wait_time = GameManager.timer_max * GameManager.playerLvl

func start_timer() -> void: ## starts round timer
	%TimerLabel.visible = true
	set_timer()
	%Timer.start()

func refresh_shop() -> void: ## adjusts prices/labels for shop
	%UpgradeClothing.text = "Upgrade Clothing: $" + str(GameManager.playerLvlPrice)
	%UpgradeShovel.text = "Upgrade Shovel: $" + str(GameManager.shovelLvlPrice)
	pass

func _on_next_round_pressed() -> void: ## Start next round
	GameManager.game_locked = false
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_upgrade_shovel_pressed() -> void: ## applies shovel upgrades
	if GameManager.player_cash >= GameManager.shovelLvlPrice:
		GameManager.shovelLvl += 1
		GameManager.player_cash -= GameManager.shovelLvlPrice
		GameManager.shovelLvlPrice *= 2
		refresh_shop()

func _on_upgrade_clothing_pressed() -> void: ## applies timer upgrades
	if GameManager.player_cash >= GameManager.playerLvlPrice:
		GameManager.playerLvl += 1
		GameManager.player_cash -= GameManager.playerLvlPrice
		GameManager.playerLvlPrice *= 2
		refresh_shop()
