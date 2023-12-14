extends Node2D

var attack: AttackData

func _ready():
	$AnimatedSprite2D.play()

func set_attack(attack_to_set: AttackData):
	attack = attack_to_set
	position = attack_to_set.location
