extends Button

@export var item = ItemTypes.ItemType.None

# Called when the node enters the scene tree for the first time.
func _ready():
	expand_icon = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _pressed():
	pass

static func get_texture(new_item) -> Texture2D:
	match new_item:
		ItemTypes.ItemType.Cigarette:
			return preload("res://assets/icons/PixelMart/energy_bar.png")
		ItemTypes.ItemType.Glass:
			return preload("res://assets/icons/PixelMart/light_bulb.png")
		ItemTypes.ItemType.Saw:
			return preload("res://assets/icons/PixelMart/scissors.png")
		ItemTypes.ItemType.Beer:
			return preload("res://assets/icons/PixelMart/soft_drink_yellow.png")
		ItemTypes.ItemType.Cuffs:
			return preload("res://assets/icons/PixelMart/glue.png")
		_:
			return null

func update_item(new_item: ItemTypes.ItemType):
	assert(new_item in [ItemTypes.ItemType.None, ItemTypes.ItemType.Cigarette,
		ItemTypes.ItemType.Glass, ItemTypes.ItemType.Saw,
		ItemTypes.ItemType.Beer, ItemTypes.ItemType.Cuffs], "Invalid new item")
	item = new_item
	icon = get_texture(new_item)
	disabled = item == ItemTypes.ItemType.None
	
func add_item(new_item: ItemTypes.ItemType) -> bool:
	if item != ItemTypes.ItemType.None:
		return false
	update_item(item)
	return true
