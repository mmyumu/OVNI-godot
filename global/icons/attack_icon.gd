class_name AttackIcon extends Icon

var attack: Attack:
	set(value):
		attack = value
		position = value.location
		$VBoxContainer/Label.text = attack.name
