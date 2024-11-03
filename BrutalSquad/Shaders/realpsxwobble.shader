shader_type spatial; 
render_mode skip_vertex_transform, cull_disabled;

//Albedo texture 
uniform sampler2D albedoTex : hint_albedo;
uniform bool paletteswap = false;
//Geometric resolution for vert snap
uniform float snapRes = 50.0; 

//vec4 for UV recalculation 
varying vec4 vertCoord;



void vertex() {
	float snap = snapRes + sin(TIME)*10.0;
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX.xyz = floor(VERTEX.xyz * snap) / snap;
	vertCoord = vec4(UV * VERTEX.z, VERTEX.z, 0); 
} 
 
void fragment() {
	
	ALBEDO = texture(albedoTex, vertCoord.xy / vertCoord.z).rgb;
	if (paletteswap == true){
		ALBEDO.rgb = vec3(ALBEDO.r, ALBEDO.b * 2.0, ALBEDO.g * 0.5);
	}
	
//	vec2 uv = UV;
//	uv.x = clamp(cos(UV.y * 10.0 + tan(TIME*5.0)) * 0.0005 + 1.0, 1.0, 1.5);
//	uv.y = clamp(sin(UV.x * 10.0 + tan(TIME*5.0)) * 0.0005 + 1.0, 1.0, 1.5);
//	ALBEDO = texture(albedoTex, vertCoord.xy *uv).rgb;
}

