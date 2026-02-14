extends Node
class_name HealthComponent

@export var max_health := 10.0
var current_health := max_health

signal health_changed(new_health: float)
signal health_depleted

# ----------------------------------------------------
# Public API — Anyone can call this
# ----------------------------------------------------
func deal_damage(amount: float) -> void:
	# If we are authority, apply immediately
	if is_multiplayer_authority():
		_apply_damage(amount)
	else:
		# Ask authority to apply damage
		rpc_id(get_multiplayer_authority(), "rpc_request_damage", amount)

# ----------------------------------------------------
# Client → Authority
# ----------------------------------------------------
@rpc("any_peer", "reliable")
func rpc_request_damage(amount: float) -> void:
	# Only authority is allowed to apply damage
	if !is_multiplayer_authority():
		return
	_apply_damage(amount)

# ----------------------------------------------------
# Authority Damage Logic
# ----------------------------------------------------
func _apply_damage(amount: float) -> void:
	var new_health = clamp(current_health - amount, 0.0, max_health)
	# Authority applies locally
	_apply_health_updates(new_health)

	# Authority replicates final state to everyone
	# No need to replicate if they died
	# replicating if they die causes bad rpc errors
	if new_health > 0:
		rpc("rpc_set_health", new_health)

# ----------------------------------------------------
# Authority → Everyone
# ----------------------------------------------------
@rpc("authority", "reliable")
func rpc_set_health(new_health: float) -> void:
	_apply_health_updates(new_health)

# ----------------------------------------------------
# Local State Update
# ----------------------------------------------------
func _apply_health_updates(new_health: float) -> void:
	current_health = new_health

	health_changed.emit(current_health)

	if current_health <= 0.0:
		health_depleted.emit()
