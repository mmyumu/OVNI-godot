extends Node


signal notification_created(notification: Notification)
signal notification_updated(notification: Notification)

func _ready():
	notification_created.connect(_on_notification_created)

func create_delegation_notification(delegation_report: MoneyReport):
	var notification = DelegationNotification.new()
	notification.report = delegation_report
	notification_created.emit(notification)

func create_report_notification(final_result: bool, vote_record: VoteRecord, money_report: MoneyReport, date: Datetime):
	var notification = ReportNotification.new()
	notification.date = Datetime.new(date.timestamp)
	notification.vote_record = vote_record
	notification.report = money_report
	notification.final_result = final_result
	
	notification_created.emit(notification)

func read(notification: Notification):
	notification.status = Notification.Status.READ
	notification_updated.emit(notification)

func delete(notification: Notification):
	notification.status = Notification.Status.DELETED
	notification_updated.emit(notification)


func _on_notification_created(notification: Notification):
	Saver.data.notifications.append(notification)
	Datetimer.time_factor = 1.
