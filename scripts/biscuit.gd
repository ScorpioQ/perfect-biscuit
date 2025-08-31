extends Control

class_name Biscuit

@onready var rate: Label = $Rate
@onready var normal: TextureRect = $Normal
@onready var pineapple: TextureRect = $Pineapple
@onready var grape: TextureRect = $Grape
@onready var strawberry: TextureRect = $Strawberry
@onready var white: TextureRect = $White

enum Taste {
	White,
	Normal,
	Pineapple,
	Grape,
	Strawberry,
}

var quality: float # 0~1 == 0~100%
var taste: Taste

var extra_shelve_idx: int
var extra_shelve_marker_pos: Vector2
var extra_shelve_marker_pos2: Vector2
var extra_shelve_marker_pos3: Vector2

var shelve_idx: int
var shelve_marker_pos: Vector2
var shelve_marker_pos2: Vector2
var shelve_marker_pos3: Vector2
var shelve_marker_pos4: Vector2

func _ready() -> void:
	randomize()

func update_rate(f: float):
	rate.text = str(int(f * 100)) + "%"

func set_quality(q: float):
	quality = clampf(q, 0, 1)

func move_to_extra_shelves():
	var target_pos = extra_shelve_marker_pos
	if extra_shelve_idx / 10 == 1:
		target_pos = extra_shelve_marker_pos2
	if extra_shelve_idx / 10 == 2:
		target_pos = extra_shelve_marker_pos3
		
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_pos - Vector2(19 * (extra_shelve_idx % 10), 0), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func move_to_shelves():
	var target_pos = shelve_marker_pos + Vector2(randf_range(-24, 24), randf_range(-16, 16))
	if shelve_idx / 10 == 1:
		target_pos = shelve_marker_pos2 + Vector2(randf_range(-24, 24), randf_range(-16, 16))
	if shelve_idx / 10 == 2:
		target_pos = shelve_marker_pos3 + Vector2(randf_range(-24, 24), randf_range(-16, 16))
	if shelve_idx / 10 == 3:
		target_pos = shelve_marker_pos4 + Vector2(randf_range(-24, 24), randf_range(-16, 16))
		
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func set_taste(t: Taste):
	taste = t
	match t:
		Taste.White:
			white.show()
			normal.hide()
			pineapple.hide()
			grape.hide()
			strawberry.hide()
		Taste.Normal:
			white.hide()
			normal.show()
			pineapple.hide()
			grape.hide()
			strawberry.hide()
		Taste.Pineapple:
			white.hide()
			normal.hide()
			pineapple.show()
			grape.hide()
			strawberry.hide()
		Taste.Grape:
			white.hide()
			normal.hide()
			pineapple.hide()
			grape.show()
			strawberry.hide()
		Taste.Strawberry:
			white.hide()
			normal.hide()
			pineapple.hide()
			grape.hide()
			strawberry.show()
