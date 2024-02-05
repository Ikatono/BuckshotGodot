extends Button

signal player_shoot_other

func _pressed():
	player_shoot_other.emit()
