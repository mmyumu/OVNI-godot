extends ConfirmationDialog

func _input(event):
	if event.is_action_pressed("cancel"):
		visible = false
		canceled.emit()
		
