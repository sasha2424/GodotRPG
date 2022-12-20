extends Node2D

var itemNameToID = {
	"Apple" : 0,
	"Cheese" : 2
}

func _ready() -> void:
	pass

func set_item_by_name(name : String):
	if name in itemNameToID.keys():
		$Sprite.frame = itemNameToID.get(name)

