extends NPC
class_name Guard

@onready var velocity_component : VelocityComponent = $VelocityComponent
@onready var gravity_component: GravityComponent = $GravityComponent
@onready var move_character: MoveCharacter = $MoveCharacter
@onready var detection_area: Area2D = $Area2D

var happy = false

var action_texture : Texture2D = load("res://entities/guard/assets/guard_stop.png")

var captive: Player = null

func _physics_process(delta: float) -> void:
	gravity_component.apply(delta)
	velocity_component.apply(self)

func determine_move_direction(body: Node2D)->MoveCharacter.DIRECTION:
	var local_pos = to_local(body.global_position)
	if local_pos.x > 0:
		return MoveCharacter.DIRECTION.LEFT
	else:
		return MoveCharacter.DIRECTION.RIGHT

func _on_area_2d_body_exited(body: Node2D) -> void:
	var direction = determine_move_direction(body)
	if body is Player:
		sprite.texture = action_texture
		captive = body
		match direction:
			MoveCharacter.DIRECTION.LEFT:
				sprite.flip_h = false
			MoveCharacter.DIRECTION.RIGHT:
				sprite.flip_h = true
		if !captive.state_machine.current_state is Stunned:
			if captive.inventory.holding_item_of_type(Item.ItemType.COFFEE, Coffee.Topping.CARAMEL):
				print("Making guard happy")
				make_happy()
			force_interact()
			if !happy:
				print("Stun guard")
				captive.stun()
				move_character.move(captive, direction)

func _on_move_character_character_moved() -> void:
	if captive!=null:
		sprite.texture = npc.texture
		captive.release()
		captive = null

func make_happy()->void:
	happy = true
	detection_area.monitoring = false
