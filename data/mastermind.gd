class_name MasterMindData extends Resource

@export var location: Vector2
@export var destination: Vector2
@export var attacks: Array[AttackData] = []

func get_attack_number():
	return len(attacks) + 1

func get_attacks_planned():
	return self._get_attacks(AttackData.Status.PLANNED)

func get_attacks_ongoing():
	return self._get_attacks(AttackData.Status.ON_GOING)
	
func _get_attacks(status: AttackData.Status):
	var attacks_to_get: Array[AttackData] = []
	for attack in attacks:
		if attack.status == status:
			attacks_to_get.append(attack)
	return attacks_to_get
