class_name Cursor extends Sprite2D

var cursor_sprite = preload("res://art/cursor.png")
var invalid_cursor_sprite = preload("res://art/invalid_cursor.png")

#var is_active: bool
var valid: bool
var mouse_sens: float = 500.0
#var mouse_pos
var last_mouse_pos

signal validated()
signal canceled()

func _input(event):
	if visible:
		if event.is_action_pressed("validate") and is_valid():
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			last_mouse_pos = get_global_mouse_position()
			Input.warp_mouse(last_mouse_pos)
			validated.emit()
		elif event.is_action_pressed("cancel"):
			canceled.emit()
			get_viewport().set_input_as_handled()

func _physics_process(delta):
	if visible:
		var direction: Vector2
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

		if abs(direction.x) == 1 and abs(direction.y) == 1:
			direction = direction.normalized()

		var movement = mouse_sens * direction * delta
		if (movement):  
			global_position += movement
			Input.warp_mouse(global_position)
		global_position = get_global_mouse_position()

func activate():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	visible = true

func deactivate():
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func is_valid():
	return valid

func set_invalid():
	valid = false
	set_texture(invalid_cursor_sprite)
	
func set_valid():
	valid = true
	set_texture(cursor_sprite)
