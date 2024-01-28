class_name ReportNotification extends Notification

const scene = preload('res://global/notifications/report_notification_panel.tscn')

@export var final_result: bool
@export var vote_record: VoteRecord
@export var report: MoneyReport
@export var date: Datetime

func get_id_name():
	return "report_%s" % date.get_date_str()

func get_display_name():
	return "Report: %s" % date.get_date_str()

func get_scene():
	return scene
