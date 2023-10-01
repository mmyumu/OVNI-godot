extends Area2D

@export var speed = 400
@export var hp = 100
@export var max_hp = 100

signal shoot(projectile, direction, location)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity: Vector2 = Vector2.ZERO
	var v_x = Input.get_axis("move_left", "move_right")
	var v_y = Input.get_axis("move_up", "move_down")

	velocity.x += v_x
	velocity.y += v_y

	if velocity.length() > 0:
		velocity *= speed

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, GlobalVariables.screen_size)


func _on_turret_shoot(projectile, direction, location):
	shoot.emit(projectile, direction, location)
