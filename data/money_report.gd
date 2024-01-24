class_name MoneyReport extends Resource

@export var report: Dictionary = {}

func add_entry(continent_type: Continents.Type, amount: int):
	report[continent_type] = amount

func to_richtext_string():
	var str: String = "[table=2]"
	for continent_type in report:
		var continent = Saver.data.continents.types[continent_type]
		var amount = report[continent_type]
		str += "[cell]%s[/cell]" % continent.name
		str += "[cell][color=green]+%s$[/color][/cell]" % amount
	str += "[/table]"
	return str
