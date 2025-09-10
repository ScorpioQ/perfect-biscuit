extends CanvasLayer

# Notice
@onready var notice_panel_container: PanelContainer = $Notice
@onready var notice_label: Label = $Notice/NoticeLabel

# FirstStep
@onready var egg_btn: TextureButton = $FirstStep/HBoxContainer/Egg
@onready var butter_btn: TextureButton = $FirstStep/HBoxContainer/Butter
@onready var flour_btn: TextureButton = $FirstStep/HBoxContainer/Flour
@onready var suger_btn: TextureButton = $FirstStep/HBoxContainer/Suger
@onready var btn_sfx: AudioStreamPlayer2D = $FirstStep/BtnSFX

@onready var egg_ori_label: Label = $FirstStep/HBoxContainer/Egg/EggOriLabel
@onready var butter_ori_label: Label = $FirstStep/HBoxContainer/Butter/ButterOriLabel
@onready var suger_ori_label: Label = $FirstStep/HBoxContainer/Suger/SugerOriLabel
@onready var flour_ori_label: Label = $FirstStep/HBoxContainer/Flour/FlourOriLabel

# Progress Bar
@onready var flour_texture_progress_bar: TextureProgressBar = $FillingProgress/VBoxContainer/HBoxContainer/FlourTextureProgressBar

@onready var suger_progress: HBoxContainer = $FillingProgress/VBoxContainer/HBoxContainer2
@onready var suger_texture_progress_bar: TextureProgressBar = $FillingProgress/VBoxContainer/HBoxContainer2/SugerTextureProgressBar
@onready var suger_max: Label = $FillingProgress/VBoxContainer/HBoxContainer2/SugerMax
@onready var suger_min: Label = $FillingProgress/VBoxContainer/HBoxContainer2/SugerMin
@onready var suger_perfect: TextureRect = $FillingProgress/VBoxContainer/HBoxContainer2/SugerTextureProgressBar/SugerPerfect
@onready var suger_perfect_label: Label = $FillingProgress/VBoxContainer/HBoxContainer2/SugerTextureProgressBar/SugerPerfectLabel
@onready var suger_good_label: Label = $FillingProgress/VBoxContainer/HBoxContainer2/SugerTextureProgressBar/SugerGoodLabel

@onready var butter_progress: HBoxContainer = $FillingProgress/VBoxContainer/HBoxContainer3
@onready var butter_texture_progress_bar: TextureProgressBar = $FillingProgress/VBoxContainer/HBoxContainer3/ButterTextureProgressBar
@onready var butter_max: Label = $FillingProgress/VBoxContainer/HBoxContainer3/ButterMax
@onready var butter_min: Label = $FillingProgress/VBoxContainer/HBoxContainer3/ButterMin
@onready var butter_perfect: TextureRect = $FillingProgress/VBoxContainer/HBoxContainer3/ButterTextureProgressBar/ButterPerfect
@onready var butter_perfect_label: Label = $FillingProgress/VBoxContainer/HBoxContainer3/ButterTextureProgressBar/ButterPerfectLabel
@onready var butter_good_label: Label = $FillingProgress/VBoxContainer/HBoxContainer3/ButterTextureProgressBar/ButterGoodLabel

@onready var egg_progress: HBoxContainer = $FillingProgress/VBoxContainer/HBoxContainer4
@onready var egg_texture_progress_bar: TextureProgressBar = $FillingProgress/VBoxContainer/HBoxContainer4/EggTextureProgressBar
@onready var egg_max: Label = $FillingProgress/VBoxContainer/HBoxContainer4/EggMax
@onready var egg_min: Label = $FillingProgress/VBoxContainer/HBoxContainer4/EggMin
@onready var egg_perfect: TextureRect = $FillingProgress/VBoxContainer/HBoxContainer4/EggTextureProgressBar/EggPerfect
@onready var egg_good_label: Label = $FillingProgress/VBoxContainer/HBoxContainer4/EggTextureProgressBar/EggGoodLabel
@onready var egg_perfect_label: Label = $FillingProgress/VBoxContainer/HBoxContainer4/EggTextureProgressBar/EggPerfectLabel

@onready var perfect_sfx: AudioStreamPlayer2D = $FillingProgress/PerfectSFX
@onready var good_sfx: AudioStreamPlayer2D = $FillingProgress/GoodSFX

@onready var biscuit_number_label: Label = $PredictNumber/BiscuitNumberLabel
@onready var best_rate_label: Label = $BestRateLabel

# Trash
@onready var trash_button: TextureButton = $TrashButton
@onready var trash_btn_sfx: AudioStreamPlayer2D = $TrashButton/AudioStreamPlayer2D

# Baker
@onready var baker: AnimatedSprite2D = $Baker
@onready var baker_best_rate_label: Label = $Baker/BakerBestRateLabel
@onready var baker_progress_bar: TextureProgressBar = $Baker/TextureProgressBar
@onready var bake_sfx: AudioStreamPlayer2D = $Baker/BakeSFX
@onready var clock_sfx: AudioStreamPlayer2D = $Baker/ClockSFX
@onready var bake_btn_sfx: AudioStreamPlayer2D = $BakeButton/AudioStreamPlayer2D

# Shelves
@onready var shelve_btn_sfx: AudioStreamPlayer2D = $ShelveButton/AudioStreamPlayer2D

@onready var shelves_maker: Control = $Shelves/ShelvesMaker
@onready var shelves_maker_2: Control = $Shelves/ShelvesMaker2
@onready var shelves_maker_3: Control = $Shelves/ShelvesMaker3
@onready var shelves_maker_4: Control = $Shelves/ShelvesMaker4

@onready var extra_shelves_maker: Control = $ExtraShelves/ExtraShelvesMaker
@onready var extra_shelves_maker_2: Control = $ExtraShelves/ExtraShelvesMaker2
@onready var extra_shelves_maker_3: Control = $ExtraShelves/ExtraShelvesMaker3

# Extra
@onready var extra_btn_sfx: AudioStreamPlayer2D = $ExtraButton/HBoxContainer/ExtraBtnSFX
@onready var pineapple_btn: TextureButton = $ExtraButton/HBoxContainer/Pineapple
@onready var pineapple_times: Label = $ExtraButton/HBoxContainer/Pineapple/PineappleTimes
@onready var grape_btn: TextureButton = $ExtraButton/HBoxContainer/Grape
@onready var grape_times: Label = $ExtraButton/HBoxContainer/Grape/GrapeTimes
@onready var strawberry_btn: TextureButton = $ExtraButton/HBoxContainer/Strawberry
@onready var strawberry_times: Label = $ExtraButton/HBoxContainer/Strawberry/StrawberryTimes

# People
@onready var people: Control = $People

# Prefab
@export var biscuit_tscn: PackedScene
@export var money_tscn: PackedScene

# Shop
@onready var shop_sfx: AudioStreamPlayer2D = $ShopButton/ShopSFX
@onready var shop_btn_sfx: AudioStreamPlayer2D = $Shop/ShopBtnSFX
@onready var shop: Control = $Shop

@onready var shop_butter_btn: TextureButton = $Shop/ShopButter
@onready var shop_suger_btn: TextureButton = $Shop/ShopSuger
@onready var shop_egg_btn: TextureButton = $Shop/ShopEgg
@onready var shop_strawberry: TextureButton = $Shop/ShopStrawberry
@onready var shop_grape: TextureButton = $Shop/ShopGrape
@onready var shop_pineapple: TextureButton = $Shop/ShopPineapple

# Upgrade
@onready var up_button: TextureButton = $UpButton
@onready var up_sfx: AudioStreamPlayer2D = $UpButton/UpSFX
@onready var up: Control = $Up
@onready var up_btn_sfx: AudioStreamPlayer2D = $Up/UpBtnSFX
@onready var up_butter: TextureButton = $Up/HBoxContainer/UpButter
@onready var up_suger: TextureButton = $Up/HBoxContainer/UpSuger
@onready var up_egg: TextureButton = $Up/HBoxContainer/UpEgg

@onready var up_strawberry: TextureButton = $Up/HBoxContainer2/UpStrawberry
@onready var up_grape: TextureButton = $Up/HBoxContainer2/UpGrape
@onready var up_pineapple: TextureButton = $Up/HBoxContainer2/UpPineapple

# Biscuit
@onready var biscuit_layer: Control = $Biscuit

# UI
@onready var money_label: Label = $MoneyLabel
@onready var game_over: Control = $GameOver

# Enum
enum FillingState {
	None,
	ReadyFill,
	Filling
}

enum BakerState {
	None,
	Working,
	Trans,
}

enum Filling {
	None,
	Egg,
	Butter,
	Flour,
	Suger,
}

# Variables
var suger_unlock: bool = false
var butter_unlock: bool = false
var egg_unlock: bool = false

var strawberry_unlock: bool = false
var grape_unlock: bool = false
var pineapple_unlock: bool = false

var flour_ori: int = 240
var suger_ori: int = 0
var butter_ori: int = 0
var egg_ori: int = 0
var strawberry_ori: int = 0
var grape_ori: int = 0
var pineapple_ori: int = 0

var filling_state: FillingState = FillingState.None
var baker_state: BakerState = BakerState.None
const baker_working_time = 1
var baker_start_working_time = 0
var baker_number: int = 0
var bake_white: bool = true

var extra_shelves: Array = []
var shelves: Array = []

var baking_best_rate: float

var best_rate: float

var egg_cur: int
var butter_cur: int
var flour_cur: int
var suger_cur: int
var cur_filling: Filling

var start_filling_progress: float

var cook_number: int = 0

var money: int = 0

var perfect_suger: int
var perfect_butter: int
var perfect_egg: int

var baker_wait_num: int

# Config
const egg_filling_speed: float = 200.0
const butter_filling_speed: float = 200.0
const suger_filling_speed: float = 200.0
const flour_filling_speed: float = 100.0

const x1_egg_min: int = 0
const x1_egg_best: int = 8
const x1_egg_max: int = 100

const x1_butter_min: int = 0
const x1_butter_best: int = 5
const x1_butter_max: int = 90

const x1_suger_min: int = 0
const x1_suger_best: int = 3
const x1_suger_max: int = 60

const x1_flour_min: int = 0
const x1_flour_max: int = 120

const shelves_len: int = 40
const extra_shelves_len: int = 30
const shelves_col_len: int = 10

# Functions
func _ready() -> void:
	reset_progress_min_max()
	for i in shelves_len:
		shelves.append(null)
	for i in extra_shelves_len:
		extra_shelves.append(null)
	
	flour_texture_progress_bar.value = 0
	butter_texture_progress_bar.value = 0
	egg_texture_progress_bar.value = 0
	suger_texture_progress_bar.value = 0
	people.show()
	update_ori()

func _process(delta: float) -> void:
	if money < 10 and flour_ori < 10 and is_shelve_emtpy() and is_extra_shelves_empty() and baker_state == BakerState.None:
		game_over.show()
		return

	match filling_state:
		FillingState.Filling:
			filling(delta)
		_:
			pass
	
	match baker_state:
		BakerState.Working:
			baker_progress_bar.value = float(Time.get_unix_time_from_system() - baker_start_working_time) / float(baker_working_time * baker_number) * 100
			if int(Time.get_unix_time_from_system()) - baker_start_working_time >= baker_working_time * baker_number:
				baker_state = BakerState.Trans
				baker.play("full")
				baker_wait_num = baker_number
				bake_sfx.stop()
				clock_sfx.stop()
				
		BakerState.Trans:
			baker_progress_bar.hide()
			if baker_wait_num > 0:
				var empty_idx = find_first_extra_shelves_empty()
				if empty_idx != -1:
					baker_wait_num -= 1
					var b = create_biscuit() as Biscuit
					b.extra_shelve_idx = empty_idx
					b.set_quality(randf_range(baking_best_rate - 0.05, baking_best_rate + 0.05))
					if bake_white:
						b.set_taste(Biscuit.Taste.White)
					else:
						b.set_taste(Biscuit.Taste.Normal)
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

func update_ori():
	egg_ori_label.text = str(egg_ori - egg_cur) + "g"
	butter_ori_label.text = str(butter_ori - butter_cur) + "g"
	suger_ori_label.text = str(suger_ori - suger_cur) + "g"
	flour_ori_label.text = str(flour_ori - flour_cur) + "g"

func find_first_shelves_empty() -> int:
	for i in shelves_len:
		if shelves[i] == null:
			return i
	
	return -1

func is_shelves_empty() -> bool:
	for i in shelves_len:
		if shelves[i] != null:
			return false
	
	return true

func find_first_extra_shelves_empty() -> int:
	for i in extra_shelves_len:
		if extra_shelves[i] == null:
			return i
	
	return -1

func is_extra_shelves_empty() -> bool:
	for i in extra_shelves_len:
		if extra_shelves[i] != null:
			return false
	
	return true

func is_shelve_emtpy() -> bool:
	for i in shelves_len:
		if shelves[i] != null:
			return false
	
	return true
	
func reset_progress_min_max():
	egg_min.text = str(x1_egg_min) + "g"
	egg_max.text = str(x1_egg_max) + "g"

	butter_min.text = str(x1_butter_min) + "g"
	butter_max.text = str(x1_butter_max) + "g"

	suger_min.text = str(x1_suger_min) + "g"
	suger_max.text = str(x1_suger_max) + "g"

func set_filling_state(s: FillingState):
	filling_state = s

func start_filling():
	btn_sfx.play()
	match cur_filling:
		Filling.Flour:
			if flour_ori <= 0:
				show_notice("not enouph")
				return
			start_filling_progress = flour_texture_progress_bar.value
		Filling.Egg:
			if egg_ori <= 0:
				show_notice("not enouph")
				return
			start_filling_progress = egg_texture_progress_bar.value
		Filling.Butter:
			if butter_ori <= 0:
				show_notice("not enouph")
				return
			start_filling_progress = butter_texture_progress_bar.value
		Filling.Suger:
			if suger_ori <= 0:
				show_notice("not enouph")
				return
			start_filling_progress = suger_texture_progress_bar.value
	set_filling_state(FillingState.Filling)

func filling(delta: float) -> void:
	match cur_filling:
		Filling.Flour:
			if flour_texture_progress_bar.value + delta * flour_filling_speed >= float(flour_ori) / float(x1_flour_max) * 100.0:
				flour_texture_progress_bar.value = float(flour_ori) / float(x1_flour_max) * 100.0
				show_notice("not enouph")
			else:
				flour_texture_progress_bar.value += delta * flour_filling_speed
		Filling.Egg:
			if egg_texture_progress_bar.value + delta * egg_filling_speed >= float(egg_ori) / float(x1_egg_max) * 100.0:
				egg_texture_progress_bar.value = float(egg_ori) / float(x1_egg_max) * 100.0
				show_notice("not enouph")
			else:
				egg_texture_progress_bar.value += delta * egg_filling_speed
		Filling.Butter:
			if butter_texture_progress_bar.value + delta * butter_filling_speed >= float(butter_ori) / float(x1_butter_max) * 100.0:
				butter_texture_progress_bar.value = float(butter_ori) / float(x1_butter_max) * 100.0
				show_notice("not enouph")
			else:
				butter_texture_progress_bar.value += delta * butter_filling_speed
		Filling.Suger:
			if suger_texture_progress_bar.value + delta * suger_filling_speed >= float(suger_ori) / float(x1_suger_max) * 100.0:
				suger_texture_progress_bar.value = float(suger_ori) / float(x1_suger_max) * 100.0
				show_notice("not enouph")
			else:
				suger_texture_progress_bar.value += delta * suger_filling_speed

func stop_filling():
	set_filling_state(FillingState.ReadyFill)
	
	var total: int
	match cur_filling:
		Filling.Flour:
			total = int(flour_texture_progress_bar.value / 100.0 * x1_flour_max)
			flour_cur = int(total)
			cook_number = flour_cur / 10

			biscuit_number_label.text = "x" + str(cook_number)
			set_perfect_pos_x(cook_number)

		Filling.Egg:
			total = int(egg_texture_progress_bar.value / 100.0 * x1_egg_max)
			egg_cur = int(total)
			if perfect_egg > 0 and abs(egg_cur - perfect_egg) <= 2:
				egg_perfect_label.show()
				egg_perfect_label.scale = Vector2.ONE * 0.5
				var tween = get_tree().create_tween()
				tween.tween_property(egg_perfect_label, "scale", Vector2.ONE * 2, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				tween.tween_callback(egg_perfect_label.hide)
				perfect_sfx.play()

			elif perfect_egg > 0 and abs(egg_cur - perfect_egg) <= 5:
				egg_good_label.show()
				egg_good_label.scale = Vector2.ONE * 0.5
				var tween = get_tree().create_tween()
				tween.tween_property(egg_good_label, "scale", Vector2.ONE * 2, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				tween.tween_callback(egg_good_label.hide)
				good_sfx.play()


		Filling.Butter:
			total = int(butter_texture_progress_bar.value / 100.0 * x1_butter_max)
			butter_cur = int(total)
			if perfect_butter > 0 and abs(butter_cur - perfect_butter) <= 2:
				butter_perfect_label.show()
				butter_perfect_label.scale = Vector2.ONE * 0.5
				var tween = get_tree().create_tween()
				tween.tween_property(butter_perfect_label, "scale", Vector2.ONE * 2, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				tween.tween_callback(butter_perfect_label.hide)
				perfect_sfx.play()

			elif perfect_butter > 0 and abs(butter_cur - perfect_butter) <= 5:
				butter_good_label.show()
				butter_good_label.scale = Vector2.ONE * 0.5
				var tween = get_tree().create_tween()
				tween.tween_property(butter_good_label, "scale", Vector2.ONE * 2, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				tween.tween_callback(butter_good_label.hide)
				good_sfx.play()

		Filling.Suger:
			total = int(suger_texture_progress_bar.value / 100.0 * x1_suger_max)
			suger_cur = int(total)
			if perfect_suger > 0 and abs(suger_cur - perfect_suger) <= 2:
				suger_perfect_label.show()
				suger_perfect_label.scale = Vector2.ONE * 0.5
				var tween = get_tree().create_tween()
				tween.tween_property(suger_perfect_label, "scale", Vector2.ONE * 2, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				tween.tween_callback(suger_perfect_label.hide)
				perfect_sfx.play()

			elif perfect_suger > 0 and abs(suger_cur - perfect_suger) <= 5:
				suger_good_label.show()
				suger_good_label.scale = Vector2.ONE * 0.5
				var tween = get_tree().create_tween()
				tween.tween_property(suger_good_label, "scale", Vector2.ONE * 2, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				tween.tween_callback(suger_good_label.hide)
				good_sfx.play()

	update_ori()
	best_rate = 0.5
	if egg_cur > 0:
		best_rate += 0.2
		best_rate -= clampf(abs(egg_cur - x1_egg_best * cook_number) * 0.01, 0, 0.2)
	if butter_cur > 0:
		best_rate += 0.2
		best_rate -= clampf(abs(butter_cur - x1_butter_best * cook_number) * 0.01, 0, 0.2)
	if suger_cur > 0:
		best_rate += 0.1
		best_rate -= clampf(abs(suger_cur - x1_suger_best * cook_number) * 0.01, 0, 0.2)
	best_rate = clamp(best_rate, 0, 1)
	best_rate_label.text = "Tasty: " + str(int(best_rate * 100)) + "%"

func set_perfect_pos_x(number: int):
	perfect_suger = number * 3
	perfect_butter = number * 5
	perfect_egg = number * 8

	suger_perfect.position.x = 108 - float(perfect_suger) / x1_suger_max * 108
	butter_perfect.position.x = 108 - float(perfect_butter) / x1_butter_max * 108
	egg_perfect.position.x = 108 - float(perfect_egg) / x1_egg_max * 108

	suger_perfect.show()
	butter_perfect.show()
	egg_perfect.show()

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
	bake_btn_sfx.play()
	if baker_state != BakerState.None:
		show_notice("Baker is working")
		return
	if flour_cur < 10:
		show_notice("flour not enouph")
		return
	
	if egg_ori > 0 or butter_ori > 0 or suger_ori > 0:
		bake_white = false

	flour_ori -= flour_cur
	egg_ori -= egg_cur
	butter_ori -= butter_cur
	suger_ori -= suger_cur

	baker_number = cook_number
	baking_best_rate = best_rate
	baker_best_rate_label.text = "Tasty: " + str(int(baking_best_rate * 100)) + "%"
	baker_best_rate_label.show()
	baker_start_working_time = int(Time.get_unix_time_from_system())
	baker_state = BakerState.Working
	bake_sfx.play()
	clock_sfx.play()
	baker.play("baking")
	baker_progress_bar.show()
	baker_progress_bar.value = 0
	egg_cur = 0
	butter_cur = 0
	flour_cur = 0
	suger_cur = 0
	best_rate = 0
	best_rate_label.text = "Tasty: " + str(int(best_rate * 100)) + "%"
	cook_number = 0
	flour_texture_progress_bar.value = 0
	butter_texture_progress_bar.value = 0
	egg_texture_progress_bar.value = 0
	suger_texture_progress_bar.value = 0
	biscuit_number_label.text = "x0"
	perfect_suger = 0
	perfect_butter = 0
	perfect_egg = 0
	suger_perfect.hide()
	butter_perfect.hide()
	egg_perfect.hide()

func show_notice(msg: String):
	notice_label.text = msg
	notice_panel_container.show()
	notice_panel_container.position = Vector2(327, 148)
	var tween = get_tree().create_tween()
	tween.tween_property(notice_panel_container, "position", notice_panel_container.position + Vector2.UP * 50, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(notice_panel_container.hide)

func create_biscuit() -> Control:
	var biscuit = biscuit_tscn.instantiate()
	biscuit.global_position = baker.global_position
	biscuit_layer.add_child(biscuit)
	return biscuit

func create_money():
	var money_sfx = money_tscn.instantiate()
	self.add_child(money_sfx)
	var tween = get_tree().create_tween()
	tween.tween_property(money_sfx, "scale", Vector2.ONE * 2, 1)
	tween.tween_callback(money_sfx.queue_free)

func add_money(add: int):
	money += add
	money_label.text = str(money)
	create_money()

func cost_money(cost: int):
	money -= cost
	money_label.text = str(money)

func _on_pineapple_pressed() -> void:
	if pineapple_ori <= 0:
		show_notice("buy more")
		return

	extra_btn_sfx.play()
	var target_idx = find_first_normal_biscuit_on_extra_shelves()
	if target_idx == -1:
		show_notice("Need normal biscuit")
		return

	pineapple_ori -= 1
	pineapple_times.text = str(pineapple_ori)
	var b = extra_shelves[target_idx] as Biscuit
	if b:
		b.set_taste(Biscuit.Taste.Pineapple)

func _on_grape_pressed() -> void:
	if grape_ori <= 0:
		show_notice("buy more")
		return

	extra_btn_sfx.play()
	var target_idx = find_first_normal_biscuit_on_extra_shelves()
	if target_idx == -1:
		show_notice("Need normal biscuit")
		return

	grape_ori -= 1
	grape_times.text = str(grape_ori)

	var b = extra_shelves[target_idx] as Biscuit
	if b:
		b.set_taste(Biscuit.Taste.Grape)

func _on_strawberry_pressed() -> void:
	if strawberry_ori <= 0:
		show_notice("buy more")
		return
	
	extra_btn_sfx.play()
	var target_idx = find_first_normal_biscuit_on_extra_shelves()
	if target_idx == -1:
		show_notice("Need normal biscuit")
		return
	
	strawberry_ori -= 1
	strawberry_times.text = str(strawberry_ori)
	var b = extra_shelves[target_idx] as Biscuit
	if b:
		b.set_taste(Biscuit.Taste.Strawberry)
		
func find_first_normal_biscuit_on_extra_shelves() -> int:
	for idx in extra_shelves.size():
		var b = extra_shelves[idx]
		if b and (b.taste == Biscuit.Taste.Normal or b.taste == Biscuit.Taste.White):
			return idx
	return -1

func _on_shelve_button_pressed() -> void:
	shelve_btn_sfx.play()
	for idx in extra_shelves.size():
		var b = extra_shelves[idx]
		if b:
			var empty_idx = find_first_shelves_empty()
			if empty_idx != -1:
				b.shelve_idx = empty_idx
				b.shelve_marker_pos = shelves_maker.global_position
				b.shelve_marker_pos2 = shelves_maker_2.global_position
				b.shelve_marker_pos3 = shelves_maker_3.global_position
				b.shelve_marker_pos4 = shelves_maker_4.global_position
				b.move_to_shelves()
				shelves[empty_idx] = b
				extra_shelves[idx] = null

func _on_trash_button_button_down() -> void:
	trash_btn_sfx.play()
	flour_ori -= flour_cur
	egg_ori -= egg_cur
	butter_ori -= butter_cur
	suger_ori -= suger_cur
	egg_cur = 0
	butter_cur = 0
	flour_cur = 0
	suger_cur = 0
	best_rate = 0
	best_rate_label.text = "Tasty: " + str(int(best_rate * 100)) + "%"
	cook_number = 0
	flour_texture_progress_bar.value = 0
	butter_texture_progress_bar.value = 0
	egg_texture_progress_bar.value = 0
	suger_texture_progress_bar.value = 0
	biscuit_number_label.text = "x0"
	perfect_suger = 0
	perfect_butter = 0
	perfect_egg = 0
	suger_perfect.hide()
	butter_perfect.hide()
	egg_perfect.hide()

func _on_shop_button_pressed() -> void:
	shop_sfx.play()
	if shop.visible:
		shop.hide()
	else:
		shop.show()

func _on_shop_flour_pressed() -> void:
	shop_btn_sfx.play()
	if money == 0:
		show_notice("money not enouph")
		return
		
	if money >= 100:
		cost_money(100)
		flour_ori += 100
	else:
		flour_ori += money
		money = 0
	update_ori()

func _on_shop_butter_pressed() -> void:
	shop_btn_sfx.play()
	if money == 0:
		show_notice("money not enouph")
		return
		
	if money >= 100:
		cost_money(100)
		butter_ori += 100
	else:
		butter_ori += money
		money = 0
	update_ori()

func _on_shop_suger_pressed() -> void:
	shop_btn_sfx.play()
	if money == 0:
		show_notice("money not enouph")
		return
		
	if money >= 100:
		cost_money(100)
		suger_ori += 100
	else:
		suger_ori += money
		money = 0
	update_ori()

func _on_shop_egg_pressed() -> void:
	shop_btn_sfx.play()
	if money == 0:
		show_notice("money not enouph")
		return
		
	if money >= 100:
		cost_money(100)
		egg_ori += 100
	else:
		egg_ori += money
		money = 0
	update_ori()

func _on_shop_strawberry_pressed() -> void:
	shop_btn_sfx.play()
	if money < 100:
		show_notice("money not enouph")
		return
	
	cost_money(100)
	strawberry_ori += 10
	strawberry_times.text = str(strawberry_ori)

func _on_shop_grape_pressed() -> void:
	shop_btn_sfx.play()
	if money < 150:
		show_notice("money not enouph")
		return
		
	cost_money(150)
	grape_ori += 10
	grape_times.text = str(grape_ori)

func _on_shop_pineapple_pressed() -> void:
	shop_btn_sfx.play()
	if money < 200:
		show_notice("money not enouph")
		return
		
	cost_money(200)
	pineapple_ori += 10
	pineapple_times.text = str(pineapple_ori)

func _on_close_pressed() -> void:
	shop_sfx.play()
	shop.hide()

func _on_up_button_pressed() -> void:
	up_sfx.play()
	if up.visible:
		up.hide()
	else:
		up.show()

func _on_up_close_pressed() -> void:
	up_btn_sfx.play()
	up.hide()

func _on_up_butter_pressed() -> void:
	up_btn_sfx.play()
	if money >= 500:
		cost_money(500)
	else:
		show_notice("money not enouph")
		return
	butter_unlock = true
	butter_btn.show()
	butter_progress.show()
	up_butter.hide()
	shop_butter_btn.show()

func _on_up_suger_pressed() -> void:
	up_btn_sfx.play()
	if money >= 600:
		cost_money(600)
	else:
		show_notice("money not enouph")
		return
	suger_unlock = true
	suger_btn.show()
	suger_progress.show()
	up_suger.hide()
	shop_suger_btn.show()

func _on_up_egg_pressed() -> void:
	up_btn_sfx.play()
	if money >= 700:
		cost_money(700)
	else:
		show_notice("money not enouph")
		return
	egg_unlock = true
	egg_btn.show()
	egg_progress.show()
	up_egg.hide()
	shop_egg_btn.show()

func _on_up_strawberry_pressed() -> void:
	up_btn_sfx.play()
	if money >= 500:
		cost_money(500)
	else:
		show_notice("money not enouph")
		return
	strawberry_unlock = true
	up_strawberry.hide()
	strawberry_btn.show()
	shop_strawberry.show()

func _on_up_grape_pressed() -> void:
	up_btn_sfx.play()
	if money >= 1000:
		cost_money(1000)
	else:
		show_notice("money not enouph")
		return
	grape_unlock = true
	up_grape.hide()
	grape_btn.show()
	shop_grape.show()

func _on_up_pineapple_pressed() -> void:
	up_btn_sfx.play()
	if money >= 2000:
		cost_money(2000)
	else:
		show_notice("money not enouph")
		return
	pineapple_unlock = true
	up_pineapple.hide()
	pineapple_btn.show()
	shop_pineapple.show()

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_close_button_pressed() -> void:
	get_tree().quit()
