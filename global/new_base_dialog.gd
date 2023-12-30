class_name NewBaseDialog extends Window

signal confirmed(base_name)
signal canceled()

func _ready():
	$CanvasLayer/VBoxContainer/LineEdit.grab_focus()

func _process(delta):
	$CanvasLayer/VBoxContainer/HBoxContainer/OkButton.disabled = !is_valid_base_name()

func _unhandled_input(event):
	if event.is_action_pressed("validate") and is_valid_base_name():
		confirm()
	elif event.is_action_pressed("cancel"):
		cancel()

func _on_close_requested():
	close()
	canceled.emit()

func _on_ok_button_pressed():
	confirm()

func _on_cancel_button_pressed():
	cancel()

func open():
	get_tree().paused = true
	$CanvasLayer/VBoxContainer/LineEdit.text = ""
	$CanvasLayer/VBoxContainer/LineEdit.grab_focus()
	visible = true

func close():
	get_tree().paused = false
	visible = false

func confirm():
	close()
	confirmed.emit($CanvasLayer/VBoxContainer/LineEdit.text)

func cancel():
	close()
	canceled.emit()

func is_valid_base_name():
	if len($CanvasLayer/VBoxContainer/LineEdit.text) == 0:
		$CanvasLayer/VBoxContainer/ErrorLabel.text = "Please choose a base name"
		return false
	
	for base in Saver.data.get_bases():
		if base.name.to_lower() == $CanvasLayer/VBoxContainer/LineEdit.text.to_lower():
			$CanvasLayer/VBoxContainer/ErrorLabel.text = "Base name already exists"
			return false

	$CanvasLayer/VBoxContainer/ErrorLabel.text = ""
	return true
