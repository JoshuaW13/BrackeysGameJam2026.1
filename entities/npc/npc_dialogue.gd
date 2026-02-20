extends Resource
class_name NPCDialogue

@export var condition: DialogueCondition
@export_multiline var pass_dialogues : Array[String]
@export var pass_functions : Array[Array]
@export_multiline var fail_dialogues : Array[String]
@export var fail_functions : Array[Array]
