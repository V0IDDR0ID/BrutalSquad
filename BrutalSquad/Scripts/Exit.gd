extends Area

export var ending_1: bool = false
export var ending_2: bool = false
export var ending_3: bool = false


func _ready():
	connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body):
	if body.name == "Player" and $"/root/Global".objective_complete:
		if ending_1:
			pass
		if ending_2:
			pass
		if ending_3:
			Global.implants.purchased_implants.append("Cluster of Chaos")
		Global.level_finished()
