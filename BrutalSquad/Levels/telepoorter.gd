extends Area








func _ready():
	pass







func _on_telepoorter_body_entered(body):
	
	if body == Global.player:
		body.UI.notify("JUST FUCKIN' DIE", Color(1.0,0.0,0.0))
		body.player_velocity.y = 100
		yield(get_tree().create_timer(3.5), "timeout")
		body.player_velocity.y = -1000
	else :
		body.velocity.y = 100
	$AudioStreamPlayer.play()
