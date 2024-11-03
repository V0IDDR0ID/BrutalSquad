extends Area

enum {SPEED, FLOATY, TOXIC, PSYCHOSIS, CANCER, GRAVITY, HEAL, VOMIT, AMMOREGEN, ARMOR}

export  var pills = false
export  var toxic = false
export  var healing = false
export  var healing_amount = 25
export  var kinematic = false






func _ready():
	pass

func player_use():
	if pills:
		if not Global.implants.head_implant.pills_filter:
			match randi() % 6:
				SPEED:
					Global.player.drug_speed = 50
					get_parent().get_node("Speedup").play()
				FLOATY:
					Global.player.drug_slowfall = 150
					get_parent().get_node("AudioStreamPlayer3D").play()
				TOXIC:
					Global.player.set_toxic()
				PSYCHOSIS:
					Global.player.psychocounter = 200
					get_parent().get_node("AudioStreamPlayer3D").play()
				CANCER:
					Global.player.cancer_count = 9
					Global.player.cancer()
					get_parent().get_node("AudioStreamPlayer3D").play()
				GRAVITY:
					Global.player.drug_gravity_flag = true
					get_parent().get_node("AudioStreamPlayer3D").play()
		if Global.implants.head_implant.pills_filter:
			print("pills are active")
			match (randi() % 4)+6:
				HEAL:
					Global.player.add_health(25)
				VOMIT:
					Global.player.drug_speed = 50
					get_parent().get_node("Vomit").play()
				AMMOREGEN:
					Global.player.weapon.magazine_ammo[0] += 10
					Global.player.weapon.magazine_ammo[1] += 10
					get_parent().get_node("Speedup").play()
				ARMOR:
					Global.player.armor -= 0.1
					get_parent().get_node("AudioStreamPlayer3D").play()
		get_parent().visible = false
		queue_free()
	if healing:
		Global.player.add_health(healing_amount)
		if kinematic:
			get_parent().queue_free()
		queue_free()
	if toxic:
		Global.player.set_toxic()
		queue_free()
	else :
		Global.player.detox()
		queue_free()



