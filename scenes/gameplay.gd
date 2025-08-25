extends Node2D

@onready var filling_box: Control = $CanvasLayer/FillingBox
@onready var filling_result_label: Label = $CanvasLayer/FillingBox/FillingResultLabel
@onready var green_center: ColorRect = $CanvasLayer/FillingBox/GreenCenter
@onready var cursor: TextureRect = $CanvasLayer/FillingBox/Cursor
@onready var start_pos: Control = $CanvasLayer/FillingBox/StartPos

enum CookState {
	None,
	Filling
}

var filling_speed: float = 200.0

var cook_state: CookState

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if cook_state == CookState.Filling:
		filling(delta)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("filling"):
		start_filling()
	
	if Input.is_action_just_released("filling"):
		stop_filling()

func start_filling():
	cursor.position = start_pos.position
	cursor.show()
	cook_state = CookState.Filling

func filling(delta: float) -> void:
	if cursor.position.x <= filling_box.size.x:
			cursor.position.x += delta * filling_speed

func stop_filling():
	show_result()
	cook_state = CookState.None
	cursor.hide()
	cursor.position = start_pos.position
	
func show_result():
	filling_result_label.show()
	filling_result_label.position = cursor.position - Vector2(0, filling_box.size.y)
	filling_result_label.scale = Vector2(2, 2)
	if green_center.position.x < cursor.position.x and cursor.position.x < green_center.position.x + green_center.size.x:
		filling_result_label.text = "+100%"
	else:
		filling_result_label.text = "+0%"
		
	var tween = get_tree().create_tween()
	tween.tween_property(filling_result_label, "position", filling_result_label.position + Vector2.UP * 100, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(filling_result_label.hide)
	
