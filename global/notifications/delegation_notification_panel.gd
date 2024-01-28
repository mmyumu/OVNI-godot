extends NotificationPanel

var deadzone = 0.3
var scroll_speed = 5.

var from_mail = tr("department.of.defense@tsc.gov")
var subject = tr("Transfer of Defense Operations and Enhanced Budget Allocation")
var mail = tr("Delegation mail")

func _process(delta):
	var rs_look = Vector3.ZERO
	rs_look.x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	rs_look.y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)

	if rs_look.length() > deadzone:
		$Window/VBoxContainer/MarginContainer/PanelContainer/RichTextLabel.get_v_scroll_bar().value += (rs_look.y * scroll_speed)


func notification_updated():
	$Window/VBoxContainer/GridContainer/FromLabelValue.text = from_mail
	$Window/VBoxContainer/GridContainer/SubjectLabelValue.text = subject
	var new_text = mail % [notification.report.to_richtext_string()]
	$Window/VBoxContainer/MarginContainer/PanelContainer/RichTextLabel.text = new_text
	
	
	
