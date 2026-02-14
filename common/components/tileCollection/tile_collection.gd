extends Node2D
class_name TileCollection

var layers : Array[TileMapLayer]

func _ready() -> void:
	for child in get_children():
		if child is TileMapLayer:
			layers.append(child)

func get_tile_map_size() -> Rect2i:
	var map_size: Rect2i
	var first := true
	for layer in layers:
		var layer_size: Rect2i = layer.get_used_rect()
		if first:
			map_size = layer_size
			first = false
		else:
			map_size = map_size.merge(layer_size)
	return map_size

func random_position()-> Vector2:
	var random_position = Vector2()
	var tile_area :Rect2i = get_tile_map_size()
	var position_in_map=Vector2( randi_range(tile_area.position.x, tile_area.end.x - 1),
	 randi_range(tile_area.position.y, tile_area.end.y - 1))
	var layer : TileMapLayer = layer_with_position(position_in_map)
	if layer != null:
		random_position = layer.to_global(layer.map_to_local(position_in_map))
	return random_position

func layer_with_position(map_position: Vector2)->TileMapLayer:
	for layer in layers:
		var layer_has_position = layer.get_cell_source_id(map_position)
		if layer_has_position !=-1:
			return layer
	return null
