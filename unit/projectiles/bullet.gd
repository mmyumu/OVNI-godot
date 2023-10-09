extends Area2D

@export var damage: int = 10
@export var speed: int = 800
var velocity: Vector2 = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var to_be_freed = (is_in_group("Player") and area.is_in_group("Enemies")) \
			or (is_in_group("Enemies") and area.is_in_group("Player"))
	if to_be_freed:
		queue_free()
