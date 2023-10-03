extends Area2D

@export var hp = 10
@export var max_hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Player"):
		
		# TODO : get the
		if area.is_in_group("Projectile"):
			hp -= 10
			if hp <= 0:
				queue_free()
