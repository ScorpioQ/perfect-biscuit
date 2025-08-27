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
var shelve_idx: int
var shelve_marker_pos: Vector2
var shelve_marker_pos2: Vector2
var shelve_marker_pos3: Vector2

func update_rate(f: float):
	rate.text = str(int(f * 100)) + "%"

func move():
	var target_pos = shelve_marker_pos
	if shelve_idx / 10 == 1:
		target_pos = shelve_marker_pos2
	if shelve_idx / 10 == 2:
		target_pos = shelve_marker_pos3
		
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_pos + Vector2(0, 35 * (shelve_idx % 10)), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
