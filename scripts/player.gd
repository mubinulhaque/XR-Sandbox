extends XROrigin3D

@onready var _recenter_timer: Timer = $RecenterTimer


func _ready() -> void:
	# Allow HMD centering by starting a short timer
	var interface: OpenXRInterface = XRServer.find_interface("OpenXR")
	if interface:
		interface.pose_recentered.connect(_pose_recentered)
	else:
		printerr("OpenXR Interface not found! Please select one of the following:")
		for registered in XRServer.get_interfaces():
			printerr(registered)


## Recenters the HMD
func _pose_recentered() -> void:
	_recenter_timer.start()


## Centers the HMD but keeps the tilt (not the rotation) of the device
func _center_hmd() -> void:
	XRServer.center_on_hmd(XRServer.RESET_BUT_KEEP_TILT, true)
