extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _shortcut_input(event):
	if Input.is_action_pressed("pause"):
		var is_paused = get_tree().paused
		get_tree().paused = !is_paused

		if is_paused:
			$PauseMessage/PauseLabel.hide()
			$PauseMessage/ResumeLabel.hide()
		else:
			$PauseMessage/PauseLabel.show()
			$PauseMessage/ResumeLabel.show()
