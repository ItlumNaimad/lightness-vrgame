shader_type canvas_item;

uniform float glitch_intensity : hint_range(0.0, 1.0) = 0.0;
uniform float color_split_dist : hint_range(0.0, 0.06) = 0.02;
uniform float scanline_density : hint_range(10.0, 300.0) = 140.0;
uniform float block_size : hint_range(0.01, 0.2) = 0.04;
uniform vec2 jitter_offset = vec2(0.0, 0.0);

float hash(vec2 p) {
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453123);
}

void vertex() {
	VERTEX += jitter_offset;
}

void fragment() {
	vec2 uv = UV;
	
	if (glitch_intensity > 0.005) {
		// 1. Horizontal slice displacement (Block Tearing)
		float block = floor(uv.y / block_size);
		float time_step = floor(TIME * 20.0);
		float noise = hash(vec2(block, time_step));
		
		if (noise < glitch_intensity * 0.75) {
			float slice_offset = (noise - 0.5) * 0.08 * glitch_intensity;
			uv.x += slice_offset;
		}
		
		// 2. Chromatic Aberration / RGB Split
		float split = color_split_dist * glitch_intensity;
		float r = texture(TEXTURE, uv + vec2(split, 0.0)).r;
		vec4 center = texture(TEXTURE, uv);
		float g = center.g;
		float b = texture(TEXTURE, uv - vec2(split, 0.0)).b;
		
		// Preserve alpha coverage across split channels
		float a_r = texture(TEXTURE, uv + vec2(split, 0.0)).a;
		float a_b = texture(TEXTURE, uv - vec2(split, 0.0)).a;
		float a = max(center.a, max(a_r, a_b));
		
		// 3. Scanline grid effect
		float scanline = sin(uv.y * scanline_density * 3.14159) * 0.5 + 0.5;
		vec3 final_rgb = mix(vec3(r, g, b), vec3(r, g, b) * (0.8 + 0.2 * scanline), glitch_intensity * 0.5);
		
		// Subtle digital noise grain
		float grain = hash(uv + vec2(TIME, -TIME)) * 0.08 * glitch_intensity;
		final_rgb += vec3(grain);
		
		COLOR = vec4(final_rgb, a) * COLOR;
	} else {
		COLOR = texture(TEXTURE, UV) * COLOR;
	}
}
