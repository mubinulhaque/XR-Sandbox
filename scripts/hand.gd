class_name HandController
extends XRController3D

@export var use_direct_movement := false ## Whether this hand controls turning and forwards motion, or teleportation
@export var options_viewport: Viewport2Din3D

@onready var _function_teleport: XRToolsFunctionTeleport = $FunctionTeleport
@onready var _movement_direct: XRToolsMovementDirect = $MovementDirect
@onready var _movement_turn: XRToolsMovementTurn = $MovementTurn


func _ready() -> void:
	toggle_locomotion(use_direct_movement)


func _on_button_pressed(button_name: String) -> void:
	match button_name:
		"menu_button":
			if options_viewport:
				options_viewport.visible = !options_viewport.visible
				options_viewport.enabled = !options_viewport.enabled


func toggle_locomotion(direct_movement: bool) -> void:
	# Toggle the locomotion options
	_function_teleport.enabled = not direct_movement
	_movement_direct.enabled = direct_movement
	_movement_turn.enabled = direct_movement
	
	# Toggle the teleport node's visibility
	_function_teleport.visible = not direct_movement
