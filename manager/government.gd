extends Node

@export var days_to_check: Array[int] = [1, 15]

var rng = RandomNumberGenerator.new()

signal report_result(success: bool, vote_record: VoteRecord)

func _ready():
	Datetimer.day_changed.connect(_on_day_changed)

func _on_day_changed(date: Datetime):
	#if date.day in days_to_check:
	#if date.day == 1 or date.day == 15:
	report(date)

func report(date: Datetime):
	var vote_record = vote(date)
	var final_result: bool = check_vote(vote_record)
	report_result.emit(final_result, vote_record)

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
