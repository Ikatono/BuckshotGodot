extends Button

signal player_shoot_self

func _pressed():
	player_shoot_self.emit()
