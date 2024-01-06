class_name MasterMind extends Resource

@export var location: Vector2
@export var destination: Vector2
@export var attacks: Array[Attack] = []

func get_attack_number():
	return len(attacks) + 1

func get_attacks_planned():
	return self._get_attacks(Attack.Status.PLANNED)

func get_attacks_ongoing():
	return self._get_attacks(Attack.Status.ON_GOING)
	
func _get_attacks(status: Attack.Status):
	var attacks_to_get: Array[Attack] = []
	for attack in attacks:
		if attack.status == status:
			attacks_to_get.append(attack)
	return attacks_to_get
