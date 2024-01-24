extends Node

@export var days_to_check: Array[int] = [1, 15]

var rng = RandomNumberGenerator.new()

#signal report_result(success: bool, vote_record: VoteRecord)

func _ready():
	#Datetimer.day_changed.connect(_on_day_changed)
	Datetimer.hour_changed.connect(_on_hour_changed)

func _on_hour_changed(date: Datetime):
	if date.hour == 1:
		if date.day == 1 and date.month == 1 and date.year == 2024:
			delegation(date)
		elif date.day == 1 or date.day == 15:
			report(date)

func delegation(date: Datetime):
	var delegation_report = MoneyReport.new()
	var total_founding_amount: float = 0.
	for continent_type in Saver.data.continents.types:
		var continent = Saver.data.continents.types[continent_type]
		var founding_amount = continent.gdp * 10
		delegation_report.add_entry(continent_type, founding_amount)
		total_founding_amount += founding_amount
	Bank.earn(total_founding_amount)
	NotificationsBox.create_delegation_notification(delegation_report)

func report(date: Datetime):
	var vote_record = vote(date)
	var final_result: bool = check_vote(vote_record)
	
	Bank.earn(1)
	NotificationsBox.create_report_notification(final_result, vote_record, date)

func vote(date: Datetime) -> VoteRecord:
	var vote_record: VoteRecord = VoteRecord.new()
	vote_record.date = Datetime.new(date.timestamp)
	
	var vote_results = {}
	for continent_type in Saver.data.continents.types:
		var continent: Continent = Saver.data.continents.types[continent_type]
		var vote_result = rng.randf()
		
		vote_record.confidences[continent_type] = continent.confidence
		vote_record.results[continent_type] = vote_result
	
	return vote_record

func check_vote(vote_record: VoteRecord):
	var success: int = 0
	var fail: int = 0
	
	for continent_type in Saver.data.continents.types:
		var confidence: float = vote_record.confidences[continent_type]
		var vote_result: float = vote_record.results[continent_type]
		
		if vote_result <= confidence:
			success += 1
		else:
			fail += 1
		
	return success >= fail
