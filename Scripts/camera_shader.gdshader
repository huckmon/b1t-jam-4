shader_type canvas_item;

//uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform vec4 black : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 white : source_color = vec4(1.0, 1.0, 1.0, 1.0);

uniform vec3 replacement_color : source_color;
uniform vec3 replacement_color2 : source_color;

void fragment() {
	
	vec4 new_color = texture(screen_texture, SCREEN_UV, 0.0);
	if(distance(new_color, black) > 0.01){
		COLOR.rgb = replacement_color.rgb;
	}
	if(distance(new_color, white) > 0.01){
		COLOR.rgb = replacement_color2.rgb;
	}
	else{
		COLOR.rgb = COLOR.rgb;
	}
}
