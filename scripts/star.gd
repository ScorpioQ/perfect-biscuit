extends Label

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animated_sprite_2d_3: AnimatedSprite2D = $AnimatedSprite2D3
@onready var animated_sprite_2d_4: AnimatedSprite2D = $AnimatedSprite2D4
@onready var animated_sprite_2d_5: AnimatedSprite2D = $AnimatedSprite2D5

func set_point(f: float):
	self.text = str(f)
	if 0 <= f and f < 0.5:
		animated_sprite_2d.play("none")
		animated_sprite_2d_2.play("none")
		animated_sprite_2d_3.play("none")
		animated_sprite_2d_4.play("none")
		animated_sprite_2d_5.play("none")
	elif 0.5 <= f and f < 1.0:
		animated_sprite_2d.play("half")
		animated_sprite_2d_2.play("none")
		animated_sprite_2d_3.play("none")
		animated_sprite_2d_4.play("none")
		animated_sprite_2d_5.play("none")
	elif 1.0 <= f and f < 1.5:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("none")
		animated_sprite_2d_3.play("none")
		animated_sprite_2d_4.play("none")
		animated_sprite_2d_5.play("none")
	elif 1.5 <= f and f < 2.0:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("half")
		animated_sprite_2d_3.play("none")
		animated_sprite_2d_4.play("none")
		animated_sprite_2d_5.play("none")
	elif 2.0 <= f and f < 2.5:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("full")
		animated_sprite_2d_3.play("none")
		animated_sprite_2d_4.play("none")
		animated_sprite_2d_5.play("none")
	elif 2.5 <= f and f < 3.0:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("full")
		animated_sprite_2d_3.play("half")
		animated_sprite_2d_4.play("none")
		animated_sprite_2d_5.play("none")
	elif 3.0 <= f and f < 3.5:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("full")
		animated_sprite_2d_3.play("full")
		animated_sprite_2d_4.play("none")
		animated_sprite_2d_5.play("none")
	elif 3.5 <= f and f < 4.0:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("full")
		animated_sprite_2d_3.play("full")
		animated_sprite_2d_4.play("half")
		animated_sprite_2d_5.play("none")
	elif 4.0 <= f and f < 4.5:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("full")
		animated_sprite_2d_3.play("full")
		animated_sprite_2d_4.play("full")
		animated_sprite_2d_5.play("none")
	elif 4.5 <= f and f < 5.0:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("full")
		animated_sprite_2d_3.play("full")
		animated_sprite_2d_4.play("full")
		animated_sprite_2d_5.play("half")
	else:
		animated_sprite_2d.play("full")
		animated_sprite_2d_2.play("full")
		animated_sprite_2d_3.play("full")
		animated_sprite_2d_4.play("full")
		animated_sprite_2d_5.play("full")
