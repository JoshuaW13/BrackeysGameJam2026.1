extends AspectRatioContainer
class_name ElevatorButton

@export var text = "M"
@onready var label = %Label
@onready var button: TextureButton =%ElevatorButton

func _ready() -> void:
	label.text = text
