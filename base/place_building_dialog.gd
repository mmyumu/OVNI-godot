class_name PlaceBuildingDialog extends Window

var construction: Construction

signal confirmed()
signal canceled()

func _ready():
	$CanvasLayer/VBoxContainer/HBoxContainer/CancelButton.grab_focus()

func _process(delta):
	$CanvasLayer/VBoxContainer/HBoxContainer/OkButton.disabled = !is_valid()

func _unhandled_input(event):
	if event.is_action_pressed("confirm") and is_valid():
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

func open(_construction: Construction):
	construction = _construction
	get_tree().paused = true
	$CanvasLayer/VBoxContainer/HBoxContainer/CancelButton.grab_focus()
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

func is_valid():
	var construction_template: ConstructionTemplateData = Saver.data.construction_templates.templates[construction.template_type]
	if Saver.data.money < construction_template.cost:
		$CanvasLayer/VBoxContainer/ErrorLabel.text = "Not enough money: %s required" % construction_template.cost
		return false
		
	$CanvasLayer/VBoxContainer/ErrorLabel.text = ""
	return true
