class_name MoneyReport extends Resource

@export var report: Dictionary = {}

func add_entry(continent_type: Continents.Type, amount: int):
	report[continent_type] = amount

func to_richtext_string():
	# TODO: Add total
	var str: String = "[table=3]"
	var total_amount: int = 0
	for continent_type in report:
		var continent = Saver.data.continents.types[continent_type]
		var amount = report[continent_type]
		total_amount += amount
		str += "[cell]%s[/cell]" % continent.name
		str += "[cell]   [/cell]"
		str += "[cell][right][color=green]+%s$[/color][/right][/cell]" % amount
	str += "[cell]Total[/cell]"
	str += "[cell]   [/cell]"
	str += "[cell][right][color=green]+%s$[/color][/right][/cell]" % total_amount
	str += "[/table]"
	return str
