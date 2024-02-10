shader_type spatial;

uniform sampler2D _albedo: source_color;
global uniform vec4 border_color: source_color;
uniform mat4 cutplane;
varying vec3 wvtx;
uniform sampler2D _noise;

void vertex() {
	wvtx = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
}

void fragment() {
	vec3 plane_normal = normalize(-cutplane[1].xyz);
	float plane_distance = dot(plane_normal,cutplane[3].xyz);
	float vertex_distance = dot(plane_normal,wvtx);
	float dist = vertex_distance - plane_distance;
	
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX,1.0);
	vec2 uv = clip_pos.xy/5.0;
	
	uv += TIME * 0.03;
	float noise = texture(_noise,uv).r;
	dist += noise * 0.3;
	
	if (dist < 0.0) discard;
	
	float border_dist = smoothstep(0.0,0.5,dist);
	
	vec4 alb_color = texture(_albedo,UV);
	ALBEDO = (mix(border_color,alb_color,border_dist)).rgb;
	EMISSION = (mix(border_color * 7.0,vec4(0.0),border_dist)).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
