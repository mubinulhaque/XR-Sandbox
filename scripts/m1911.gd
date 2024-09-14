extends XRToolsPickable

var _magazine: Node3D
var _controller: XRController3D ## Controller that is holding the gun

@onready var _animator: AnimationPlayer = $AnimationPlayer
@onready var _mag_snap_zone: XRToolsSnapZone = $Model/MagSnapZone


func _on_magazine_ejected() -> void:
	print("Ejected magazine!")
	_mag_snap_zone.drop_object()
	_magazine = null


func _on_magazine_loaded() -> void:
	print("Loaded magazine!")


func _on_MagSnapZone_has_picked_up(what: Variant) -> void:
	_animator.play("load_magazine")
	_magazine = what


func _on_picked_up(pickable: Variant) -> void:
	print("Picked up!")
	_controller = get_picked_up_by_controller()
	_controller.button_pressed.connect(_eject_magazine)


func _eject_magazine(button_name: String) -> void:
	if button_name == "by_button" and _magazine:
		_animator.play("eject_magazine")
		_controller.button_pressed.disconnect(_eject_magazine)
		_controller = null
