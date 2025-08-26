extends Node2D

# filling_box
@onready var filling_box: Control = $CanvasLayer/FillingBox
@onready var filling_result_label: Label = $CanvasLayer/FillingBox/FillingResultLabel
@onready var green_center: ColorRect = $CanvasLayer/FillingBox/GreenCenter
@onready var cursor: TextureRect = $CanvasLayer/FillingBox/Cursor
@onready var start_pos: Control = $CanvasLayer/FillingBox/StartPos
@onready var min_label: Label = $CanvasLayer/FillingBox/MinLabel
@onready var max_label: Label = $CanvasLayer/FillingBox/MaxLabel

# Choose Area
@onready var egg: Button = $CanvasLayer/ChooseButton/HBoxContainer/Egg
@onready var butter: Button = $CanvasLayer/ChooseButton/HBoxContainer/Butter
@onready var dough: Button = $CanvasLayer/ChooseButton/HBoxContainer/Dough
@onready var suger: Button = $CanvasLayer/ChooseButton/HBoxContainer/Suger
@onready var choose_box: TextureRect = $CanvasLayer/ChooseButton/ChooseBox

@onready var egg_target_label: RichTextLabel = $CanvasLayer/FillingArea/GridContainer/EggTargetLabel
@onready var butter_target_label: RichTextLabel = $CanvasLayer/FillingArea/GridContainer/ButterTargetLabel
@onready var dough_target_label: RichTextLabel = $CanvasLayer/FillingArea/GridContainer/DoughTargetLabel
@onready var suger_target_label: RichTextLabel = $CanvasLayer/FillingArea/GridContainer/SugerTargetLabel

# mouse
@onready var fill_target: Sprite2D = $CanvasLayer/FillTarget

# debug
@onready var debug_cook_state_label: Label = $CanvasLayer/DebugCookStateLabel

enum CookState {
	None,
	ReadyFill,
	Filling
}

var filling_speed: float = 200.0

var cook_state: CookState = CookState.None

const egg_target_text = "Egg: %s / %s"
const butter_target_text = "Butter: %sg / %sg"
const dough_target_text = "Dough: %sg / %sg"
const suger_target_text = "Suger: %sg / %sg"

const butter_min: int = 5
const butter_max: int = 15
const dough_min: int = 0
const dough_max: int = 600
const suger_min: int = 0
const suger_max: int = 30

var egg_cur: float
var butter_cur: float
var dough_cur: float
var suger_cur: float

enum Filling {
	Egg,
	Butter,
	Dough,
	Suger,
}

var cur_filling: Filling

func _ready() -> void:
	egg_target_label.text = egg_target_text % [egg_cur, 2]
	butter_target_label.text = butter_target_text % [butter_cur, butter_max]
	dough_target_label.text = dough_target_text % [dough_cur, dough_max]
	suger_target_label.text = suger_target_text % [suger_cur, suger_max]

func _process(delta: float) -> void:
	match cook_state:
		CookState.ReadyFill:
			fill_target.position = get_global_mouse_position()
		CookState.Filling:
			filling(delta)
		_:
			pass

func set_cook_state(s: CookState):
	cook_state = s
	match cook_state:
		CookState.ReadyFill:
			debug_cook_state_label.text = "ReadyFill"
		CookState.Filling:
			debug_cook_state_label.text = "Filling"
		_:
			debug_cook_state_label.text = "None"

func _input(event: InputEvent) -> void:
	pass
	#if cook_state == CookState.ReadyFill:
		#if Input.is_action_just_pressed("filling"):
			#start_filling()
		#if Input.is_action_just_released("filling"):
			#stop_filling()

func start_filling():
	cursor.position = start_pos.position
	filling_box.show()
	match cur_filling:
		Filling.Egg:
			pass
		Filling.Butter:
			pass
		Filling.Dough:
			pass
		Filling.Suger:
			pass
	set_cook_state(CookState.Filling)

func filling(delta: float) -> void:
	if cursor.position.x <= filling_box.size.x:
		cursor.position.x += delta * filling_speed
		print("cusor pos: %s", cursor.position)

func stop_filling():
	var res = cal_result()
	set_cook_state(CookState.ReadyFill)
	match cur_filling:
		Filling.Egg:
			egg_cur += res
			egg_target_label.text = egg_target_text % [egg_cur, 2]
			if egg_cur > 2:
				egg_target_label.text = egg_target_text % [str("[color=red]" + str(egg_cur) + "[/color]"), 2]
		Filling.Butter:
			butter_cur += res
			butter_target_label.text = butter_target_text % [butter_cur, butter_max]
			if butter_cur > butter_max:
				butter_target_label.text = butter_target_text % [str("[color=red]" + str(butter_cur) + "[/color]"), butter_max]
		Filling.Dough:
			dough_cur += res
			dough_target_label.text = dough_target_text % [dough_cur, dough_max]
			if dough_cur > dough_max:
				dough_target_label.text = dough_target_text % [str("[color=red]" + str(dough_cur) + "[/color]"), dough_max]
		Filling.Suger:
			suger_cur += res
			suger_target_label.text = suger_target_text % [suger_cur, suger_max]
			if suger_cur > suger_max:
				suger_target_label.text = suger_target_text % [str("[color=red]" + str(suger_cur) + "[/color]"), suger_max]
	
func cal_result() -> float:
	filling_result_label.show()
	filling_result_label.position.y = cursor.position.y - filling_box.size.y
	filling_result_label.scale = Vector2(2, 2)
	
	var diff = cursor.position.x - start_pos.position.x
	var add: float
	match cur_filling:
		Filling.Egg:
			add = 1
		Filling.Butter:
			add = butter_min + (butter_max - butter_min) * diff / filling_box.size.x
		Filling.Dough:
			add = dough_min + (dough_max - dough_min) * diff / filling_box.size.x
		Filling.Suger:
			add = suger_min + (suger_max - suger_min) * diff / filling_box.size.x
			
	add = round(add)
	filling_result_label.text = "+%s" % add
	#if green_center.position.x < cursor.position.x and cursor.position.x < green_center.position.x + green_center.size.x:
		#filling_result_label.text = "+100%"
	#else:
		#filling_result_label.text = "+0%"
		
	var tween = get_tree().create_tween()
	tween.tween_property(filling_result_label, "position", filling_result_label.position + Vector2.UP * 100, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(filling_result_label.hide)
	tween.tween_callback(filling_box.hide)
	return add

func _on_egg_pressed() -> void:
	pass

func _on_butter_pressed() -> void:
	pass

func _on_dough_pressed() -> void:
	pass

func _on_suger_pressed() -> void:
	pass

func _on_egg_button_down() -> void:
	choose_box_focus(egg)
	fill_target_change(egg)
	cur_filling = Filling.Egg
	min_label.text = "0"
	max_label.text = "1"

func _on_butter_button_down() -> void:
	choose_box_focus(butter)
	fill_target_change(butter)
	cur_filling = Filling.Butter
	min_label.text = str(butter_min) + "g"
	max_label.text = str(butter_max) + "g"

func _on_dough_button_down() -> void:
	choose_box_focus(dough)
	fill_target_change(dough)
	cur_filling = Filling.Dough
	min_label.text = str(dough_min) + "g"
	max_label.text = str(dough_max) + "g"

func _on_suger_button_down() -> void:
	choose_box_focus(suger)
	fill_target_change(suger)
	cur_filling = Filling.Suger
	min_label.text = str(suger_min) + "g"
	max_label.text = str(suger_max) + "g"

func choose_box_focus(target: Button):
	choose_box.global_position = target.global_position
	choose_box.global_position.x -= 2
	choose_box.global_position.y -= 2
	choose_box.show()
	
	if cook_state != CookState.ReadyFill:
		cook_state = CookState.ReadyFill

func fill_target_change(target: Button):
	fill_target.texture = ImageTexture.create_from_image(target.icon.get_image())
	fill_target.show()
	set_cook_state(CookState.ReadyFill)

func _on_filling_rect_button_down() -> void:
	if cook_state != CookState.ReadyFill:
		return
	start_filling()
	
func _on_filling_rect_button_up() -> void:
	if cook_state != CookState.Filling:
		return
	stop_filling()

func _on_bake_button_pressed() -> void:
	pass # Replace with function body.
