extends RichTextLabel

func rewrite():
	text = "You:  {you}/{max}\nThem: {them}/max".format({
		"you": GameState.player1_health,
		"them": GameState.player2_health,
		"max": GameState.max_health,
	})


func _on_gameplay_new_stage():
	rewrite()
