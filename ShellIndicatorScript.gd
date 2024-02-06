extends RichTextLabel

const display_time = 3.0

func display_shells():
	var shuffled = GameState.shells.duplicate()
	shuffled.shuffle()
	clear()
	for b in shuffled:
		if b:
			push_color(GameConfiguration.live_color)
		else:
			push_color(GameConfiguration.blank_color)
		append_text("▉")
		pop()

func hide_shells():
	clear()

#called after GamestateManager is updated
func _on_gameplay_new_round(items: int):
	display_shells()
	await get_tree().create_timer(display_time).timeout
	hide_shells()
