extends Spatial


func _ready():
	if not Global.high_performance:
		hide()
		print("Occlusion disabled.")
