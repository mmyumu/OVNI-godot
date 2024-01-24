extends NotificationPanel

var deadzone = 0.3
var scroll_speed = 5.

var report: MoneyReport:
	set(value):
		report = value
		build_text()

func _process(delta):
	var rs_look = Vector3.ZERO
	rs_look.x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	rs_look.y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)

	if rs_look.length() > deadzone:
		$Window/VBoxContainer/PanelContainer/RichTextLabel.get_v_scroll_bar().value += (rs_look.y * scroll_speed)
		#get_v_scroll().value += rs_look.y
		#if Input.is_action_pressed("ui_down"):
			#
		#elif Input.is_action_pressed("ui_up"):
			#get_v_scroll().value -= 1
		#$CameraGimbal.rotate_y(rs_look.y * delta * rotation_speed)
		#$CameraGimbal/InnerGimbal.rotate_x(rs_look.x * delta * rotation_speed)
		#
		#$CameraGimbal/InnerGimbal.rotation.x = clamp($CameraGimbal/InnerGimbal.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func build_text():
	var new_text = $Window/VBoxContainer/PanelContainer/RichTextLabel.text.replace("<report>", report.to_richtext_string()) 
	$Window/VBoxContainer/PanelContainer/RichTextLabel.text = new_text
