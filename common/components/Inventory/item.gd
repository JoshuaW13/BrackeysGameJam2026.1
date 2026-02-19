extends Resource
class_name Item

enum ItemType{
	COFFEE,
	BOX
}
@export var type: ItemType
@export var scene: PackedScene
@export var texture: Texture2D
