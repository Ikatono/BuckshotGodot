var sc = preload("res://StageConfiguration.gd")
var Loadout = sc.ShellLoadout
var Order = sc.Order

var StageConfigs: Array[StageConfiguration] = [
	sc.new(4, 1, Order.Random, [
		Loadout.new(2, 2),
		Loadout.new(3, 2),
		Loadout.new(1, 4)]),
]
