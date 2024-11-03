shader_type spatial; 
render_mode skip_vertex_transform, unshaded;

//Albedo texture 
uniform sampler2D albedoTex : hint_albedo;

//Geometric resolution for vert snap
uniform float snapRes = 400.0; 

//vec4 for UV recalculation 
varying vec4 vertCoord;

void vertex() {
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX.xyz += sin(VERTEX.z * TIME * 2.0) * 0.1;
	VERTEX.xyz += sin(VERTEX.x * TIME * 150.0) * 0.1;
	VERTEX.xyz += sin(VERTEX.y * TIME * 100.0) * 0.1;
	vertCoord = vec4(UV * VERTEX.z, VERTEX.z, 0); 
} 
 
void fragment() {
	ALBEDO = texture(albedoTex, vertCoord.xy / vertCoord.z).rgb;
	ALPHA = texture(albedoTex, vertCoord.xy / vertCoord.z).a;
}