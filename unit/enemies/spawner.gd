extends Node

var enemy = preload("res://unit/enemies/enemy1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn(position, enemy_index):
	var spawned_enemy = enemy.instantiate()
	spawned_enemy.name = "Enemy%s" % enemy_index
	get_parent().add_child(spawned_enemy)
	spawned_enemy.position = position
	spawned_enemy.rotation = TAU/2
	print("Spawned enemy %s at x=%s, y=%s" % [spawned_enemy.name, position.x, position.y])
