extends Container

signal new_stage
signal new_round(items: int)

signal self_shot_live(sawed: bool)
signal enemy_shot_live(sawed: bool)

signal display_shell(is_live: bool)

signal self_dead
signal enemy_dead

@onready
var lastShellIndicator = $LastShellIndicator

func shoot_other_player():
	var is_live = GameState.shells.pop_front()
	if is_live:
		lastShellIndicator.set_live()
		enemy_shot_live.emit(GameState.gun_sawed)
		GameState.player2_health -= 2 if GameState.gun_sawed else 1
		if GameState.player2_health <= 0:
			GameState.player2_health = 0
			enemy_dead.emit()
	else:
		lastShellIndicator.set_blank()
	end_self_turn()

func shoot_self():
	var is_live = GameState.shells.pop_front()
	if is_live:
		lastShellIndicator.set_live()
		self_shot_live.emit(GameState.gun_sawed)
		GameState.player1_health -= 2 if GameState.gun_sawed else 1
		if GameState.player1_health <= 0:
			GameState.player1_health = 0
			self_dead.emit()
		end_self_turn()
	else:
		lastShellIndicator.set_blank()

func end_self_turn():
	pass

func end_enemy_turn():
	pass

func _on_shoot_other_button_player_shoot_other():
	shoot_other_player()

func _on_shoot_self_button_player_shoot_self():
	shoot_self()


func _on_inventory_use_beer():
	display_shell.emit(GameState.shells.pop_front())

func _on_inventory_use_cigs():
	if GameState.player1_health < GameState.max_health:
		GameState.player1_active += 1

func _on_inventory_use_glass():
	display_shell.emit(GameState.shells[0])

func _on_inventory_use_saw():
	GameState.gun_sawed = true
