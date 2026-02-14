extends Node2D
class_name FlipComponent

signal scale_changed

@export var patient: Node2D

enum Facing {LEFT, RIGHT}
var facing: Facing = Facing.RIGHT
var flip_allowed: bool = true
