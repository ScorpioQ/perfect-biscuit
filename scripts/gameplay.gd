extends CanvasLayer

# Choose Area
@onready var choose_button: Control = $ChooseButton
@onready var egg_btn: TextureButton = $ChooseButton/HBoxContainer/Egg
@onready var butter_btn: TextureButton = $ChooseButton/HBoxContainer/Butter
@onready var flour_btn: TextureButton = $ChooseButton/HBoxContainer/Flour
@onready var suger_btn: TextureButton = $ChooseButton/HBoxContainer/Suger

# filling text
@onready var filling_progress: Control = $FillingProgress

@onready var egg_target_label: RichTextLabel = $FillingProgress/HBoxContainer/HBoxContainer/VBoxContainer/EggTargetLabel
@onready var egg_texture_progress_bar: TextureProgressBar = $FillingProgress/HBoxContainer/HBoxContainer/VBoxContainer2/EggTextureProgressBar
@onready var egg_max: Label = $FillingProgress/HBoxContainer/HBoxContainer/VBoxContainer2/EggMax
@onready var egg_min: Label = $FillingProgress/HBoxContainer/HBoxContainer/VBoxContainer2/EggMin

@onready var butter_target_label: RichTextLabel = $FillingProgress/HBoxContainer/HBoxContainer2/VBoxContainer2/ButterTargetLabel
@onready var butter_texture_progress_bar: TextureProgressBar = $FillingProgress/HBoxContainer/HBoxContainer2/VBoxContainer/ButterTextureProgressBar
@onready var butter_max: Label = $FillingProgress/HBoxContainer/HBoxContainer2/VBoxContainer/ButterMax
@onready var butter_min: Label = $FillingProgress/HBoxContainer/HBoxContainer2/VBoxContainer/ButterMin

@onready var suger_target_label: RichTextLabel = $FillingProgress/HBoxContainer/HBoxContainer3/VBoxContainer3/SugerTargetLabel
@onready var suger_texture_progress_bar: TextureProgressBar = $FillingProgress/HBoxContainer/HBoxContainer3/VBoxContainer/SugerTextureProgressBar
@onready var suger_max: Label = $FillingProgress/HBoxContainer/HBoxContainer3/VBoxContainer/SugerMax
@onready var suger_min: Label = $FillingProgress/HBoxContainer/HBoxContainer3/VBoxContainer/SugerMin

@onready var flour_target_label: RichTextLabel = $FillingProgress/HBoxContainer/HBoxContainer4/VBoxContainer/FlourTargetLabel
@onready var flour_texture_progress_bar: TextureProgressBar = $FillingProgress/HBoxContainer/HBoxContainer4/VBoxContainer2/FlourTextureProgressBar
@onready var flour_max: Label = $FillingProgress/HBoxContainer/HBoxContainer4/VBoxContainer2/FlourMax
@onready var flour_min: Label = $FillingProgress/HBoxContainer/HBoxContainer4/VBoxContainer2/FlourMin

@onready var add_label: Label = $FillingArea/AddLabel
@onready var notice_label: Label = $NoticeLabel

@onready var best_rate_label: Label = $BestRateLabel
@onready var baker: AnimatedSprite2D = $Baker
@onready var baker_best_rate_label: Label = $Baker/BakerBestRateLabel

@onready var bake_button: Button = $BakeButton
@onready var shelve_button: Button = $ShelveButton

@onready var shelves_maker: Control = $Shelves/ShelvesMaker
@onready var shelves_maker_2: Control = $Shelves/ShelvesMaker2
@onready var shelves_maker_3: Control = $Shelves/ShelvesMaker3

@onready var extra_shelves_maker: Control = $ExtraShelves/ExtraShelvesMaker
@onready var extra_shelves_maker_2: Control = $ExtraShelves/ExtraShelvesMaker2
@onready var extra_shelves_maker_3: Control = $ExtraShelves/ExtraShelvesMaker3

@onready var money_label: Label = $MoneyLabel
@onready var star_label: Label = $StarLabel

@onready var biscuit_number_label: Label = $FillingProgress/HBoxContainer/HBoxContainer5/BiscuitNumberLabel
@onready var people: Control = $People


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
	Bake,
	Extra,
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

var extra_shelves: Array[Biscuit] = []
var shelves: Array[Biscuit] = []

var baking: Array[Biscuit]
var baking_best_rate: float

var best_rate: float

# filling
var egg_filling_speed: float = 200.0
var butter_filling_speed: float = 200.0
var suger_filling_speed: float = 200.0
var flour_filling_speed: float = 100.0

const egg_target_text = "%s"
const butter_target_text = "%s g"
const flour_target_text = "%s g"
const suger_target_text = "%s g"

const x1_egg_min: int = 0
const x1_egg_best: int = 1
const x1_egg_max: int = 2

const x1_butter_min: int = 0
const x1_butter_best: int = 50
const x1_butter_max: int = 60

const x1_suger_min: int = 0
const x1_suger_best: int = 30
const x1_suger_max: int = 40

const x1_flour_min: int = 0
const x1_flour_best: int = 100
const x1_flour_max: int = 120

var egg_cur: int
var butter_cur: int
var flour_cur: int
var suger_cur: int
var cur_filling: Filling

var start_filling_progress: float

var cook_number: int = 0

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
const extra_shelves_len: int = 30
const shelves_col_len: int = 10

var baker_wait_num: int

func _ready() -> void:
	reset_progress_min_max()
	star_label.set_point(0)
	for i in shelves_len:
		shelves.append(null)
	for i in extra_shelves_len:
		extra_shelves.append(null)
	
	flour_texture_progress_bar.value = 0
	butter_texture_progress_bar.value = 0
	egg_texture_progress_bar.value = 0
	suger_texture_progress_bar.value = 0
	people.show()

func _process(delta: float) -> void:
	match filling_state:
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
				var empty_idx = find_first_extra_shelves_empty()
				if empty_idx != -1:
					baker_wait_num -= 1
					var b = create_biscuit() as Biscuit
					b.extra_shelve_idx = empty_idx
					b.quality = randf_range(baking_best_rate - 0.05, baking_best_rate + 0.05)
					b.taste = Biscuit.Taste.Normal
					b.extra_shelve_marker_pos = extra_shelves_maker.global_position
					b.extra_shelve_marker_pos2 = extra_shelves_maker_2.global_position
					b.extra_shelve_marker_pos3 = extra_shelves_maker_3.global_position
					b.update_rate(b.quality)
					b.move_to_extra_shelves()
					extra_shelves[empty_idx] = b
				
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

func find_first_extra_shelves_empty() -> int:
	for i in extra_shelves_len:
		if extra_shelves[i] == null:
			return i
	
	return -1

func reset_progress_min_max():
	egg_target_label.text = egg_target_text % egg_cur
	egg_min.text = str(x1_egg_min)
	egg_max.text = str(x1_egg_max)

	butter_target_label.text = butter_target_text % butter_cur
	butter_min.text = str(x1_butter_min) + "g"
	butter_max.text = str(x1_butter_max) + "g"

	flour_target_label.text = flour_target_text % flour_cur
	flour_min.text = str(x1_flour_min) + "g"
	flour_max.text = str(x1_flour_max) + "g"

	suger_target_label.text = suger_target_text % suger_cur
	suger_min.text = str(x1_suger_min) + "g"
	suger_max.text = str(x1_suger_max) + "g"

func set_filling_state(s: FillingState):
	filling_state = s

func _input(event: InputEvent) -> void:
	pass

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
			total = int(egg_texture_progress_bar.value / 100.0 * x1_egg_max)
			add = int((egg_texture_progress_bar.value - start_filling_progress) / 100.0 * x1_egg_max)
			add_label.text = "Egg +" + str(add)
			egg_cur = int(total)
			egg_target_label.text = egg_target_text % egg_cur
			#if egg_cur > x1_egg_best:
				#egg_target_label.text = egg_target_text % [str("[color=red]" + str(egg_cur) + "[/color]"), x1_egg_best]
		Filling.Butter:
			total = int(butter_texture_progress_bar.value / 100.0 * x1_butter_max)
			add = int((butter_texture_progress_bar.value - start_filling_progress) / 100.0 * x1_butter_max)
			add_label.text = "Butter +" + str(add) + "g"
			butter_cur = int(total)
			butter_target_label.text = butter_target_text % butter_cur
			#if butter_cur > x1_butter_best:
				#butter_target_label.text = butter_target_text % [str("[color=red]" + str(butter_cur) + "[/color]"), x1_butter_best]
		Filling.Flour:
			total = int(flour_texture_progress_bar.value / 100.0 * x1_flour_max)
			add = int((flour_texture_progress_bar.value - start_filling_progress) / 100.0 * x1_flour_max)
			add_label.text = "Flour +" + str(add) + "g"
			flour_cur = int(total)
			
			cook_number = flour_cur / 10
			biscuit_number_label.text = "x" + str(cook_number)
			
			flour_target_label.text = flour_target_text % flour_cur
			#if flour_cur > x1_flour_best:
				#flour_target_label.text = flour_target_text % [str("[color=red]" + str(flour_cur) + "[/color]"), x1_flour_best]
		Filling.Suger:
			total = int(suger_texture_progress_bar.value / 100.0 * x1_suger_max)
			add = int((suger_texture_progress_bar.value - start_filling_progress) / 100.0 * x1_suger_max)
			add_label.text = "Suger +" + str(add) + "g"
			suger_cur = int(total)
			suger_target_label.text = suger_target_text % suger_cur
			#if suger_cur > x1_suger_best:
				#suger_target_label.text = suger_target_text % [str("[color=red]" + str(suger_cur) + "[/color]"), x1_suger_best]

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
	cur_filling = Filling.Egg
	start_filling()

func _on_egg_button_up() -> void:
	stop_filling()

func _on_butter_button_down() -> void:
	cur_filling = Filling.Butter
	start_filling()

func _on_butter_button_up() -> void:
	stop_filling()

func _on_flour_button_down() -> void:
	cur_filling = Filling.Flour
	start_filling()

func _on_flour_button_up() -> void:
	stop_filling()

func _on_suger_button_down() -> void:
	cur_filling = Filling.Suger
	start_filling()

func _on_suger_button_up() -> void:
	stop_filling()

func _on_bake_button_pressed() -> void:
	if baker_state != BakerState.None:
		show_notice("Please wait. Baker is working")
		return
	if egg_cur == 0 and butter_cur == 0 and flour_cur == 0 and suger_cur == 0:
		show_notice("nothing to bake")
		return
	
	baker_number = cook_number
	baking_best_rate = best_rate
	baker_best_rate_label.text = "Best: " + str(int(baking_best_rate * 100)) + "%"
	baker_best_rate_label.show()
	baker_start_working_time = int(Time.get_unix_time_from_system())
	baker_state = BakerState.Working
	baker.play("baking")
	egg_cur = 0
	butter_cur = 0
	flour_cur = 0
	suger_cur = 0
	best_rate = 1
	cook_number = 0
	flour_texture_progress_bar.value = 0
	butter_texture_progress_bar.value = 0
	egg_texture_progress_bar.value = 0
	suger_texture_progress_bar.value = 0

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


func _on_coconut_pressed() -> void:
	var target_idx = find_first_normal_biscuit_on_extra_shelves()
	if target_idx == -1:
		show_notice("need normal biscuit")
		return
		
	var b = extra_shelves[target_idx] as Biscuit
	if b:
		b.set_taste(Biscuit.Taste.Coconut)

func _on_blue_berry_pressed() -> void:
	var target_idx = find_first_normal_biscuit_on_extra_shelves()
	if target_idx == -1:
		show_notice("need normal biscuit")
		return
				
	var b = extra_shelves[target_idx] as Biscuit
	if b:
		b.set_taste(Biscuit.Taste.Blueberry)

func _on_chocolate_pressed() -> void:
	var target_idx = find_first_normal_biscuit_on_extra_shelves()
	if target_idx == -1:
		show_notice("need normal biscuit")
		return
		
	var b = extra_shelves[target_idx] as Biscuit
	if b:
		b.set_taste(Biscuit.Taste.Chocolate)
		
func find_first_normal_biscuit_on_extra_shelves() -> int:
	for idx in extra_shelves.size():
		var b = extra_shelves[idx]
		if b and b.taste == Biscuit.Taste.Normal:
			return idx
	return -1

func _on_shelve_button_pressed() -> void:
	for idx in extra_shelves.size():
		var b = extra_shelves[idx]
		if b:
			var empty_idx = find_first_shelves_empty()
			if empty_idx != -1:
				b.shelve_idx = empty_idx
				b.shelve_marker_pos = shelves_maker.global_position
				b.shelve_marker_pos2 = shelves_maker_2.global_position
				b.shelve_marker_pos3 = shelves_maker_3.global_position
				b.move_to_shelves()
				shelves[empty_idx] = b
				extra_shelves[idx] = null
	
	
