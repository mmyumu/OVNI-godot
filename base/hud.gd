extends CanvasLayer


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_construction_pressed():
	$RootMenu.hide()
	$ConstructionMenu.show()
