class_name DatetimeData extends Resource

@export var timestamp: float = Time.get_unix_time_from_datetime_dict(Dictionary({year=2024, month=1, day=1, hour=0, minute=0, second=0}))

func spent(time_spent):
	timestamp += time_spent
	return get_date()

func get_date() -> Datetime:
	return Datetime.new(timestamp)

class Datetime:
	var year: int
	var month: int
	var day: int
	var hour: int
	var minute: int
	var second: int
	
	func _init(timestamp: float):
		var datetime = _timestamp_to_date(timestamp)
		year = datetime[0]
		month = datetime[1]
		day = datetime[2]
		hour = datetime[3]
		minute = datetime[4]
		second = datetime[5]
	
	func changed_day(other_date: Datetime):
		return other_date == null or year != other_date.year or month != other_date.month or day != other_date.day
	
	func _timestamp_to_date(current_timestamp):
		var seconds_in_day = 86400
		var days = current_timestamp / seconds_in_day
		var year = 1970

		while days >= 365 + _is_leap_year(year):
			days -= 365 + _is_leap_year(year)
			year += 1

		var month = 1
		while days >= _get_days_in_month(month, year):
			days -= _get_days_in_month(month, year)
			month += 1

		var day = 1 + days
		
		var remaining_seconds = int(current_timestamp) % seconds_in_day
		var hour = remaining_seconds / 3600
		remaining_seconds %= 3600
		var minute = remaining_seconds / 60
		var second = remaining_seconds % 60
		
		return [year, month, day, hour, minute, second]

	func _is_leap_year(year):
		return 1 if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0) else 0

	func _get_days_in_month(month, year):
		if month in [1, 3, 5, 7, 8, 10, 12]:
			return 31
		elif month in [4, 6, 9, 11]:
			return 30
		elif month == 2:
			return 29 if _is_leap_year(year) else 28
		return 0
