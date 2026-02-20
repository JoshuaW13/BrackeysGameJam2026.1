extends Area2D

@export var spawn_path: NodePath
@onready var spawn: Marker2D = get_node(spawn_path)

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	pass
