class_name MasterMindData extends Resource

@export var location: Vector2
@export var destination: Vector2
@export var attacks_planned: Array[AttackData] = []
@export var attacks_ongoing: Array[AttackData] = []
@export var attacks_over: Array[AttackData] = []

func get_attack_number():
	return len(attacks_planned) + len(attacks_ongoing) + len(attacks_over)
