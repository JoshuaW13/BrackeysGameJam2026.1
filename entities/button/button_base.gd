extends Node2D
class_name Button2D

@export var button : ButtonResource
@onready var sprite : Sprite2D = $Sprite2D
@onready var interact_area : Area2D = $InteractArea2D

signal unlock(item_id : String)
signal lock(item_id : String)
var pressed : bool = false

func _ready():
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)
	update_sprite()

func _on_body_entered(body):
	if body.is_in_group("box") or body.is_in_group("player"):
		pressed = true
		update_sprite()
		emit_signal("unlock", button.item_id)

func _on_body_exited(body):
	if body.is_in_group("box") or body.is_in_group("player"):
		pressed = false
		update_sprite()
		if button.toggle:
			emit_signal("lock", button.item_id)

func update_sprite():
	if pressed:
		sprite.texture = button.on_texture
	else:
		sprite.texture = button.off_texture	
