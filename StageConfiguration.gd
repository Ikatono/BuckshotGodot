class_name StageConfiguration

enum Order {
	Fixed, #go through each loadout in order
	Shuffle, #shuffle loadouts, then go through all of them before reshuffling
	Random, #select a random loadout every time
}

class ShellLoadout:
	var live = 0
	var blank = 0
	
	func _init(l, b):
		live = l
		blank = b

var max_health = 0
var items_per_round = 0

var shuffle_loadouts = false
var shell_loadouts: Array[ShellLoadout] = []

func _init(health: int, items: int, shuffle: Order, loadouts: Array[ShellLoadout]):
	max_health = health
	items_per_round = items
	shuffle_loadouts = shuffle
	shell_loadouts = loadouts
