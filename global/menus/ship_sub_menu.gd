extends SubMenu

var ship: Ship

signal deploy_pressed(ship: Ship)
signal return_pressed(ship: Ship)
signal goto_pressed(ship: Ship)
signal back_pressed()

func _ready():
	first_button = $Deploy

func _on_back_pressed():
	back_pressed.emit()

func _on_deploy_pressed():
	deploy_pressed.emit(ship)

func _on_return_pressed():
	return_pressed.emit(ship)

func _on_go_to_pressed():
	goto_pressed.emit(ship)
