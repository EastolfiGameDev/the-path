shader_type canvas_item;

uniform sampler2D noise;
const float multiplier = 0.4f;
const float base_threshold = 0.4f;
const float red = 0.4f;
const float yellow = 0.5f;
const float white = 0.6f;

void fragment() {
    vec4 base = texture(TEXTURE, UV);
    vec4 _noise = texture(noise, vec2(UV.x, UV.y + TIME));
    
    base.r += multiplier - distance(vec2(0.5, UV.y), UV);
    base.r = (base.r * 0.3) + _noise.r * multiplier;
    
    COLOR = vec4(float(base.r > red), float(base.r > yellow), float(base.r > white), float(base.r > base_threshold));
}