extends Area2D

@export var hp = 10
@export var max_hp = 10
@export var damage = 5
@export var money = 1000

@export var ai_scene: PackedScene

var ai

signal shoot(projectile, direction, location)
signal enemy_destroyed(enemy)

# Called when the node enters the scene tree for the first time.
func _ready():
	ai = ai_scene.instantiate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = ai.compute_position(delta, position)


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Player"):
		if "damage" in area:
			hp -= area.damage
		if hp <= 0:
			queue_free()
			enemy_destroyed.emit(self)
		
		if area.is_in_group("Projectile"):
			area.queue_free()


func _on_weapon_shoot(projectile, direction, location):
#	print("enemy _on_weapon_shoot")
	shoot.emit(projectile, direction, location)
