extends Node

@export var time_factor = 1.0:
	set(value):
		time_factor = value
		time_factor_changed.emit(time_factor)

#var previous_date: Datetime

signal time_factor_changed(time_factor)
signal day_changed(date: Datetime)
signal hour_changed(date: Datetime)

func _ready():
	set_physics_process_internal(true)

func _physics_process(delta):
	spend(delta * time_factor)

func spend(time_to_spend: float):
	var previous_date = Datetime.new(Saver.data.datetime.timestamp)
	
	#var previous_hour = Saver.data.datetime.hour
	#var previous_day = Saver.data.datetime.day
	
	var new_date = Saver.data.datetime.spend(time_to_spend)
	
	#if previous_hour != new_date.hour:
		#hour_changed.emit(new_date)
#
	#if previous_day != new_date.day:
		#hour_changed.emit(new_date)

	if new_date.changed_hour(previous_date):
		hour_changed.emit(new_date)

	if new_date.changed_day(previous_date):
		print("Changed day: %s -> %s" % [previous_date.get_datetime_str(), new_date.get_datetime_str()])
		day_changed.emit(new_date)
	previous_date = Datetime.new(new_date.timestamp)
