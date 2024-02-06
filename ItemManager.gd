extends GridContainer

var inventoryButton = preload("res://InventoryButton.tscn")
var _itemTypes = preload("res://ItemTypes.gd")
var itemType = _itemTypes.ItemType

signal use_cuffs
signal use_cigs
signal use_saw
signal use_glass
signal use_beer

func choose_width(items: int) -> int:
	if items <= 1:
		return 1
	elif items <= 4:
		return 2
	elif items <= 6:
		return 3
	elif items <= 12:
		return 4
	elif items <= 20:
		return 5
	elif items <= 24:
		return 6
	#rough method to format larger numbers
	return floor(sqrt(items * 2 + 1))

#delete all children and create new ones
func reset_children(child_count: int):
	var buttons = get_child_buttons()
	for b in buttons:
		remove_child(b)
	columns = choose_width(child_count)
	for i in range(child_count):
		add_child(inventoryButton.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED))

#set existing children to None
func clear_children():
	for c in get_child_buttons():
		c.update_item(itemType.None)

#consider caching until reset_children() is called
func get_child_buttons() -> Array[Button]:
	var buttons: Array[Button] = []
	for n in get_children():
		if n is Button:
			buttons.append(n)
	return buttons

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_children(GameConfiguration.max_inventory)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#it would be more efficient to have an add-multiple method
func add_item(new_item: ItemTypes.ItemType) -> bool:
	if new_item == ItemTypes.ItemType.None:
		return true
	else:
		var buttons = get_child_buttons()
		for b in buttons:
			if b.add_item(new_item):
				return true
		return false

func generate_possible_item() -> ItemTypes.ItemType:
	var cigs = 0
	for b in get_child_buttons():
		if b.item == ItemTypes.ItemType.Cigarette:
			cigs += 1
	if cigs >= GameConfiguration.cig_limit:
		return [ItemTypes.ItemType.Beer, ItemTypes.ItemType.Cuffs,
			ItemTypes.ItemType.Glass, ItemTypes.ItemType.Saw].pick_random()
	else:
		return [ItemTypes.ItemType.Beer, ItemTypes.ItemType.Cuffs,
			ItemTypes.ItemType.Glass, ItemTypes.ItemType.Saw,
			ItemTypes.ItemType.Cigarette].pick_random()

func use_item(button: Button):
	var item_type = button.item
	match item_type:
		itemType.CIGARETTE:
			use_cigs.emit()
		itemType.SAW:
			use_saw.emit()
		itemType.GLASS:
			use_glass.emit()
		itemType.BEER:
			use_beer.emit()
		itemType.CUFFS:
			use_cuffs.emit()
	button.update_item(itemType.None)


func _on_gameplay_new_round(items):
	for i in range(items):
		add_item(generate_possible_item())


func _on_gameplay_new_stage():
	clear_children()
