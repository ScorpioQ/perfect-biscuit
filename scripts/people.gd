extends Control

@onready var start_2: Control = $"../../Road/Start2"
@onready var start_3: Control = $"../../Road/Start3"
@onready var start_4: Control = $"../../Road/Start4"
@onready var buy: Control = $"../../Road/Buy"

var target_pos: Vector2
var start_pos: Vector2


enum PeopleState {
	Idle,
	Move,
	Buying,
}

var speed = 4
var state: PeopleState = PeopleState.Idle

func _ready() -> void:
	speed = randf_range(3, 5)

func set_target_pos(p: Vector2):
	start_pos = global_position
	target_pos = p

func _process(delta: float) -> void:
	self.global_position = start_pos.lerp(target_pos, delta * speed)
# 人的运动，买卖
