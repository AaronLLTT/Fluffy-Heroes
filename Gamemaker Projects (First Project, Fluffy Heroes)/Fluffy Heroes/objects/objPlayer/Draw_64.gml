/// @description Health
var width = sprite_get_width(sprHeart) / 2;
for(var i = 0; i < currentHealth; ++i) {
	draw_sprite(sprHeart, 0, width + (i * 10), width);
}