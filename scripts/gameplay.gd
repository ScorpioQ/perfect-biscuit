extends Node2D

@onready var choose_number: Control = $CanvasLayer/ChooseNumber

# Choose Area
@onready var choose_button: Control = $CanvasLayer/ChooseButton
@onready var egg_btn: Button = $CanvasLayer/ChooseButton/HBoxContainer/Egg
@onready var butter_btn: Button = $CanvasLayer/ChooseButton/HBoxContainer/Butter
@onready var flour_btn: Button = $CanvasLayer/ChooseButton/HBoxContainer/Flour
@onready var suger_btn: Button = $CanvasLayer/ChooseButton/HBoxContainer/Suger
@onready var choose_box: TextureRect = $CanvasLayer/ChooseButton/ChooseBox

@onready var cook_number_label: Label = $CanvasLayer/CookNumberLabel

# filling text
@onready var filling_progress: Control = $CanvasLayer/FillingProgress

@onready var egg_target_label: RichTextLabel = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer/VBoxContainer/EggTargetLabel
@onready var egg_texture_progress_bar: TextureProgressBar = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer/VBoxContainer2/EggTextureProgressBar
@onready var egg_max: Label = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer/VBoxContainer2/EggMax
@onready var egg_min: Label = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer/VBoxContainer2/EggMin

@onready var butter_target_label: RichTextLabel = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer2/VBoxContainer2/ButterTargetLabel
@onready var butter_texture_progress_bar: TextureProgressBar = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer2/VBoxContainer/ButterTextureProgressBar
@onready var butter_max: Label = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer2/VBoxContainer/ButterMax
@onready var butter_min: Label = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer2/VBoxContainer/ButterMin

@onready var suger_target_label: RichTextLabel = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer3/VBoxContainer3/SugerTargetLabel
@onready var suger_texture_progress_bar: TextureProgressBar = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer3/VBoxContainer/SugerTextureProgressBar
@onready var suger_max: Label = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer3/VBoxContainer/SugerMax
@onready var suger_min: Label = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer3/VBoxContainer/SugerMin

@onready var flour_target_label: RichTextLabel = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer4/VBoxContainer/FlourTargetLabel
@onready var flour_texture_progress_bar: TextureProgressBar = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer4/VBoxContainer2/FlourTextureProgressBar
@onready var flour_max: Label = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer4/VBoxContainer2/FlourMax
@onready var flour_min: Label = $CanvasLayer/FillingProgress/HBoxContainer/HBoxContainer4/VBoxContainer2/FlourMin

@onready var add_label: Label = $CanvasLayer/FillingArea/AddLabel
@onready var notice_label: Label = $CanvasLayer/NoticeLabel

# mouse
@onready var fill_target: Sprite2D = $CanvasLayer/FillTarget

@onready var best_rate_label: Label = $CanvasLayer/BestRateLabel
@onready var baker: AnimatedSprite2D = $CanvasLayer/Baker
@onready var baker_best_rate_label: Label = $CanvasLayer/Baker/BakerBestRateLabel

@onready var next_button: Button = $CanvasLayer/NextButton
@onready var back_button: Button = $CanvasLayer/BackButton

@onready var shelves_maker: Control = $CanvasLayer/ShelvesMaker
@onready var shelves_maker_2: Control = $CanvasLayer/ShelvesMaker2
@onready var shelves_maker_3: Control = $CanvasLayer/ShelvesMaker3

@onready var money_label: Label = $CanvasLayer/MoneyLabel
@onready var star_label: Label = $CanvasLayer/StarLabel

@onready var start: Control = $CanvasLayer/Road/Start
@onready var start_2: Control = $CanvasLayer/Road/Start2
@onready var start_3: Control = $CanvasLayer/Road/Start3
@onready var start_4: Control = $CanvasLayer/Road/Start4
@onready var buy: Control = $CanvasLayer/Road/Buy

# debug
@onready var debug_filling_state_label: Label = $CanvasLayer/DebugFillingStateLabel
@onready var debug_cook_state_label: Label = $CanvasLayer/DebugCookStateLabel


@export var biscuit_tscn: PackedScene

enum FillingState {
	None,
	ReadyFill,
	Filling
}

enum CookState {
	None,
	Number,
	Filling,
	Extra,
	Bake,
}

enum BakerState {
	None,
	Working,
	Trans,
}

var filling_state: FillingState = FillingState.None
var cook_state: CookState = CookState.None
var baker_state: BakerState = BakerState.None
const baker_working_time = 1
var baker_start_working_time = 0
var baker_number: int = 0

var shelves: Array = []
var people: Array = []

var baking: Array[Biscuit]
var baking_best_rate: float

var best_rate: float

# filling
var egg_filling_speed: float = 200.0
var butter_filling_speed: float = 200.0
var suger_filling_speed: float = 200.0
var flour_filling_speed: float = 100.0

const egg_target_text = "%s / %s"
const butter_target_text = "%sg / %sg"
const flour_target_text = "%sg / %sg"
const suger_target_text = "%sg / %sg"

const x1_egg_min: int = 0
const x1_egg_best: int = 1
const x1_egg_max: int = 2
const x1_butter_min: int = 0
const x1_butter_best: int = 10
const x1_butter_max: int = 15
const x1_flour_min: int = 0
const x1_flour_best: int = 400
const x1_flour_max: int = 600
const x1_suger_min: int = 0
const x1_suger_best: int = 15
const x1_suger_max: int = 30

var egg_cur: int
var butter_cur: int
var flour_cur: int
var suger_cur: int
var cur_filling: Filling

var start_filling_progress: float

var cook_number: int = 1

var money: int = 0
var score: float
var score_num: int

enum Filling {
	None,
	Egg,
	Butter,
	Flour,
	Suger,
}

const shelves_len: int = 30
const shelves_col_len: int = 10

var baker_wait_num: int

func _ready() -> void:
	reset_progress_min_max()
	set_cook_state(CookState.Number)
	star_label.set_point(0)
	for i in shelves_len:
		shelves.append(null)

func _process(delta: float) -> void:
	match filling_state:
		FillingState.ReadyFill:
			fill_target.position = get_global_mouse_position()
		FillingState.Filling:
			filling(delta)
		_:
			pass
	
	match baker_state:
		BakerState.Working:
			if int(Time.get_unix_time_from_system()) - baker_start_working_time >= baker_working_time * baker_number:
				baker_state = BakerState.Trans
				baker.play("full")
				baker_wait_num = baker_number
				
		BakerState.Trans:
			if baker_wait_num > 0:
				var empty_idx = find_first_shelves_empty()
				if empty_idx != -1:
					baker_wait_num -= 1
					var b = create_biscuit()
					b.shelve_idx = empty_idx
					b.quality = randf_range(baking_best_rate - 0.05, baking_best_rate + 0.05)
					b.taste = Biscuit.Taste.Normal
					b.shelve_marker_pos = shelves_maker.global_position
					b.shelve_marker_pos2 = shelves_maker_2.global_position
					b.shelve_marker_pos3 = shelves_maker_3.global_position
					b.update_rate(b.quality)
					b.move()
					shelves[empty_idx] = b
				
				if baker_wait_num == 0:
					baker_best_rate_label.hide()
					baker_state = BakerState.None
					baker.play("idle")
		_:
			pass

func find_first_shelves_empty() -> int:
	for i in shelves_len:
		if shelves[i] == null:
			return i
	
	return -1

func reset_progress_min_max():
	egg_target_label.text = egg_target_text % [egg_cur, x1_egg_best * cook_number]
	egg_min.text = str(x1_egg_min * cook_number)
	egg_max.text = str(x1_egg_max * cook_number)

	butter_target_label.text = butter_target_text % [butter_cur, x1_butter_best * cook_number]
	butter_min.text = str(x1_butter_min * cook_number) + "g"
	butter_max.text = str(x1_butter_max * cook_number) + "g"

	flour_target_label.text = flour_target_text % [flour_cur, x1_flour_best * cook_number]
	flour_min.text = str(x1_flour_min * cook_number) + "g"
	flour_max.text = str(x1_flour_max * cook_number) + "g"

	suger_target_label.text = suger_target_text % [suger_cur, x1_suger_best * cook_number]
	suger_min.text = str(x1_suger_min * cook_number) + "g"
	suger_max.text = str(x1_suger_max * cook_number) + "g"

func set_filling_state(s: FillingState):
	filling_state = s
	match filling_state:
		FillingState.ReadyFill:
			debug_filling_state_label.text = "ReadyFill"
		FillingState.Filling:
			debug_filling_state_label.text = "Filling"
		_:
			debug_filling_state_label.text = "None"

func set_cook_state(s: CookState):
	cook_state = s
	choose_btn(Filling.None)
	match cook_state:
		CookState.Number:
			debug_cook_state_label.text = "Number"
			choose_number.show()
			filling_progress.hide()
			choose_button.hide()
			cook_number_label.hide()
			back_button.hide()
			next_button.hide()
			
		CookState.Filling:
			debug_cook_state_label.text = "Filling"
			flour_texture_progress_bar.value = 0
			butter_texture_progress_bar.value = 0
			egg_texture_progress_bar.value = 0
			suger_texture_progress_bar.value = 0
			choose_number.hide()
			filling_progress.show()
			choose_button.show()
			cook_number_label.show()
			back_button.show()
			next_button.show()
			next_button.text = "Next"
			
		CookState.Extra:
			debug_cook_state_label.text = "Extra"
			choose_number.hide()
			filling_progress.hide()
			choose_button.hide()
			cook_number_label.show()
			back_button.show()
			next_button.show()
			next_button.text = "Bake"

		CookState.Bake:
			back_button.hide()
			next_button.hide()
			baker_number = cook_number
			baking_best_rate = best_rate
			baker_best_rate_label.text = "Best: " + str(int(baking_best_rate * 100)) + "%"
			baker_best_rate_label.show()
			baker_start_working_time = int(Time.get_unix_time_from_system())
			baker_state = BakerState.Working
			debug_cook_state_label.text = "Bake"
			baker.play("baking")
			egg_cur = 0
			butter_cur = 0
			flour_cur = 0
			suger_cur = 0
			best_rate = 1
			cook_number = 0
			set_cook_state(CookState.Number)
		_:
			debug_cook_state_label.text = "None"
			choose_number.hide()
			filling_progress.hide()
			choose_button.hide()
			cook_number_label.hide()
			back_button.hide()
			next_button.hide()

func _input(event: InputEvent) -> void:
	if filling_state == FillingState.ReadyFill:
		if Input.is_action_pressed("cancel_filling"):
			choose_btn(Filling.None)

func start_filling():
	match cur_filling:
		Filling.Flour:
			start_filling_progress = flour_texture_progress_bar.value
		Filling.Egg:
			start_filling_progress = egg_texture_progress_bar.value
		Filling.Butter:
			start_filling_progress = butter_texture_progress_bar.value
		Filling.Suger:
			start_filling_progress = suger_texture_progress_bar.value
	set_filling_state(FillingState.Filling)

func filling(delta: float) -> void:
	match cur_filling:
		Filling.Flour:
			flour_texture_progress_bar.value += delta * flour_filling_speed
		Filling.Egg:
			egg_texture_progress_bar.value += delta * egg_filling_speed
		Filling.Butter:
			butter_texture_progress_bar.value += delta * butter_filling_speed
		Filling.Suger:
			suger_texture_progress_bar.value += delta * suger_filling_speed

func stop_filling():
	set_filling_state(FillingState.ReadyFill)
	
	var total: int
	var add: int
	match cur_filling:
		Filling.Egg:
			total = int(egg_texture_progress_bar.value / 100.0 * x1_egg_max * cook_number)
			add = int((egg_texture_progress_bar.value - start_filling_progress) / 100.0 * x1_egg_max * cook_number)
			add_label.text = "Egg +" + str(add)
			egg_cur = int(total)
			egg_target_label.text = egg_target_text % [egg_cur, x1_egg_best * cook_number]
			if egg_cur > x1_egg_best * cook_number:
				egg_target_label.text = egg_target_text % [str("[color=red]" + str(egg_cur) + "[/color]"), x1_egg_best * cook_number]
		Filling.Butter:
			total = int(butter_texture_progress_bar.value / 100.0 * x1_butter_max * cook_number)
			add = int((butter_texture_progress_bar.value - start_filling_progress) / 100.0 * x1_butter_max * cook_number)
			add_label.text = "Butter +" + str(add) + "g"
			butter_cur = int(total)
			butter_target_label.text = butter_target_text % [butter_cur, x1_butter_best * cook_number]
			if butter_cur > x1_butter_best * cook_number:
				butter_target_label.text = butter_target_text % [str("[color=red]" + str(butter_cur) + "[/color]"), x1_butter_best * cook_number]
		Filling.Flour:
			total = int(flour_texture_progress_bar.value / 100.0 * x1_flour_max * cook_number)
			add = int((flour_texture_progress_bar.value - start_filling_progress) / 100.0 * x1_flour_max * cook_number)
			add_label.text = "Flour +" + str(add) + "g"
			flour_cur = int(total)
			flour_target_label.text = flour_target_text % [flour_cur, x1_flour_best * cook_number]
			if flour_cur > x1_flour_best * cook_number:
				flour_target_label.text = flour_target_text % [str("[color=red]" + str(flour_cur) + "[/color]"), x1_flour_best * cook_number]
		Filling.Suger:
			total = int(suger_texture_progress_bar.value / 100.0 * x1_suger_max * cook_number)
			add = int((suger_texture_progress_bar.value - start_filling_progress) / 100.0 * x1_suger_max * cook_number)
			add_label.text = "Suger +" + str(add) + "g"
			suger_cur = int(total)
			suger_target_label.text = suger_target_text % [suger_cur, x1_suger_best * cook_number]
			if suger_cur > x1_suger_best * cook_number:
				suger_target_label.text = suger_target_text % [str("[color=red]" + str(suger_cur) + "[/color]"), x1_suger_best * cook_number]

	best_rate = 1.00
	if egg_cur > 0:
		best_rate -= abs(egg_cur - x1_egg_best * cook_number) * 0.05 / cook_number
	if butter_cur > 0:
		best_rate -= abs(butter_cur - x1_butter_best * cook_number) * 0.01 / cook_number
	if suger_cur > 0:
		best_rate -= abs(suger_cur - x1_suger_best * cook_number) * 0.01 / cook_number
	if flour_cur > 0:
		best_rate -= abs(flour_cur - x1_flour_best * cook_number) * 0.005 / cook_number
	best_rate = clamp(best_rate, 0, 1)
	best_rate_label.text = "Best: " + str(int(best_rate * 100)) + "%"

	add_label.show()
	add_label.position = Vector2(110, -158)
	var tween = get_tree().create_tween()
	tween.tween_property(add_label, "position", add_label.position + Vector2.UP * 50, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(add_label.hide)
	
func _on_egg_button_down() -> void:
	choose_btn(Filling.Egg)

func _on_butter_button_down() -> void:
	choose_btn(Filling.Butter)

func _on_flour_button_down() -> void:
	choose_btn(Filling.Flour)

func _on_suger_button_down() -> void:
	choose_btn(Filling.Suger)

func choose_btn(f: Filling):
	match f:
		Filling.Egg:
			choose_box_focus(egg_btn)
			fill_target_change(egg_btn)
			cur_filling = Filling.Egg
		Filling.Butter:
			choose_box_focus(butter_btn)
			fill_target_change(butter_btn)
			cur_filling = Filling.Butter
		Filling.Flour:
			choose_box_focus(flour_btn)
			fill_target_change(flour_btn)
			cur_filling = Filling.Flour
		Filling.Suger:
			choose_box_focus(suger_btn)
			fill_target_change(suger_btn)
			cur_filling = Filling.Suger
		_:
			choose_box_focus(null)
			fill_target_change(null)
			cur_filling = Filling.None
			start_filling_progress = 0

func choose_box_focus(target: Button):
	if target:
		choose_box.global_position = target.global_position
		choose_box.show()
	else:
		choose_box.hide()
	
	if filling_state != FillingState.ReadyFill:
		filling_state = FillingState.ReadyFill

func fill_target_change(target: Button):
	if target:
		fill_target.texture = ImageTexture.create_from_image(target.icon.get_image())
		fill_target.show()
		set_filling_state(FillingState.ReadyFill)
	else:
		fill_target.hide()

func _on_filling_rect_button_down() -> void:
	if filling_state != FillingState.ReadyFill:
		return
	start_filling()
	
func _on_filling_rect_button_up() -> void:
	if filling_state != FillingState.Filling:
		return
	stop_filling()

func _on_next_button_pressed() -> void:
	match cook_state:
		CookState.None:
			set_cook_state(CookState.Number)
		CookState.Number:
			set_cook_state(CookState.Filling)
		CookState.Filling:
			set_cook_state(CookState.Extra)
		CookState.Extra:
			if baker_state != BakerState.None:
				show_notice("Please wait. Baker is working")
				return
			if egg_cur == 0 and butter_cur == 0 and flour_cur == 0 and suger_cur == 0:
				show_notice("nothing to bake")
				return
			set_cook_state(CookState.Bake)
		_:
			pass

func _on_back_button_pressed() -> void:
	match cook_state:
		CookState.None:
			set_cook_state(CookState.None)
		CookState.Number:
			set_cook_state(CookState.None)
		CookState.Filling:
			set_cook_state(CookState.Number)
		CookState.Extra:
			set_cook_state(CookState.Filling)
		_:
			pass

func _on_x_1_pressed() -> void:
	cook_number = 1
	set_cook_state(CookState.Filling)
	cook_number_label.text = "Cook 1 Biscuit"
	cook_number_label.show()
	reset_progress_min_max()

func _on_x_3_pressed() -> void:
	cook_number = 3
	set_cook_state(CookState.Filling)
	cook_number_label.text = "Cook 3 Biscuit"
	cook_number_label.show()
	reset_progress_min_max()

func _on_x_5_pressed() -> void:
	cook_number = 5
	set_cook_state(CookState.Filling)
	cook_number_label.text = "Cook 5 Biscuit"
	cook_number_label.show()
	reset_progress_min_max()

func _on_x_10_pressed() -> void:
	cook_number = 10
	set_cook_state(CookState.Filling)
	cook_number_label.text = "Cook 10 Biscuit"
	cook_number_label.show()
	reset_progress_min_max()

func show_notice(msg: String):
	notice_label.text = msg
	notice_label.show()
	notice_label.position = Vector2(59, 87)
	var tween = get_tree().create_tween()
	tween.tween_property(notice_label, "position", notice_label.position + Vector2.UP * 50, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(notice_label.hide)

func create_biscuit() -> Control:
	var biscuit = biscuit_tscn.instantiate()
	biscuit.global_position = baker.global_position
	self.add_child(biscuit)
	return biscuit

func add_money(add: int):
	money += add
	money_label.text = str(money)

func add_score(s: int):
	score = (score * score_num + s) / (score_num + 1)
	score_num += 1
	star_label.set_point(score)
