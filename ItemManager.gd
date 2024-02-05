extends GridContainer

var inventoryButton = preload("res://InventoryButton.tscn")

func choose_width(items: int) -> int:
	return floor(sqrt(items * 2))

func reset_children(child_count: int):
	var buttons = get_child_buttons()
	for b in buttons:
		remove_child(b)
	for i in range(child_count):
		add_child(inventoryButton.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED))
	columns = choose_width(child_count)

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
		_:
			pass
