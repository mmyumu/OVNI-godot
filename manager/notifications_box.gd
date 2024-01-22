extends Node


signal notification_created(notification: Notification)

func _ready():
	notification_created.connect(_on_notification_created)

func create_delegation_notification(delegation_report: Dictionary):
	var notification = DelegationNotification.new()
	notification.name = "Delegation"
	notification_created.emit(notification)

func create_report_notification(final_result: bool, vote_record: VoteRecord, date: Datetime):
	var notification = ReportNotification.new()
	notification.name = "Report: %s" % date.get_date_str()
	notification.vote_record = vote_record
	notification.final_result = final_result
	
	notification_created.emit(notification)

func _on_notification_created(notification: Notification):
	Saver.data.notifications.append(notification)
	Datetimer.time_factor = 1.
