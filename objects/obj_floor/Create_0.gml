// Set the Surface
var w = camera_get_view_width(view_camera);
var h = camera_get_view_height(view_camera);
surf = surface_create(w, h);

randomize();

/////////////////////////////////////////////////// RANDOM COLOR
/*R = irandom_range(100, 255);
G = irandom_range(100, 255);
B = irandom_range(100, 255);

rand = irandom_range(1, 3);
switch(rand) {
  case 1:
    R -= irandom(20);
  break;
  case 2:
    G -= irandom(20);
  break;
  case 3:
    B -= irandom(20);
  break;
}

col1 = make_color_rgb(R,G,B);
col2 = make_color_rgb(R-40,G-40,B-40);
col3 = make_color_rgb(R-60,G-60,B-60);*/
/////////////////////////////////////////////////////////////

// Colors for the color limiting / color ramp / call it how you want
col1 = make_color_rgb(90, 93, 115);
col2 = make_color_rgb(99, 103, 127);
col3 = make_color_rgb(79, 82, 102);

// Shader for color limiting with 3 colors
fourlimit_set_colors(col1, col2, col3, col3, true);

// SCRIPT BY    TRIX     ->    https://trixelized.itch.io/gbshader

// you can read Trix's script to learn how it works