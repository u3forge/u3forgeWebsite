shader_type canvas_item;

uniform sampler2D FrontTexture;
uniform sampler2D LeftTexture;
uniform sampler2D BackTexture;
uniform sampler2D RightTexture;
uniform sampler2D TopTexture;
uniform sampler2D BottomTexture;

void fragment() {
	vec3 dir = vec3(0.0);
	float PI = 3.14159265359;
	float rot_y = UV.x * PI * 2.0;
	float rot_z = UV.y * PI;
	
	dir.x = sin(rot_z) * sin(rot_y);
	dir.y = cos(rot_z);
	dir.z = sin(rot_z) * cos(rot_y);
	
	vec3 abs_dir = abs(dir);
	if ((abs_dir.x > abs_dir.y) && (abs_dir.x > abs_dir.z)) {
		// X is biggest, use forward
		float ma = 0.5 / abs_dir.x;
		vec2 uv = dir.zy * ma + 0.5;
		if (dir.x >= 0.0) {
			COLOR = texture(RightTexture, uv);
		} else {
			COLOR = texture(LeftTexture, vec2(1.0 - uv.x, uv.y));
		}
	} else if (abs_dir.y > abs_dir.z) {
		// Y is biggest
		float ma = 0.5 / abs_dir.y;
		vec2 uv = dir.xz * ma + 0.5;
		if (dir.y >= 0.0) {
			COLOR = texture(BottomTexture, uv);
		} else {
			COLOR = texture(TopTexture, vec2(uv.x, 1.0-uv.y));
		}
	} else {
		// Z is biggest
		float ma = 0.5 / abs_dir.z;
		vec2 uv = dir.xy * ma + 0.5;
		if (dir.z >= 0.0) {
			COLOR = texture(BackTexture, vec2(1.0 - uv.x, uv.y));
		} else {
			COLOR = texture(FrontTexture, uv);
		}
	}
}