shader_type spatial; 
render_mode skip_vertex_transform, cull_disabled;

//Albedo texture 
uniform sampler2D albedoTex : hint_albedo;

//Geometric resolution for vert snap
uniform float snapRes = 50.0; 

//vec4 for UV recalculation 
varying vec4 vertCoord;

void vertex() {
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX.xyz = VERTEX.xyz;
	vertCoord = vec4(UV, VERTEX.z, 0); 
} 
 
void fragment() {
	vec2 uv = UV;
	uv.x = cos(UV.y * 10.0 + TIME) * 0.01 + 1.0;
	uv.y = sin(UV.x * 10.0 + TIME) * 0.02 + 1.0;
	ALBEDO = texture(albedoTex, vertCoord.xy *uv).rgb;
	ALPHA = (ALBEDO.g+ALBEDO.r)*2.0;
}