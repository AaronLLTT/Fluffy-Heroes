/// @description Draw the Text
draw_self();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fntMenu);
draw_set_color(c_white);

draw_text_transformed(x, y + 1, myText, .5, .5, 0);