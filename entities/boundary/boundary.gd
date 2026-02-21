extends Area2D

@export var spawn_path: NodePath
@onready var spawn: Marker2D = get_node(spawn_path)

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	print(body)
	var body_scene = get_body_scene(body) 
	var new_body = body_scene.instantiate() 
	new_body.position = spawn.position 
	get_parent().add_child(new_body) 
	body.queue_free()

func get_body_scene(body: Node) -> PackedScene:
	if body.filename != "":
		var body_scene = load(body.filename)
		if body_scene and body_scene is PackedScene:
			return body_scene
	return null
