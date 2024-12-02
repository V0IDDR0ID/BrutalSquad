shader_type canvas_item;
uniform bool water = false;
uniform bool drugs = false;
uniform bool nightmare_vision = false;
uniform bool noir_vision = true;
uniform bool rain = false;
uniform bool holy_mode = false;
uniform bool intro = false;
uniform bool scope = false;
uniform float hit_red = 0;
uniform float health_green = 0;
uniform float amplitude = 1;
uniform float gamma = 1.0;
uniform float size_x = 0.001;
uniform float size_y = 0.001;

uniform float u_amount = 1.0;

float get_noise(vec2 uv) {
	//return sin(TIME);
    return fract(sin(dot(uv ,vec2(5.0,0.0))) * 43758.5453);
}

void fragment(){

	
	if (water || drugs){
		vec2 uv = SCREEN_UV;
		uv.x = cos(SCREEN_UV.y * 2.0 + TIME) * 0.02;
		uv.y = sin(SCREEN_UV.x * 4.0 + TIME) * 0.03;
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV + uv);
		if (water) {
		COLOR.r = COLOR.r = floor(COLOR.r*255.0/16.0)/255.0*16.0*0.5 + hit_red - health_green;
		COLOR.g = floor(COLOR.g*255.0/16.0)/255.0*16.0 + health_green;
		COLOR.b = floor(COLOR.b*255.0/16.0)/255.0*16.0 * 2.0 - hit_red;
		} else {
			float old_r = COLOR.r;
			float old_g = COLOR.g;
			float old_b = COLOR.b;
			COLOR.r = old_g;
			COLOR.g = old_r;
		}
	} else if (intro) {
		vec2 uv = SCREEN_UV;
		uv.x = cos(SCREEN_UV.y + TIME+5.0) * amplitude;
		uv.y = sin(SCREEN_UV.x  + TIME) * amplitude;
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV + uv);
		COLOR.r *= 1.0-amplitude;
		COLOR.g *= 1.0 -amplitude;
		COLOR.b *= 1.0 - amplitude;
	} else {
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
		COLOR.r = floor(COLOR.r*255.0/16.0)/255.0*16.0 + hit_red - health_green;
		COLOR.g = floor(COLOR.g*255.0/16.0)/255.0*16.0 + health_green;
		COLOR.b = floor(COLOR.b*255.0/16.0)/255.0*16.0 - hit_red;
	}
	
	if (scope == true) {
		COLOR.r *= 0.1;
		COLOR.g *= 10.0;
		COLOR.b *= 0.1;
	}
	if (noir_vision == true) {
		/*COLOR.r = COLOR.g;
		COLOR.g = COLOR.g;
		COLOR.b = COLOR.g;*/
		float avg = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
		COLOR.rgb = vec3(avg);
	}
	if (holy_mode == true) {
		vec2 uv = SCREEN_UV;
		uv -= mod(uv, vec2(0.002, 0.002));
		COLOR.rgb = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
		COLOR.r = 1.0-step(COLOR.r-0.5,0.01);
		COLOR.g =  1.0-step(COLOR.g-0.5,0.01);
		COLOR.b = 1.0-step(COLOR.b-0.5,0.01);
	}
	if (nightmare_vision == true) {
		float init_r = round(min(COLOR.r, 0.9))*100.0;
		COLOR.r =  round(sin(UV.x*UV.y* TIME *1000.0));
		COLOR.r = round(COLOR.r);
		COLOR.g = round(COLOR.g*10.0)/10.0 * 0.5 / COLOR.r;
		COLOR.b = round(COLOR.b*10.0)/10.0 * 0.5;
		COLOR.rgb *= 0.05;
		COLOR.r += init_r;
		COLOR.rgb *= -1.0;
		COLOR.r = step(COLOR.r+COLOR.b+COLOR.g, 0.5);
		COLOR.b = 0.0;
		COLOR.g = 0.0;
	}
	if (gamma != 1.0){
	float gamma_correction = 1.0/gamma;
	COLOR.r = clamp(COLOR.r,0.0,1.0);
	COLOR.b = clamp(COLOR.b,0.0,1.0);
	COLOR.g = clamp(COLOR.g,0.0,1.0);
	COLOR.r = 1.0 * pow((COLOR.r / 1.0), gamma_correction);
	COLOR.g = 1.0 * pow((COLOR.g / 1.0), gamma_correction);
	COLOR.b = 1.0 * pow((COLOR.b / 1.0), gamma_correction);

	}
	float n = 2.0 * get_noise(UV + vec2(TIME*5.0, 0.0)) - 1.0;
	float alph = COLOR.a;
    COLOR = COLOR + n * u_amount;
	COLOR.a = alph;
//	vec2 uv = SCREEN_UV;
//	uv -= mod(uv, vec2(size_x, size_y));
//
//	COLOR.rgb = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
		
    
	
//	COLOR.r = round(COLOR.r*20.0)*0.063;
//	COLOR.g = round(COLOR.g*30.0)*0.043;
//	COLOR.b = round(COLOR.b*20.0)*0.063;
}