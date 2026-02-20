extends Node2D

@export var button : ButtonResource
@onready var sprite : Sprite2D = $Sprite2D
@onready var interact_area : Area2D = $InteractArea2D

signal button_pressed(button_id : String)
signal button_unpressed(button_id : String)
var pressed : bool = false

func _ready():
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)
	update_sprite()

func _on_body_entered(body):
	if body.is_in_group("box"):
		pressed = true
		update_sprite()
		emit_signal("button_pressed", button.button_id)
		
func _on_body_exited(body):
	if body.is_in_group("box"):
		pressed = false
		update_sprite()
		emit_signal("button_unpressed", button.button_id)

func update_sprite():
	if pressed:
		sprite.texture = button.on_texture
	else:
		sprite.texture = button.off_texture
	
	
