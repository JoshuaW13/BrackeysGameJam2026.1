extends Resource
class_name Item

enum ItemType{
	COFEE,
	BOX
}
@export var type: ItemType
@export var scene: PackedScene
@export var texture: Texture2D
var id: int = 1
