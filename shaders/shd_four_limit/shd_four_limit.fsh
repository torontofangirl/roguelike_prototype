varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;  // position noise


uniform vec3 col_d; // Darkest color
uniform vec3 col_c; // Dark color
uniform vec3 col_b; // Bright color
uniform vec3 col_a; // Brightest color
uniform float rando; // randomness

//////    Noise calcul
float rand( vec2 p, float rando_)
{
    return fract( cos( dot( p, vec2(500.237,900.378)))*rando_)*1.0; // 8463.648 instead of rando_   6.378
}
float noise( vec2 p, float _rando_)
{
    float x1 = rand(vec2(floor(p.x),floor(p.y)), _rando_);
    float x2 = rand(vec2(ceil(p.x),floor(p.y)), _rando_);
    float top = mix(x1,x2,smoothstep(0.0,1.0,fract(p.x)));
    
    x1 = rand(vec2(floor(p.x),ceil(p.y)), _rando_);
    x2 = rand(vec2(ceil(p.x),ceil(p.y)), _rando_);
    float bottom = mix(x1,x2,smoothstep(0.0,1.0,fract(p.x)));
    
    return mix(top,bottom,smoothstep(0.0,1.0,fract(p.y)));
}
//////

void main()
{
	// Noise var calcul
	float n = (noise(v_vPosition/16.0, rando)*0.2 +noise(v_vPosition/32.0, rando)*0.2 +noise(v_vPosition/64.0, rando)*0.3 +noise(v_vPosition/128.0, rando)*0.3 );
	// Noise by Xor Dev
	
	// Get the source color!
	vec4 src = 2.0*texture2D(gm_BaseTexture, v_vTexcoord)-vec4(vec3(n),1.0);
	// as i said, tile*2 - noise
	// method -> https://twitter.com/skslucher
	
	// Now make it black and white
	float col;
	col = ((src.r + src.g + src.b) / 3.0);
	
	
	// Now we'll be using that grayscale color to see how bright it is.
	// Depending on how bright it is, the new color will be applied.
	// Don't worry, these if/else statements are lightning fast!
	
	// This will be the final color that gets returned
	vec3 final;
	
	if (col > 0.6) { //0.5
		
		if (col > 0.7) { //0.75
			// The brightest color
			final.r = col_a.r;
			final.g = col_a.g;
			final.b = col_a.b;
		} else {
			// The bright color
			final.r = col_b.r;
			final.g = col_b.g;
			final.b = col_b.b;
		}
		
	} else {
		
		if (col > 0.25) {
			// The dark color
			final.r = col_c.r;
			final.g = col_c.g;
			final.b = col_c.b;
		} else {
			// The darkest color
			final.r = col_d.r;
			final.g = col_d.g;
			final.b = col_d.b;
		}
		
	}
	
	
	// Now, finally, return the new color!
	gl_FragColor = vec4(vec3(final.rgb), 1.0);
}
