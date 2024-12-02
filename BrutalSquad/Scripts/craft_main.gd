extends Node


export  var implant_name = "Universal Suit"
export  var craft_stages = 2
var craft_stage: int = 0


func stage_craft():
	craft_stage += 1
	check_craft()

func check_craft():
	if craft_stage >= craft_stages:
		finish_craft()

func finish_craft():
	Global.implants.purchased_implants.append(implant_name)
	Global.player.UI.notify(implant_name + " crafted.", Color(0.2, 1, 0))
	Global.save_game()
	queue_free()
