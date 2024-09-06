extends Node3D

var xr_interface: XRInterface
var xr_capabilities: int


func _ready() -> void:
	xr_interface = XRServer.find_interface("OpenXR")
	
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync,
		# otherwise the game will be forced to the monitor's refresh rate
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		# Get the capabilites of the current headset
		xr_capabilities = xr_interface.get_capabilities()
		
		if bool(xr_capabilities & XRInterface.XR_NONE):
			printerr("XR is not supported on this machine!")
		elif bool(xr_capabilities & XRInterface.XR_MONO):
			print("This machine can do non-head-mounted-display-based AR!")
		elif bool(xr_capabilities & XRInterface.XR_STEREO):
			print("This machine supports stereoscopic rendering!")
		elif bool(xr_capabilities & XRInterface.XR_QUAD):
			print("This machine supports quad rendering!")
		elif bool(xr_capabilities & XRInterface.XR_VR):
			print("This machine supports VR!")
		elif bool(xr_capabilities & XRInterface.XR_AR):
			print("This machine supports video background and real world tracking!")
		elif bool(xr_capabilities & XRInterface.XR_EXTERNAL):
			print("This machine outputs to an external device!")

		# Change our main viewport to output to the HMD
		# and enable foveated rendering
		if xr_capabilities != XRInterface.XR_NONE:
			var viewport := get_viewport()
			viewport.use_xr = true
			viewport.vrs_mode = Viewport.VRS_XR
	else:
		printerr("OpenXR not initialized, please check if your headset is connected!")
