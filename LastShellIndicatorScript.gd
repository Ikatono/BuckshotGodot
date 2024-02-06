extends ColorRect

func _on_gameplay_display_shell(is_live):
	if is_live:
		set_live()
	else:
		set_blank()

func set_live():
	color = GameConfiguration.live_color

func set_blank():
	color = GameConfiguration.blank_color

func reset_display():
	color = GameConfiguration.unset_color
