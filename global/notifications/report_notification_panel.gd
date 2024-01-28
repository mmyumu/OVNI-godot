extends NotificationPanel

var deadzone = 0.3
var scroll_speed = 5.

var from_mail = tr("department.of.defense@tsc.gov")

var very_positive_subject = tr("Monthly Confidence Vote Results & Budget Review")
var positive_subject = tr("Narrow Confidence Vote Outcome & Budget Status")
var neutral_subject = tr("Tied Vote Outcome & Budget Report")
var negative_subject = tr("Narrow Miss in Confidence Vote & Budget Evaluation")
var very_negative_subject = tr("Confidence Vote Results & Budget Reassessment")

var very_positive_mail = tr("Very positive report mail")
var positive_mail = tr("Positive report mail")
var neutral_mail = tr("Neutral report mail")
var negative_mail = tr("Negative report mail")
var very_negative_report_mail = tr("Very negative report mail")


func _process(delta):
	var rs_look = Vector3.ZERO
	rs_look.x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	rs_look.y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)

	if rs_look.length() > deadzone:
		$Window/VBoxContainer/PanelContainer/RichTextLabel.get_v_scroll_bar().value += (rs_look.y * scroll_speed)


func notification_updated():
	# TODO: Choose the proper one according to the actual result
	$Window/VBoxContainer/GridContainer/FromLabelValue.text = from_mail
	$Window/VBoxContainer/GridContainer/SubjectLabelValue.text = very_positive_subject
	var new_text = very_positive_mail % notification.report.to_richtext_string()
	$Window/VBoxContainer/MarginContainer/PanelContainer/RichTextLabel.text = new_text
