extends CharacterBody2D

@export var moving_platform : MovingPlatformResource

@onready var path_follow : PathFollow2D = get_parent()
@onready var sprite : Node2D = $Node2D
@onready var lock : Sprite2D = $Lock
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var pause_timer : Timer = $PauseTimer

var moving_forward := true
var direction := 1

func _ready():
	update_width()
	path_follow.loop = false
	path_follow.rotates = false
	pause_timer.timeout.connect(_on_pause_finished)
	
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		if npc is NPC or npc is ButtonResource:
			npc.unlock.connect(_on_unlock_platform)
			
	if moving_platform.is_locked:
		lock.visible = true
	else:
		lock.visible = false

func _physics_process(delta):
	if moving_platform.paused or moving_platform.is_locked:
		return
		
	if moving_forward:
		direction = 1
	else: 
		direction = -1
		
	path_follow.progress += direction * moving_platform.speed * delta
	global_position = path_follow.global_position
	_check_ends()
	
func _check_ends():
	if moving_forward and path_follow.progress_ratio >= 1.00:
		path_follow.progress_ratio = 1.00
		_start_pause()

	elif not moving_forward and path_follow.progress_ratio <= 0.00:
		path_follow.progress_ratio = 0.00
		_start_pause()
	
func _start_pause():
	moving_platform.paused = true
	pause_timer.start(moving_platform.pause)
	
func _on_pause_finished():
	moving_forward = !moving_forward
	moving_platform.paused = false

func update_width():
	for child in sprite.get_children():
		child.queue_free()
		
	var total_width = moving_platform.width * 16
	
	if moving_platform.width > 1:
		var left_sprite = Sprite2D.new()
		left_sprite.texture = moving_platform.left_texture
		left_sprite.position.x = 8
		sprite.add_child(left_sprite)

		for i in range(1, moving_platform.width - 1):
			var middle_sprite = Sprite2D.new()
			middle_sprite.texture = moving_platform.middle_texture
			middle_sprite.position.x = i * 16 + 8
			sprite.add_child(middle_sprite)
			
		var right_sprite = Sprite2D.new()
		right_sprite.texture = moving_platform.right_texture
		right_sprite.position.x = total_width - 16 + 8
		sprite.add_child(right_sprite)
		
	elif moving_platform.width == 1:
		var single_sprite = Sprite2D.new()
		single_sprite.texture = moving_platform.single_texture
		single_sprite.position.x = 8
		sprite.add_child(single_sprite)

	sprite.position.x = -total_width / 2

	if collision.shape is RectangleShape2D:
		collision.shape.size.x = total_width
		collision.shape.size.y = 8
		collision.position.y = 4
	
	global_position = path_follow.global_position
		
func _on_unlock_platform(platform_id):
	if moving_platform.platform_id == platform_id:
		moving_platform.is_locked = false
		lock.visible = false

func _on_lock_platform(platform_id):
	if moving_platform.platform_id == platform_id:
		moving_platform.is_locked = true
		lock.visible = true
