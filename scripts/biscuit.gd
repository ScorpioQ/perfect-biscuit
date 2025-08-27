extends Control

class_name Biscuit

@onready var rate: Label = $Rate

enum Taste {
	Normal,
	Blueberry,
	Orange,
	Chocolate,
	Coconut,
}

var quality: float # 0~1 == 0~100%
var taste: Taste

func update_rate(f: float):
	rate.text = str(int(f * 100)) + "%"
