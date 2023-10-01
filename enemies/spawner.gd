extends Node

var enemy = preload("res://enemies/enemy1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn(position):
	var spawned_enemy = enemy.instantiate()
	get_parent().add_child(spawned_enemy)
	spawned_enemy.position = position
	spawned_enemy.rotation = TAU/2
	print("Spawned enemy %s at x=%s, y=%s" % [spawned_enemy.name, position.x, position.y])
