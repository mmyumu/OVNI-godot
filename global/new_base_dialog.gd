class_name NewBaseDialog extends Window

signal confirmed()
signal canceled()

func _ready():
	$CanvasLayer/TextEdit.grab_focus()

func _process(delta):
	$CanvasLayer/HBoxContainer/OkButton.disabled = !is_valid_base_name()

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
	$CanvasLayer/TextEdit.text = ""
	$CanvasLayer/TextEdit.grab_focus()
	visible = true

func close():
	get_tree().paused = false
	visible = false

func confirm():
	close()
	confirmed.emit()

func cancel():
	close()
	canceled.emit()

func is_valid_base_name():
	return len($CanvasLayer/TextEdit.text) > 0
