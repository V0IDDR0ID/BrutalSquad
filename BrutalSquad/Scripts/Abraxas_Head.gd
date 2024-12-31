extends KinematicBody


onready var right_tail = $"../../BoneAttachment 4/Right_Tail"
onready var left_tail = $"../../BoneAttachment 3/Left_Tail"

var type = 1
var active = false
export  var health = 10
export (String, MULTILINE) var start_message = "N/A"
export (String, MULTILINE) var death_message = "N/A"
var destroyed: bool = false
var damaged: bool = false


func _ready():
	Global.player.UI.message(start_message, false, 666)





func damage(dmg, nrml, pos, shoot_pos):
	if not damaged:
		Global.player.UI.message(death_message, false, 666)
		damaged = true
	Global.UI.set_boss_UI("res://Textures/UI/thumbnails/abraxasboss.tres")
	Global.UI.update_boss_UI(str(health))
	if not active or not left_tail.destroyed or not right_tail.destroyed:
		return 
	health -= dmg
	if health <= 0:
		destroyed = true
		get_parent().get_node("Sphere").hide()
		get_parent().get_node("Particle").show()
func get_type():
	return type
