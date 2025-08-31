extends Control

@onready var start: Control = $"../../Road/Start"
@onready var start_2: Control = $"../../Road/Start2"
@onready var start_3: Control = $"../../Road/Start3"
@onready var start_4: Control = $"../../Road/Start4"
@onready var start_5: Control = $"../../Road/Start5"
@onready var start_6: Control = $"../../Road/Start6"
@onready var buy: Control = $"../../Road/Buy"

@onready var gameplay: CanvasLayer = $"../.."

@onready var money_label: Label = $Label
@onready var money_anim: AnimatedSprite2D = $"../../MoneyLabel/MoneyAnim"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var target_pos: Vector2
var start_pos: Vector2

var road_path: Array = []
var target_idx: int = 1
var rand_buy: bool = false

enum PeopleState {
	Idle,
	Move,
	Buying,
}

var speed: float
var state: PeopleState = PeopleState.Idle

var wait_start: float

var start_end_step: float

func _ready() -> void:
	randomize()
	speed = randf_range(40, 60)
	global_position = start.global_position
	start_pos = global_position
	wait_start = randi_range(0, 30)
	road_path = [start, start_2, start_3, start_4, start_5, start_6]
	target_idx = 1
	set_target_pos(start_2.global_position)
	money_label.hide()
	animated_sprite_2d.hide()
	
	var tween = get_tree().create_tween()
	tween.tween_property(money_label, "position", money_label.position + Vector2.UP * 50, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func set_target_pos(p: Vector2):
	start_pos = global_position
	target_pos = p

func _process(delta: float) -> void:
	wait_start -= delta
	if wait_start > 0:
		return
	start_end_step += delta
	self.global_position = (target_pos - start_pos).normalized() * speed * start_end_step + start_pos
	if target_idx >= 0 and self.global_position.distance_to(target_pos) < 5:
		if target_idx == 2 and !rand_buy and !gameplay.is_shelves_empty():
			rand_buy = true
		target_idx += 1
		start_end_step = 0
		target_idx %= 6
		set_target_pos(road_path[target_idx].global_position)

	if target_idx == -1 and self.global_position.distance_to(target_pos) < 5:
		buy_biscuit()
		target_idx = 3
		start_end_step = 0
		set_target_pos(road_path[target_idx].global_position)
		
	if target_idx != -1 and rand_buy and randf() < 0.7:
		target_idx = -1
		start_end_step = 0
		set_target_pos(buy.global_position)
	
	rand_buy = false

func buy_biscuit():
	if gameplay.shelves.size() <= 0:
		return
	
	var tmp_arr = []
	for i in gameplay.shelves_len:
		if gameplay.shelves[i] != null:
			tmp_arr.append(i)

	if tmp_arr.size() <= 0:
		return
	
	var pick_idx = tmp_arr.pick_random()
	var biscuit = gameplay.shelves[pick_idx]
	
	var money: int
	match biscuit.taste:
		Biscuit.Taste.White:
			money = clamp(int(80 * biscuit.quality), 1, 300)
		Biscuit.Taste.Normal:
			money = clamp(int(100 * biscuit.quality), 1, 300)
		Biscuit.Taste.Strawberry:
			money = clamp(int(150 * biscuit.quality), 1, 300)
		Biscuit.Taste.Grape:
			money = clamp(int(200 * biscuit.quality), 1, 300)
		Biscuit.Taste.Pineapple:
			money = clamp(int(300 * biscuit.quality), 1, 300)

	gameplay.add_money(money)
	gameplay.shelves[pick_idx] = null
	show_money(money)
	biscuit.queue_free()

func show_money(money: int):
	money_label.show()
	money_label.position = Vector2(18, -38)
	money_label.text = "+" + str(money)
	var tween = get_tree().create_tween()
	tween.tween_property(money_label, "position", money_label.position + Vector2.UP * 50, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(money_label.hide)
	animated_sprite_2d.show()
	var tween2 = get_tree().create_tween()
	tween2.tween_property(animated_sprite_2d, "global_position", money_anim.global_position, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween2.tween_callback(animated_sprite_2d.hide)
