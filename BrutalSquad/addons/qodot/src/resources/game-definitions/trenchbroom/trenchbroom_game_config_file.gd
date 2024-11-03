class_name TrenchBroomGameConfigFile
extends Resource
tool 

export (bool) var export_file: bool setget set_export_file
export (String, FILE, GLOBAL, "*.cfg") var target_file: String

export (Array, Resource) var brush_tags: Array = []
export (Array, Resource) var face_tags: Array = []
export (Array, Resource) var face_attrib_surface_flags: Array = []
export (Array, Resource) var face_attrib_content_flags: Array = []

export (Array, String) var fgd_filenames: Array = []

var base_text: String = 











































"{\n	version: 3,\n	name: \"Qodot\",\n	icon: \"Icon.png\",\n	\"fileformats\": [\n		{ \"format\": \"Standard\", \"initialmap\": \"initial_standard.map\" },\n		{ \"format\": \"Valve\", \"initialmap\": \"initial_valve.map\" },\n		{ \"format\": \"Quake2\", \"initialmap\": \"initial_quake2.map\" },\n		{ \"format\": \"Quake3\" },\n		{ \"format\": \"Quake3 (legacy)\" },\n		{ \"format\": \"Hexen2\" },\n		{ \"format\": \"Daikatana\" }\n	],\n	\"filesystem\": {\n		\"searchpath\": \".\",\n		\"packageformat\": { \"extension\": \"pak\", \"format\": \"idpak\" }\n	},\n	\"textures\": {\n		\"package\": { \"type\": \"directory\", \"root\": \"textures\" },\n		\"format\": { \"extensions\": [\"bmp\", \"exr\", \"hdr\", \"jpeg\", \"jpg\", \"png\", \"tga\", \"webp\"], \"format\": \"image\" },\n		\"attribute\": \"_tb_textures\"\n	},\n	\"entities\": {\n		\"definitions\": [ %s ],\n		\"defaultcolor\": \"0.6 0.6 0.6 1.0\",\n		\"modelformats\": [ \"mdl\", \"md2\", \"md3\", \"bsp\", \"dkm\" ]\n	},\n	\"tags\": {\n		\"brush\": [\n			%s\n		],\n		\"brushface\": [\n			%s\n		]\n	},\n	\"faceattribs\": {\n		\"surfaceflags\": [\n			%s\n		],\n		\"contentflags\": [\n			%s\n		]\n	}\n}\n"

func set_export_file(new_export_file: bool = true)->void :
	if new_export_file != export_file:
		if not Engine.is_editor_hint():
			return 

		if not target_file:
			print("Skipping export: No target file")
			return 

		print("Exporting TrenchBroom Game Config File to ", target_file)
		var file_obj: = File.new()
		file_obj.open(target_file, File.WRITE)
		file_obj.store_string(build_class_text())
		file_obj.close()

func build_class_text()->String:
	var fgd_filename_str: = ""
	for fgd_filename in fgd_filenames:
		fgd_filename_str += "\"%s\"" % fgd_filename
		if fgd_filename != fgd_filenames[ - 1]:
			fgd_filename_str += ", "

	var brush_tags_str = parse_tags(brush_tags)
	var face_tags_str = parse_tags(face_tags)
	var surface_flags_str = parse_flags(face_attrib_surface_flags)
	var content_flags_str = parse_flags(face_attrib_content_flags)

	return base_text % [
		fgd_filename_str, 
		brush_tags_str, 
		face_tags_str, 
		surface_flags_str, 
		content_flags_str
	]

static func get_match_key(tag_match_type: int)->String:
	var tag_keys = {
		0: "texture", 
		1: "contentflag", 
		2: "surfaceflag", 
		3: "surfaceparm", 
		4: "classname"
	}

	return tag_keys[tag_match_type]

func parse_tags(tags: Array)->String:
	var tags_str: = ""
	for brush_tag in tags:
		tags_str += "{\n"
		tags_str += "				\"name\": \"%s\",\n" % brush_tag.tag_name

		var attribs_str: = ""
		for brush_tag_attrib in brush_tag.tag_attributes:
			attribs_str += "\"%s\"" % brush_tag_attrib
			if brush_tag_attrib != brush_tag.tag_attributes[ - 1]:
				attribs_str += ", "

		tags_str += "				\"attribs\": [ %s ],\n" % attribs_str

		tags_str += "				\"match\": \"%s\",\n" % get_match_key(brush_tag.tag_match_type)
		tags_str += "				\"pattern\": \"%s\"" % brush_tag.tag_pattern

		if brush_tag.texture_name != "":
			tags_str += ",\n"
			tags_str += "				\"texture\": \"%s\"" % brush_tag.texture_name

		tags_str += "\n"

		tags_str += "			}"

		if brush_tag != tags[ - 1]:
			tags_str += ","

	return tags_str

func parse_flags(flags: Array)->String:
	var flags_str: = ""

	for attrib_flag in flags:
		flags_str += "{\n"
		flags_str += "				\"name\": \"%s\",\n" % attrib_flag.attrib_name
		flags_str += "				\"description\": \"%s\"\n" % attrib_flag.attrib_description
		flags_str += "			}"
		if attrib_flag != flags[ - 1]:
			flags_str += ","

	return flags_str
