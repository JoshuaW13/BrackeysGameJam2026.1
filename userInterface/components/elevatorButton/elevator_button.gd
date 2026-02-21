extends AspectRatioContainer
class_name ElevatorButton

@export var text = "M"
@export var completed = false
@onready var label = %Label
@onready var button: TextureButton =%ElevatorButton

func _ready() -> void:
	label.text = text
	if completed:
		label.modulate = Color(0.808, 0.753, 0.196)
