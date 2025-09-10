extends Control

@onready var help: Control = $"."
@onready var help_sfx: AudioStreamPlayer2D = $"../HelpButton/HelpSFX"

func _on_help_button_pressed() -> void:
	help_sfx.play()
	if help.visible:
		help.hide()
	else:
		help.show()
