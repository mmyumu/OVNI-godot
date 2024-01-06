extends Node

@export var time_factor = 1.0

signal day_changed(date: Datetime)

func _ready():
	set_physics_process_internal(true)

func _physics_process(delta):
	var dates = Saver.data.datetime.spent(delta * time_factor)
	var previous_date: Datetime = dates[0]
	var new_date: Datetime = dates[1]
	if new_date.changed_day(previous_date):
		print("Changed day: %s -> %s" % [previous_date.get_datetime_str(), new_date.get_datetime_str()])
		day_changed.emit(new_date)
