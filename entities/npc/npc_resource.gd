extends Resource
class_name NPCResource

@export var npc_id : String
@export var npc_name: String = "Untitled NPC"
@export var dialogue_index : int = 0
@export var texture : Texture2D
@export var dialogues : Array[NPCDialogue]
@export var completed : bool = false
