shader_type canvas_item;

uniform float uv_scale : hint_range(0.0, 5.0, 0.1) = 0.5;
varying vec2 world_uv;

void vertex() {
	UV.x += TIME * 0.5;
}

void fragment() {
	COLOR = texture(TEXTURE, UV * uv_scale);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
