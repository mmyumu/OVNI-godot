extends Node2D

var input_type = "joypad"

var screen_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
#	set_process_input(true)
#	guess_input_device()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	guess_input_device()
#	var actions = InputMap.get_actions()
#
#	for action in actions:
#		Input.
#		InputEvent.is_act

#	if Input.is_anything_pressed():
#		var actions = InputMap.get_actions()
#
#		for action in actions:
#			print(action)
#			var input_events = InputMap.action_get_events(action)
#			Input.is_action_pressed()
#			if input_events.is
#			print(input_events)
#		if Input.is_joy_button_pressed():
#			print("joy")
#		if Input.is_key_pressed():
#			print("key")
#		var devices = Input.get_connected_joypads()
#		for device in devices:
#			print("device: ", device)


#func guess_input_device():
#	if Input.is_anything_pressed():
#		var actions = InputMap.get_actions()
#
#
#		for action in actions:
#			var input_events = InputMap.action_get_events(action)
#			for input_event in input_events:
#				if input_event.is_pressed():
#					print("action: %s, input_event: %s" % [action, input_event])
				
