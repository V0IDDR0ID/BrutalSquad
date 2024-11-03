class_name QodotFGDPointClass
extends QodotFGDClass
tool 

func _init()->void :
	prefix = "@PointClass"

export (String) var scene: String = QodotUtil.CATEGORY_STRING



export (PackedScene) var scene_file: PackedScene

export (String) var scripting: String = QodotUtil.CATEGORY_STRING




export (Script) var script_class: Script
