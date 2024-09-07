extends XRController3D

@onready var _options_viewport: Viewport2Din3D = $OptionsViewport


func _on_button_pressed(name: String) -> void:
	if name == "menu_button":
		_options_viewport.visible = !_options_viewport.visible
		_options_viewport.enabled = !_options_viewport.enabled
