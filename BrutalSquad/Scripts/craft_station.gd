extends Area


export  var implant_name = "Hazmat Suit"
var usable: bool = false


func _ready():
	for i in Global.implants.IMPLANTS:
		if i.i_name == implant_name:
			var new_mat = $implant_object / Cube.mesh.surface_get_material(1).duplicate()
			new_mat.albedo_texture = i.texture
			$implant_object / Cube.set_surface_material(1, new_mat)
			usable = true

func player_use():
	if usable:
		get_parent().get_parent().stage_craft()
		queue_free()
