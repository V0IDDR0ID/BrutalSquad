class_name QodotFGDSolidClass
extends QodotFGDClass
tool 

enum SpawnType{
	WORLDSPAWN = 0, 
	MERGE_WORLDSPAWN = 1, 
	ENTITY = 2, 
	GROUP = 3
}

enum CollisionShapeType{
	NONE, 
	CONVEX, 
	CONCAVE
}



export (String) var spawn: String = QodotUtil.CATEGORY_STRING
export (SpawnType) var spawn_type: int = SpawnType.ENTITY


export (String) var visual_build: String = QodotUtil.CATEGORY_STRING
export (bool) var build_visuals: = true


export (String) var collision_build: String = QodotUtil.CATEGORY_STRING
export (CollisionShapeType) var collision_shape_type: int = CollisionShapeType.CONVEX




export (String) var scripting: String = QodotUtil.CATEGORY_STRING
export (Script) var script_class: Script

func _init()->void :
	prefix = "@SolidClass"
