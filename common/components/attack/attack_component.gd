extends Node
class_name AttackComponent

signal attack_started
signal attack_finished

@export var attack_animation_player: AnimationPlayer
@export var hitbox : HitboxComponent

var animation_player: AnimationPlayer
var animation_names: Array[String] = []
var current_animation_index := 0
var attack_in_progress: bool

func attack() -> void:
	if animation_player==null or animation_names.is_empty() or attack_in_progress:
		return
	emit_signal("attack_started")
	hitbox.enable()
	attack_in_progress = true
	attack_animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
	animation_player.play(animation_names[current_animation_index])
	current_animation_index = (current_animation_index + 1) % animation_names.size()

func _on_animation_finished(_anim_name:String)->void:
	attack_animation_player.disconnect("animation_finished", Callable(self, "_on_animation_finished"))
	hitbox.disable()
	attack_in_progress = false
	emit_signal("attack_finished")

func start_attack_animation() ->void:
	if attack_animation_player == null: return
	attack_animation_player.play("Attack")	
